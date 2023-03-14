import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gsy_app_test/env/config_wrapper.dart';
import 'package:gsy_app_test/env/dev.dart';
import 'package:gsy_app_test/env/env_config.dart';
import 'package:gsy_app_test/page/error_page.dart';

void main() {
  runZonedGuarded(() {
    ErrorWidget.builder = (FlutterErrorDetails details) {
      Zone.current.handleUncaughtError(details.exception, details.stack!);
      ///此处仅为展示，正规的实现方式参考 _defaultErrorWidgetBuilder 通过自定义 RenderErrorBox 实现
      return ErrorPage("${details.exception}\n${details.stack}", details);
    };
    runApp(ConfigWrapper(
      config: EnvConfig.fromJson(config),
     child: ,
    ));
  }, (error, stack) {
    print(error);
    print(stack);
  });
}
