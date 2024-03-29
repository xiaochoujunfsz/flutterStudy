import 'dart:ui';

import 'package:flutter/material.dart';
import 'point_data.dart';

class AnimPainter extends CustomPainter {
  final PointData points;

  Paint axisPaint = Paint()
    ..style = PaintingStyle.stroke
    ..strokeWidth = 1;

  Paint fpsPaint = Paint()
    ..style = PaintingStyle.stroke
    ..color = Colors.green;

  TextPainter textPainter = TextPainter(
      textAlign: TextAlign.center, textDirection: TextDirection.ltr);

  AnimPainter(this.points) : super(repaint: points);

  @override
  void paint(Canvas canvas, Size size) {
    canvas.translate(0, size.height);
    textPainter.text = const TextSpan(
        text: '动画控制器数值散点图',
        style: TextStyle(
            fontSize: 14, color: Colors.black, fontWeight: FontWeight.bold));
    textPainter.layout();
    Size textSize = textPainter.size;
    textPainter.paint(
        canvas, Offset(size.width / 2 - textSize.width / 2, -size.height - 30));

    _drawAxis(canvas, size);
    _drawScale(canvas, size);
    _drawPoint(points.values, canvas, size);

    Path fps_60 = Path();
    fps_60.moveTo(3.0 * 60, 0);
    fps_60.relativeLineTo(0, -size.height);
    canvas.drawPath(fps_60, fpsPaint);
    textPainter.text = const TextSpan(
        text: '60 帧', style: TextStyle(fontSize: 12, color: Colors.green));
    textPainter.layout(); // 进行布局
    textPainter.paint(canvas, Offset(3.0 * 61 + 5, -size.height));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;

  void _drawAxis(Canvas canvas, Size size) {
    Path axisPath = Path();
    axisPath.relativeLineTo(size.width, 0);
    axisPath.relativeLineTo(-10, -4);
    axisPath.moveTo(size.width, 0);
    axisPath.relativeLineTo(-10, 4);
    axisPath.moveTo(0, 0);
    axisPath.relativeLineTo(0, -size.height);
    axisPath.relativeLineTo(-4, 10);
    axisPath.moveTo(0, -size.height);
    axisPath.relativeLineTo(4, 10);
    canvas.drawPath(axisPath, axisPaint);

    textPainter.text = const TextSpan(
        text: '帧数/f', style: TextStyle(fontSize: 12, color: Colors.black));
    textPainter.layout();
    Size textSize = textPainter.size;
    textPainter.paint(canvas, Offset(size.width - textSize.width, 5));
    textPainter.text = const TextSpan(
        text: '数值/y', style: TextStyle(fontSize: 12, color: Colors.black));
    textPainter.layout(); // 进行布局
    Size textSize2 = textPainter.size; // 尺寸必须在布局后获取
    textPainter.paint(canvas,
        Offset(-textSize2.width - 10, -size.height - textSize2.height / 2));
  }

  void _drawScale(Canvas canvas, Size size) {
    double step = size.height / 11;
    Path scalePath = Path();
    for (int i = 1; i <= 10; i++) {
      scalePath
        ..moveTo(0, -step * i)
        ..relativeLineTo(5, 0);

      textPainter.text = TextSpan(
          text: '${i / 10}',
          style: const TextStyle(fontSize: 12, color: Colors.black));

      textPainter.layout(); // 进行布局
      Size textSize = textPainter.size; // 尺寸必须在布局后获取
      textPainter.paint(
          canvas, Offset(-textSize.width - 5, -step * i - textSize.height / 2));
    }
    canvas.drawPath(scalePath, axisPaint);
  }

  void _drawPoint(List<double> values, Canvas canvas, Size size) {
    double stepY = size.height / 11;
    List<Offset> drawPoint = [];
    for (int i = 0; i < values.length; i++) {
      drawPoint.add(Offset(3.0 * (i + 1), -values[i] * (size.height - stepY)));
    }
    canvas.drawPoints(
        PointMode.points,
        drawPoint,
        Paint()
          ..style = PaintingStyle.stroke
          ..color = Colors.blue
          ..strokeWidth = 2);
  }
}
