//导航栏
import 'package:flutter/material.dart';
import 'package:gsy_app_test/widget/never_overscroll_indicator.dart';

class NavigatorUtils {
  //弹出dialog
  static Future<T?> showCommonDialog<T>({
    required BuildContext context,
    bool barrierDismissible = true,
    WidgetBuilder? builder,
  }) {
    return showDialog<T>(
        context: context,
        //控制弹窗点击空白区域是否可以关闭弹窗
        barrierDismissible: barrierDismissible,
        builder: (context) {
          return MediaQuery(
              //不受系统字体缩放影响
              data: MediaQueryData.fromWindow(WidgetsBinding.instance.window)
                  .copyWith(textScaleFactor: 1),
              child: NeverOverScrollIndicator(
                needOverload: false,
                child: SafeArea(
                  child: builder!(context),
                ),
              ));
        });
  }
}
