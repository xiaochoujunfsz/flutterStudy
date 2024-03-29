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
  //编辑
  edit,
}

class Line {
  List<Point> points = [];
  PaintState state;
  double strokeWidth;
  Color color;
  Path _linePath = Path();
  Path? _recodePath;

  Path get path => _linePath;

  Line(
      {this.color = Colors.black,
      this.strokeWidth = 1,
      this.state = PaintState.doing});

  void paint(Canvas canvas, Paint paint) {
    paint
      ..style = PaintingStyle.stroke
      ..color = color
      ..strokeJoin = StrokeJoin.round
      ..strokeCap = StrokeCap.round
      ..strokeWidth = strokeWidth;
    if (state == PaintState.doing) {
      _linePath = formPath();
    }
    if (state == PaintState.edit) {
      Paint paint1 = Paint()
        ..strokeWidth = 1
        ..style = PaintingStyle.stroke
        ..color = Colors.deepPurpleAccent;
      canvas.drawRect(
          Rect.fromCenter(
              center: _linePath.getBounds().center,
              width: _linePath.getBounds().width + strokeWidth,
              height: _linePath.getBounds().height + strokeWidth),
          paint1);
    }
    canvas.drawPath(_linePath, paint);
  }

  Path formPath() {
    Path path = Path();
    for (int i = 0; i < points.length - 1; i++) {
      Point current = points[i];
      Point next = points[i + 1];
      if (i == 0) {
        path.moveTo(current.x, current.y);
        path.lineTo(next.x, next.y);
      } else if (i <= points.length - 2) {
        double xc = (points[i].x + points[i + 1].x) / 2;
        double yc = (points[i].y + points[i + 1].y) / 2;
        Point p2 = points[i];
        path.quadraticBezierTo(p2.x, p2.y, xc, yc);
      } else {
        path.moveTo(current.x, current.y);
        path.lineTo(next.x, next.y);
      }
    }
    return path;
  }

  void recode() {
    _recodePath = path.shift(Offset.zero);
  }

  void translate(Offset offset) {
    if (_recodePath == null) return;
    _linePath = _recodePath!.shift(offset);
  }
}
