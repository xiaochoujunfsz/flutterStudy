import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:stopwatch/home_page/view/home_page.dart';

void main() {
  runApp(const StopwatchApp());
}

class StopwatchApp extends StatelessWidget {
  const StopwatchApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //沉浸式状态栏
    SystemUiOverlayStyle overlayStyle = const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarBrightness: Brightness.light,
      statusBarIconBrightness: Brightness.dark,
    );
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme:
          ThemeData(appBarTheme: AppBarTheme(systemOverlayStyle: overlayStyle)),
      home: HomePage(),
    );
  }
}
