import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/widget3.dart';

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
          "listener_test": (context) => ListenerTest(),
          "drag_test": (context) => Drag(),
          "scale_test": (context) => ScaleTestRoute(),
          "gesture_recognizer_test": (context) => GestureRecognizerTestRoute(),
          "both_direction_test": (context) => BothDirectionTestRoute(),
          "scale_animation_test": (context) => ScaleAnimationRoute(),
          "hero_animation_test": (context) => HeroAnimationRoute(),
          "stagger_animation_test": (context) => StaggerRoute(),
          "animated_switcher_test": (context) => AnimatedSwitcherCounterRoute(),
          "animated_decorated_test": (context) => AnimatedDecoratedBoxTestRoute(),
        });
  }
}
