import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:gsy_app_test/common/localization/default_localizations.dart';
import 'package:gsy_app_test/common/net/address.dart';
import 'package:gsy_app_test/common/style/style.dart';
import 'package:gsy_app_test/common/utils/navigator_utils.dart';
import 'package:gsy_app_test/page/issue/issue_edit_dIalog.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

typedef StringList = List<String>;

class CommonUtils {
  static final double MILLIS_LIMIT = 1000.0;

  static final double SECONDS_LIMIT = 60 * MILLIS_LIMIT;

  static final double MINUTES_LIMIT = 60 * SECONDS_LIMIT;

  static final double HOURS_LIMIT = 24 * MINUTES_LIMIT;

  static final double DAYS_LIMIT = 30 * HOURS_LIMIT;

  static Locale? curLocale;

  static Future<Null> showLoadingDialog(BuildContext context) {
    return NavigatorUtils.showCommonDialog(
        context: context,
        builder: (context) {
          return Material(
            color: Colors.transparent,
            child: WillPopScope(
              onWillPop: () => Future.value(false),
              child: Center(
                child: Container(
                  width: 200,
                  height: 200,
                  padding: const EdgeInsets.all(4),
                  decoration: const BoxDecoration(
                    color: Colors.transparent,
                    //用一个BoxDecoration装饰器提供背景图片
                    borderRadius: BorderRadius.all(Radius.circular(4)),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        child: const SpinKitCubeGrid(
                          color: ColorUtil.white,
                        ),
                      ),
                      Container(
                        height: 10,
                      ),
                      Container(
                        child: Text(
                          BaseLocalizations.i18n(context)!.loading_text,
                          style: TextConstant.normalTextWhite,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }

  static Future<Null> showEditDialog(
    BuildContext context,
    String dialogTitle,
    ValueChanged<String>? onTitleChanged,
    ValueChanged<String> onContentChanged,
    VoidCallback onPressed, {
    TextEditingController? titleController,
    TextEditingController? valueController,
    bool needTitle = true,
  }) {
    return NavigatorUtils.showCommonDialog(
        context: context,
        builder: (BuildContext context) {
          return Center(
            child: IssueEditDialog(
              dialogTitle,
              onTitleChanged,
              onContentChanged,
              onPressed,
              titleController: titleController,
              valueController: valueController,
              needTitle: needTitle,
            ),
          );
        });
  }

  //版本更新
  static Future<Null> showUpdateDialog(
      BuildContext context, String contentMsg) {
    return NavigatorUtils.showCommonDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(BaseLocalizations.i18n(context)!.app_version_title),
            content: Text(contentMsg),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(BaseLocalizations.i18n(context)!.app_cancel)),
              TextButton(
                  onPressed: () {
                    launchUrlString(Address.updateUrl);
                    Navigator.pop(context);
                  },
                  child: Text(BaseLocalizations.i18n(context)!.app_ok)),
            ],
          );
        });
  }
}
