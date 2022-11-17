import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:gsy_app_test/common/localization/default_localizations.dart';
import 'package:gsy_app_test/common/style/style.dart';

//通用下拉刷新控件
class PullLoadWidget extends StatefulWidget {
  final Key? refreshKey;

  //下拉刷新回调
  final RefreshCallback? onRefresh;

  //加载更多回调
  final RefreshCallback? onLoadMore;

  //控制器
  final PullLoadWidgetControl? control;

  //item渲染
  final IndexedWidgetBuilder itemBuilder;

  PullLoadWidget(
    this.onRefresh,
    this.onLoadMore,
    this.control,
    this.itemBuilder, {
    this.refreshKey,
  });

  @override
  State<PullLoadWidget> createState() => _PullLoadWidgetState();
}

class _PullLoadWidgetState extends State<PullLoadWidget> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    widget.control?.needLoadMore.addListener(() {
      //延迟两秒等待确认
      try {
        Future.delayed(const Duration(seconds: 2), () {
          _scrollController.notifyListeners();
        });
      } catch (e) {
        print(e);
      }
    });
    //增加滑动监听
    _scrollController.addListener(() {
      //判断当前滑动位置是不是达到底部，触发加载更多回调
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        if (widget.control?.needLoadMore.value == true) {
          widget.onLoadMore?.call();
        }
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      //GlobalKey，用户外部获取RefreshIndicator的State，做显示刷新
      key: widget.refreshKey,
      //下拉刷新触发，返回的是一个Future
      onRefresh: widget.onRefresh ?? () async {},
      child: ListView.builder(
        //保持ListView任何情况都能滚动，解决在RefreshIndicator的兼容问题。
        physics: const AlwaysScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return _getItem(index);
        },
        itemCount: _getListCount(),
        //滑动监听
        controller: _scrollController,
      ),
    );
  }

  //上拉加载更多
  Widget _buildProgressIndicator() {
    //是否需要显示上拉加载更多的loading
    Widget bottomWidget = (widget.control!.needLoadMore.value)
        ? Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //loading框
              const SpinKitRotatingCircle(
                color: Color(0xFF24292E),
              ),
              Container(
                width: 5,
              ),
              //加载中文本
              Text(
                BaseLocalizations.i18n(context)!.load_more_text,
                style: const TextStyle(
                  color: Color(0xFF121917),
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              )
            ],
          )
        : Container();
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Center(
        child: bottomWidget,
      ),
    );
  }

  //空页面
  Widget _buildEmpty() {
    return Container(
      height: MediaQuery.of(context).size.height - 100,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextButton(
            onPressed: () {},
            child: const Image(
              image: AssetImage(IconUtil.DEFAULT_USER_ICON),
              width: 70,
              height: 70,
            ),
          ),
          Text(
            BaseLocalizations.i18n(context)!.app_empty,
            style: TextConstant.normalText,
          ),
        ],
      ),
    );
  }

  //根据配置状态返回实际列表渲染Item
  _getItem(int index) {
    if (!widget.control!.needHeader &&
        index == widget.control!.dataList.length &&
        widget.control!.dataList.isNotEmpty) {
      //如果不需要头部，并且数据不为0，当index等于数据长度时，渲染加载更多Item（因为index是从0开始）
      return _buildProgressIndicator();
    } else if (widget.control!.needHeader &&
        index == _getListCount() - 1 &&
        widget.control!.dataList.isNotEmpty) {
      //如果需要头部，并且数据不为0，当index等于实际渲染长度 - 1时，渲染加载更多Item（因为index是从0开始）
      return _buildProgressIndicator();
    } else if (!widget.control!.needHeader &&
        widget.control!.dataList.isEmpty) {
      //如果不需要头部，并且数据为0，渲染空页面
      return _buildEmpty();
    } else {
      //回调外部正常渲染Item，如果这里有需要，可以直接返回相对位置的index
      return widget.itemBuilder(context, index);
    }
  }

  //根据配置状态返回实际列表数量
  _getListCount() {
    //是否需要头部
    if (widget.control!.needHeader) {
      //如果需要头部，用Item 0 的 Widget 作为ListView的头部,列表数量大于0时，因为头部和底部加载更多选项，需要对列表数据总数+2
      return (widget.control!.dataList.isNotEmpty)
          ? widget.control!.dataList.length + 2
          : widget.control!.dataList.length + 1;
    } else {
      //如果不需要头部，在没有数据时，固定返回数量1用于空页面呈现
      if (widget.control!.dataList.isEmpty) {
        return 1;
      }
      //如果有数据,因为部加载更多选项，需要对列表数据总数+1
      return widget.control!.dataList.length + 1;
    }
  }
}

class PullLoadWidgetControl {
  //数据，对齐增减，不能替换
  List dataList = [];

  //是否需要加载更多
  ValueNotifier<bool> needLoadMore = ValueNotifier(false);

  //是否需要头部
  bool needHeader = false;
}
