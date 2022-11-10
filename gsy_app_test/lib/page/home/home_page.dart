import 'dart:io';

import 'package:android_intent_plus/android_intent.dart';
import 'package:flutter/material.dart';
import 'package:gsy_app_test/common/localization/default_localizations.dart';
import 'package:gsy_app_test/common/style/style.dart';
import 'package:gsy_app_test/page/dynamic/dynamic_page.dart';
import 'package:gsy_app_test/page/home/widget/home_drawer.dart';
import 'package:gsy_app_test/widget/tabbar_widget.dart';
import 'package:gsy_app_test/widget/title_bar.dart';

import '../my_page.dart';
import '../trend/trend_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<DynamicPageState> dynamicKey = new GlobalKey();
  final GlobalKey<TrendPageState> trendKey = new GlobalKey();
  final GlobalKey<MyPageState> myKey = new GlobalKey();

  //不退出
  Future<bool> _dialogExitApp(BuildContext context) async {
    //如果是android回到桌面
    if (Platform.isAndroid) {
      AndroidIntent intent = const AndroidIntent(
        action: 'android.intent.action.MAIN',
        category: "android.intent.category.HOME",
      );
      await intent.launch();
    }
    return Future.value(false);
  }

  _renderTab(icon, text) {
    return Tab(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 16.0,
          ),
          Text(text)
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> tabs = [
      _renderTab(
          IconUtil.MAIN_DT, BaseLocalizations.i18n(context)?.home_dynamic),
      _renderTab(IconUtil.MAIN_QS, BaseLocalizations.i18n(context)?.home_trend),
      _renderTab(IconUtil.MAIN_MY, BaseLocalizations.i18n(context)?.home_my),
    ];
    return WillPopScope(
        child: TabBarWidget(
          drawer: HomeDrawer(),
          type: TabType.top,
          tabItems: tabs,
          tabViews: [
            DynamicPage(
              key: dynamicKey,
            ),
            TrendPage(
              key: trendKey,
            ),
            MyPage(
              key: myKey,
            ),
          ],
          indicatorColor: ColorUtil.white,
          title: TitleBar(
            BaseLocalizations.of(context)!.currentLocalized!.app_name,
            iconData: IconUtil.MAIN_SEARCH,
            needRightLocalIcon: true,
            onRightIconPressed: (centerPosition) {

            },
          ),
        ),
        onWillPop: () {
          return _dialogExitApp(context);
        });
  }
}
