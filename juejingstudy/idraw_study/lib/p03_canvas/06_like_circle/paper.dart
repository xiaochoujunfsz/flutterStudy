import 'dart:math';

import 'package:flutter/material.dart';

import 'coordinate.dart';

class Paper extends StatelessWidget {
  const Paper({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: CustomPaint(
        painter: PaperPainter(),
      ),
    );
  }
}

class PaperPainter extends CustomPainter {
  late Paint _paint;
  final double strokeWidth = 0.5;
  final Color color = Colors.blue;
  final Coordinate coordinate = Coordinate();

  PaperPainter() {
    _paint = Paint()
      ..strokeWidth = strokeWidth
      ..color = color
      ..style = PaintingStyle.fill;
  }

  @override
  void paint(Canvas canvas, Size size) {
    coordinate.paint(canvas, size);
    canvas.translate(size.width / 2, size.height / 2);

    // _drawFill(canvas);
    _drawArcDetail(canvas);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;

  void _drawFill(Canvas canvas) {
    canvas.save();
    canvas.translate(-200, 0);
    canvas.drawCircle(const Offset(0, 0), 60, _paint);
    canvas.restore();

    var rect =
        Rect.fromCenter(center: const Offset(0, 0), width: 120, height: 100);
    canvas.drawOval(rect, _paint);

    canvas.save();
    canvas.translate(200, 0);
    //drawArc(矩形区域,起始弧度,扫描弧度,是否连中心,画笔)
    canvas.drawArc(rect, 0, pi / 2 * 3, true, _paint);
    canvas.restore();
  }

  void _drawArcDetail(Canvas canvas) {
    var rect =
        Rect.fromCenter(center: const Offset(0, 0), height: 100, width: 100);
    _paint
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    canvas.save();
    canvas.translate(-200, 0);
    canvas.drawArc(rect, 0, pi / 2 * 3, false, _paint);
    canvas.restore();
    canvas.drawArc(rect, 0, pi / 2 * 3, true, _paint);
    canvas.save();
    canvas.translate(200, 0);
    var a = pi / 8;
    canvas.drawArc(
        rect,
        a,
        2 * pi - a.abs() * 2,
        true,
        _paint
          ..color = Colors.yellowAccent
          ..style = PaintingStyle.fill);
    canvas.translate(40, 0);
    canvas.drawCircle(const Offset(0, 0), 6, _paint);
    canvas.translate(25, 0);
    canvas.drawCircle(const Offset(0, 0), 6, _paint);
    canvas.restore();
  }
}
