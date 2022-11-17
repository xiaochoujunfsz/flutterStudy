import 'package:flutter/material.dart';
import 'package:gsy_app_test/common/config/config.dart';
import 'package:gsy_app_test/widget/pull/pull_load_widget.dart';

//上下拉刷新列表的通用state
mixin CommonListState<T extends StatefulWidget>
    on State<T>, AutomaticKeepAliveClientMixin<T> {
  bool isShow = false;
  bool isLoading = false;
  int page = 1;
  bool isRefreshing = false;
  bool isLoadingMore = false;
  final List dataList = [];
  final PullLoadWidgetControl pullLoadWidgetControl = PullLoadWidgetControl();
  final GlobalKey<RefreshIndicatorState> refreshIndicatorKey = GlobalKey();

  List get getDataList => dataList;

  //是否需要保持
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    isShow = true;
    super.initState();
    pullLoadWidgetControl.needHeader = needHeader;
    pullLoadWidgetControl.dataList = getDataList;
    if (pullLoadWidgetControl.dataList.isEmpty && isRefreshFirst) {
      showRefreshLoading();
    }
  }

  @override
  void dispose() {
    isShow = false;
    isLoading = false;
    super.dispose();
  }

  @protected
  resolveRefreshResult(res) {
    if (res != null && res.result) {
      pullLoadWidgetControl.dataList.clear();
      if (isShow) {
        setState(() {
          pullLoadWidgetControl.dataList.addAll(res.data);
        });
      }
    }
  }

  @protected
  Future<void> handleRefresh() async {
    if (isLoading) {
      if (isRefreshing) {
        return;
      }
      await _lockToAwait();
    }
    isLoading = true;
    isRefreshing = true;
    page = 1;
    var res = await requestRefresh();
    resolveRefreshResult(res);
    resolveDataResult(res);
    if (res.next != null) {
      var resNext = await res.next();
      resolveRefreshResult(resNext);
      resolveDataResult(resNext);
    }
    isLoading = false;
    isRefreshing = false;
  }

  @protected
  Future<void> onLoadMore() async {
    if (isLoading) {
      if (isLoadingMore) {
        return;
      }
      await _lockToAwait();
    }
    isLoading = true;
    isLoadingMore = true;
    page++;
    var res = await requestLoadMore();
    if (res != null && res.result) {
      if (isShow) {
        setState(() {
          pullLoadWidgetControl.dataList.addAll(res.data);
        });
      }
    }
    resolveDataResult(res);
    isLoading = false;
    isLoadingMore = false;
  }

  @protected
  resolveDataResult(res) {
    if (isShow) {
      setState(() {
        pullLoadWidgetControl.needLoadMore.value = (res != null &&
            res.data != null &&
            res.data.length >= Config.PAGE_SIZE);
      });
    }
  }

  @protected
  clearData() {
    if (isShow) {
      setState(() {
        pullLoadWidgetControl.dataList.clear();
      });
    }
  }

  //下拉刷新数据
  @protected
  requestRefresh() async {}

  //上拉更多请求数据
  @protected
  requestLoadMore() async {}

  //是否需要第一次进入自动刷新
  @protected
  bool get isRefreshFirst;

  //是否需要头部
  @protected
  bool get needHeader => false;

  _lockToAwait() async {
    doDelayed() async {
      await Future.delayed(const Duration(seconds: 1)).then((_) async {
        if (isLoading) {
          return await doDelayed();
        } else {
          return null;
        }
      });
    }

    await doDelayed();
  }

  showRefreshLoading() {
    Future.delayed(const Duration(seconds: 0), () {
      refreshIndicatorKey.currentState!.show().then((value) {});
      return true;
    });
  }
}
