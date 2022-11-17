import 'package:flutter/material.dart';
import 'package:gsy_app_test/common/localization/default_localizations.dart';
import 'package:gsy_app_test/common/net/interceptors/log_interceptor.dart';
import 'package:gsy_app_test/common/style/style.dart';
import 'package:gsy_app_test/common/utils/common_utils.dart';

class ErrorPage extends StatefulWidget {
  final String errorMessage;
  final FlutterErrorDetails details;

  ErrorPage(this.errorMessage, this.details);

  @override
  State<ErrorPage> createState() => _ErrorPageState();
}

class _ErrorPageState extends State<ErrorPage> {
  static List<Map<String, dynamic>?> sErrorStack = [];
  static List<String?> sErrorName = [];

  final TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double width =
        MediaQueryData.fromWindow(WidgetsBinding.instance.window).size.width;
    return Container(
      color: ColorUtil.primaryValue,
      child: Center(
        child: Container(
          alignment: Alignment.center,
          width: width,
          height: width,
          decoration: BoxDecoration(
            color: Colors.white.withAlpha(100),
            // gradient: RadialGradient(
            //     tileMode: TileMode.mirror,
            //     radius: 0.1,
            //     colors: [
            //       Colors.white.withAlpha(10),
            //       ColorUtil.primaryValue.withAlpha(100)
            //     ]),
            // borderRadius: BorderRadius.all(Radius.circular(width / 2)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Image(
                image: AssetImage(IconUtil.DEFAULT_USER_ICON),
                width: 90,
                height: 90,
              ),
              const SizedBox(
                height: 11,
              ),
              const Material(
                color: ColorUtil.primaryValue,
                child: Text(
                  "Error Occur",
                  style: TextStyle(fontSize: 24, color: Colors.white),
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () {
                      String content = widget.errorMessage;
                      textEditingController.text = content;
                      CommonUtils.showEditDialog(
                          context,
                          BaseLocalizations.i18n(context)!.home_reply,
                          (value) {}, (value) {
                        content = value;
                      }, () {
                        if (content.isEmpty) {
                          return;
                        }
                        CommonUtils.showLoadingDialog(context);
                      });
                    },
                    style: TextButton.styleFrom(
                        backgroundColor: ColorUtil.white.withAlpha(100)),
                    child: const Text("Report"),
                  ),
                  const SizedBox(
                    width: 40,
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    style: TextButton.styleFrom(
                        backgroundColor: Colors.white.withAlpha(100)),
                    child: const Text("Back"),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  addError(FlutterErrorDetails details) {
    try {
      var map = Map<String, dynamic>();
      map["error"] = details.toString();
      LogInterceptor.addLogic(
          sErrorName, details.exception.runtimeType.toString());
      LogInterceptor.addLogic(sErrorStack, map);
    } catch (e) {
      print(e);
    }
  }
}
