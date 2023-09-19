import 'package:flutter/material.dart';

class Circle {
  final Color color;
  final double radius;
  final Offset center;

  Circle({required this.color, required this.radius, required this.center});
}

class CircleTween extends Tween<Circle> {
  CircleTween({required Circle begin, required Circle end})
      : super(begin: begin, end: end);

  @override
  Circle lerp(double t) {
    return Circle(
      color: Color.lerp(begin?.color, end?.color, t) ?? Colors.transparent,
      radius: (begin!.radius + (end!.radius - begin!.radius) * t),
      center: Offset.lerp(begin?.center, end?.center, t) ?? Offset.zero,
    );
  }
}
