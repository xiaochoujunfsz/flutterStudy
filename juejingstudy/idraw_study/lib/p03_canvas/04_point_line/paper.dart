import 'dart:math';
import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/material.dart';

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

  late Paint _gridPaint; //画笔
  final double step = 20; //小格边长
  final double strokeWidth = .5; //线宽
  final Color color = Colors.grey; //线颜色

  final List<Offset> points = const [
    Offset(-120, -20),
    Offset(-80, -80),
    Offset(-40, -40),
    Offset(0, -100),
    Offset(40, -140),
    Offset(80, -160),
    Offset(120, -100),
  ];

  PaperPainter() {
    _paint = Paint()
      ..style = PaintingStyle.fill
      ..strokeWidth = strokeWidth
      ..color = Colors.blue;
    _gridPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..color = color;
  }

  @override
  void paint(Canvas canvas, Size size) {
    canvas.translate(size.width / 2, size.height / 2);
    _drawGrid(canvas, size);
    _drawAxis(canvas, size);

    //点模式
    // _drawPointsWithPoints(canvas);
    //线段模式
    // _drawPointsWithLines(canvas);
    //多边形连线模式
    // _drawPointLineWithPolygon(canvas);
    //绘点集
    _drawRawPoints(canvas);
  }

  void _drawGrid(Canvas canvas, Size size) {
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

  void _drawAxis(Canvas canvas, Size size) {
    _paint
      ..color = Colors.blue
      ..strokeWidth = 1.5;
    canvas.drawLine(
        Offset(-size.width / 2, 0), Offset(size.width / 2, 0), _paint);
    canvas.drawLine(
        Offset(0, -size.height / 2), Offset(0, size.height / 2), _paint);
    canvas.drawLine(Offset(0, size.height / 2),
        Offset(0 - 7.0, size.height / 2 - 10), _paint);
    canvas.drawLine(Offset(0, size.height / 2),
        Offset(0 + 7.0, size.height / 2 - 10), _paint);
    canvas.drawLine(
        Offset(size.width / 2, 0), Offset(size.width / 2 - 10, 7), _paint);
    canvas.drawLine(
        Offset(size.width / 2, 0), Offset(size.width / 2 - 10, -7), _paint);
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

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;

  void _drawPointsWithPoints(Canvas canvas) {
    _paint
      ..color = Colors.red
      ..style = PaintingStyle.stroke
      ..strokeWidth = 10
      ..strokeCap = StrokeCap.round;
    canvas.drawPoints(PointMode.points, points, _paint);
  }

  void _drawPointsWithLines(Canvas canvas) {
    _paint
      ..color = Colors.red
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1
      ..strokeCap = StrokeCap.round;
    canvas.drawPoints(PointMode.lines, points, _paint);
  }

  void _drawPointLineWithPolygon(Canvas canvas) {
    _paint
      ..color = Colors.red
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1
      ..strokeCap = StrokeCap.round;
    canvas.drawPoints(PointMode.polygon, points, _paint);
  }

  void _drawRawPoints(Canvas canvas) {
    Float32List pos = Float32List.fromList([
      -120,
      -20,
      -80,
      -80,
      -40,
      -40,
      0,
      -100,
      40,
      -140,
      80,
      -160,
      120,
      -100
    ]);
    _paint
      ..color = Colors.red
      ..style = PaintingStyle.stroke
      ..strokeWidth = 10
      ..strokeCap = StrokeCap.round;
    canvas.drawRawPoints(PointMode.points, pos, _paint);
  }
}
