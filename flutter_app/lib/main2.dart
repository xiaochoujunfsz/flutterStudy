import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/widget.dart';
import 'package:flutter_app/widget2.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        routes: {
          "/": (context) => HomePage(),
          "willpop_scope_test" : (context) => WillPopScopeTestRoute(),
          "inherited_widget_test" : (context) => InheritedWidgetTestRoute(),
          "provider_test" : (context) => ProvideRoute(),
          "theme_test":(context) => ThemeTestRoute(),
          "future_stream_test":(context) => FutureBuilderAndStreamBuilderTestRoute(),
          "dialog_test":(context) => DialogTestRoute(),
        });
  }
}
