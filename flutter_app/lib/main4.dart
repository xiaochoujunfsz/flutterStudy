import 'package:flutter/material.dart';
import 'package:flutter_app/widget4.dart';

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
          "turn_box": (context) => TurnBoxRoute(),
          "custom_paint": (context) => CustomPaintRoute(),
          "gradient_circular_progress": (context) => GradientCircularProgressRoute(),
        });
  }
}