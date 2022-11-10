import 'package:flutter/material.dart';

enum TabType { top, bottom }

///支持顶部和底部的TabBar控件
class TabBarWidget extends StatefulWidget {
  final TabType type;
  final List<Widget> tabItems;
  final Widget? drawer;
  final Widget? title;
  final List<Widget> tabViews;
  final ValueChanged<int>? onPageChanged;
  final ValueChanged<int>? onSinglePress;
  final Color? indicatorColor;
  final bool resizeToAvoidBottomPadding;
  final Widget? floatingActionButton;
  final FloatingActionButtonLocation? floatingActionButtonLocation;
  final List<Widget>? footerButtons;
  final Widget? bottomBar;

  const TabBarWidget({
    Key? key,
    required this.tabItems,
    this.type = TabType.top,
    this.drawer,
    this.title,
    required this.tabViews,
    this.onPageChanged,
    this.indicatorColor,
    this.onSinglePress,
    this.resizeToAvoidBottomPadding = true,
    this.floatingActionButton,
    this.floatingActionButtonLocation,
    this.footerButtons,
    this.bottomBar,
  }) : super(key: key);

  @override
  State<TabBarWidget> createState() => _TabBarWidgetState();
}

class _TabBarWidgetState extends State<TabBarWidget>
    with SingleTickerProviderStateMixin {
  final PageController _pageController = PageController();

  late TabController _tabController;

  int _index = 0;

  @override
  void initState() {
    super.initState();
    //初始化时创建控制器
    _tabController = TabController(length: widget.tabItems.length, vsync: this);
  }

  _navigationPageChanged(index) {
    if (_index == index) {
      return;
    }
    _index = index;
    _tabController.animateTo(index);
    widget.onPageChanged?.call(index);
  }

  _navigationTapClick(index) {
    if (_index == index) {
      return;
    }
    _index = index;
    widget.onPageChanged?.call(index);

    //不想要动画
    _pageController.jumpTo(MediaQuery.of(context).size.width * index);
    widget.onSinglePress?.call(index);
  }

  @override
  Widget build(BuildContext context) {
    if (widget.type == TabType.top) {
      //顶部TabBar
      return Scaffold(
        resizeToAvoidBottomInset: widget.resizeToAvoidBottomPadding,
        //悬浮按钮
        floatingActionButton:
            SafeArea(child: widget.floatingActionButton ?? Container()),
        //悬浮按钮位置
        floatingActionButtonLocation: widget.floatingActionButtonLocation,
        //显示在底部导航条上方的一组按钮
        persistentFooterButtons: widget.footerButtons,
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          title: widget.title,
          bottom: TabBar(
            controller: _tabController,
            tabs: widget.tabItems,
            indicatorColor: widget.indicatorColor,
            onTap: _navigationTapClick,
          ),
        ),
        body: PageView(
          controller: _pageController,
          onPageChanged: _navigationPageChanged,
          children: widget.tabViews,
        ),
        bottomNavigationBar: widget.bottomBar,
      );
    }
    //底部TabBar
    return Scaffold(
      drawer: widget.drawer,
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: widget.title,
      ),
      body: PageView(
        controller: _pageController,
        onPageChanged: _navigationPageChanged,
        children: widget.tabViews,
      ),
      bottomNavigationBar: Material(
        //为了适配主题风格，包一层Material实现风格套用
        color: Theme.of(context).primaryColor,
        //safearea处理异形屏适配问题
        child: SafeArea(
          child: TabBar(
            controller: _tabController,
            tabs: widget.tabItems,
            indicatorColor: widget.indicatorColor,
            onTap: _navigationTapClick,
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    //页面销毁时，销毁控制器
    _tabController.dispose();
    super.dispose();
  }
}
