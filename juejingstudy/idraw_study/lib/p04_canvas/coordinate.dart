import 'package:flutter/material.dart';

@immutable
class Coordinate {
  //小格边长
  final double step;

  //线宽
  final double strokeWidth;

  //轴颜色
  final Color axisColor;

  //线颜色
  final Color gridColor;

  Coordinate(
      {this.step = 20,
      this.strokeWidth = .5,
      this.axisColor = Colors.blue,
      this.gridColor = Colors.grey});

  final Paint _gridPaint = Paint();

  void paint(Canvas canvas, Size size) {
    canvas.save();
    canvas.translate(size.width / 2, size.height / 2);
    _drawGrid(canvas, size);
    _drawAxis(canvas, size);
    canvas.restore();
  }

  void _drawGrid(Canvas canvas, Size size) {
    _gridPaint
      ..style = PaintingStyle.stroke
      ..strokeWidth = .5
      ..color = Colors.grey;
    _drawBottomRight(canvas, size);
    canvas.save();
    canvas.scale(1, -1); //沿x轴镜像
    _drawBottomRight(canvas, size);
    canvas.restore();

    canvas.save();
    canvas.scale(-1, 1); //沿y轴镜像
    _drawBottomRight(canvas, size);
    canvas.restore();

    canvas.save();
    canvas.scale(-1, -1); //沿原点镜像
    _drawBottomRight(canvas, size);
    canvas.restore();
  }

  void _drawBottomRight(Canvas canvas, Size size) {
    canvas.save();
    for (int i = 0; i < size.height / 2 / step; i++) {
      canvas.drawLine(
          const Offset(0, 0), Offset(size.width / 2, 0), _gridPaint);
      canvas.translate(0, step);
    }
    canvas.restore();

    canvas.save();
    for (int i = 0; i < size.width / 2 / step; i++) {
      canvas.drawLine(
          const Offset(0, 0), Offset(0, size.height / 2), _gridPaint);
      canvas.translate(step, 0);
    }
    canvas.restore();
  }

  void _drawAxis(Canvas canvas, Size size) {
    _gridPaint
      ..color = Colors.blue
      ..strokeWidth = 1.5;
    canvas.drawLine(
        Offset(-size.width / 2, 0), Offset(size.width / 2, 0), _gridPaint);
    canvas.drawLine(
        Offset(0, -size.height / 2), Offset(0, size.height / 2), _gridPaint);
    canvas.drawLine(Offset(0, size.height / 2),
        Offset(0 - 7.0, size.height / 2 - 10), _gridPaint);
    canvas.drawLine(Offset(0, size.height / 2),
        Offset(0 + 7.0, size.height / 2 - 10), _gridPaint);
    canvas.drawLine(
        Offset(size.width / 2, 0), Offset(size.width / 2 - 10, 7), _gridPaint);
    canvas.drawLine(
        Offset(size.width / 2, 0), Offset(size.width / 2 - 10, -7), _gridPaint);
  }
}
