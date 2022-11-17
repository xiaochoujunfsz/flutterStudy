import 'package:flutter/material.dart';
import 'package:gsy_app_test/widget/pull/pull_load_widget.dart';
import 'package:gsy_app_test/widget/state/list_state.dart';

//通用list
class CommonListPage extends StatefulWidget {
  final String? userName;

  final String? reposName;

  final String showType;

  final String dataType;

  final String? title;

  CommonListPage(this.title, this.showType, this.dataType,
      {this.userName, this.reposName});

  @override
  State<CommonListPage> createState() => _CommonListPageState();
}

class _CommonListPageState extends State<CommonListPage>
    with
        AutomaticKeepAliveClientMixin<CommonListPage>,
        CommonListState<CommonListPage> {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title ?? "",
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ),
      body: PullLoadWidget(
        handleRefresh,
        onLoadMore,
        pullLoadWidgetControl,
        (BuildContext context, int index) => _renderItem(index),
        refreshKey: refreshIndicatorKey,
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;

  @override
  bool get isRefreshFirst => true;

  _renderItem(index) {
    if (pullLoadWidgetControl.dataList.isEmpty) {
      return null;
    }
    var data = pullLoadWidgetControl.dataList[index];
    switch (widget.showType) {
      case 'issue':
        return null;
      case 'release':
        return null;
      case 'notify':
        return null;
    }
  }
}
