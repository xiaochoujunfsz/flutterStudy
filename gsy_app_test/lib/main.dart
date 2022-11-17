import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gsy_app_test/page/error_page.dart';
import 'package:gsy_app_test/page/home/home_page.dart';

void main() {
  runZonedGuarded(() {
    ErrorWidget.builder = (FlutterErrorDetails details) {
      Zone.current.handleUncaughtError(details.exception, details.stack!);
      return ErrorPage("${details.exception}\n${details.stack}", details);
    };
    runApp(MaterialApp(
      home: HomePage(),
      debugShowCheckedModeBanner: false,
    ));
  }, (error, stack) {
    print(error);
    print(stack);
  });
}
