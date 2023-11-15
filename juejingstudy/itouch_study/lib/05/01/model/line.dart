import 'dart:ui';

import 'package:flutter/material.dart';

import 'point.dart';

enum PaintState {
  //正在绘制
  doing,
  //绘制完毕
  done,
  //隐藏
  hide,
}

class Line {
  List<Point> points = [];
  PaintState state;
  double strokeWidth;
  Color color;

  Line(
      {this.color = Colors.black,
      this.strokeWidth = 1,
      this.state = PaintState.doing});

  void paint(Canvas canvas, Paint paint) {
    paint
      ..style = PaintingStyle.stroke
      ..color = color
      ..strokeWidth = strokeWidth;
    canvas.drawPoints(
        PointMode.polygon, points.map((e) => e.toOffset()).toList(), paint);
  }
}
