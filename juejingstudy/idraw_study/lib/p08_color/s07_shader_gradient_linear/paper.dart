import 'dart:math';

import 'package:flutter/material.dart';
import 'package:idraw_study/p08_color/coordinate_pro.dart';
import 'dart:ui' as ui;

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
  Coordinate coordinate = Coordinate();

  @override
  void paint(Canvas canvas, Size size) {
    coordinate.paint(canvas, size);
    canvas.translate(size.width / 2, size.height / 2);
    canvas.translate(-100, 0);

    drawShaderLinear(canvas);
  }

  @override
  bool shouldRepaint(PaperPainter oldDelegate) => false;

  void drawShaderLinear(Canvas canvas) {
    var colors = const [
      Color(0xFFF60C0C),
      Color(0xFFF3B913),
      Color(0xFFE7F716),
      Color(0xFF3DF30B),
      Color(0xFF0DF6EF),
      Color(0xFF0829FB),
      Color(0xFFB709F4),
    ];

    var pos = [1.0 / 7, 2.0 / 7, 3.0 / 7, 4.0 / 7, 5.0 / 7, 6.0 / 7, 1.0];
    Paint paint = Paint();

    paint
      ..style = PaintingStyle.stroke
      ..color = Colors.blue
      ..strokeJoin = StrokeJoin.miter
      ..strokeWidth = 50;

    paint.shader = ui.Gradient.linear(
        const Offset(0, 0), const Offset(100, 0), colors, pos, TileMode.clamp);
    canvas.drawLine(
      const Offset(0, 0),
      const Offset(200, 0),
      paint,
    );

    canvas.translate(240, 0);
    paint.shader = ui.Gradient.linear(const Offset(0, 0), const Offset(100, 0),
        colors, pos, TileMode.repeated);
    canvas.drawLine(
      const Offset(0, 0),
      const Offset(200, 0),
      paint,
    );

    canvas.translate(-240 * 2.0, 0);
    paint.shader = ui.Gradient.linear(
        const Offset(0, 0), const Offset(100, 0), colors, pos, TileMode.mirror);
    canvas.drawLine(
      const Offset(0, 0),
      const Offset(200, 0),
      paint,
    );

    canvas.translate(0, 100);
    paint.shader = ui.Gradient.linear(const Offset(0, 0), const Offset(100, 0),
        colors, pos, TileMode.mirror, Matrix4.rotationZ(pi / 6).storage);
    canvas.drawLine(
      const Offset(0, 0),
      const Offset(200, 0),
      paint,
    );

    canvas.translate(240, 0);
    paint.shader = ui.Gradient.linear(
        const Offset(0, 0),
        const Offset(100, 0),
        colors,
        pos,
        TileMode.mirror,
        Matrix4.translationValues(20, 0, 0).storage);
    canvas.drawLine(
      const Offset(0, 0),
      const Offset(200, 0),
      paint,
    );

    canvas.translate(240, 0);
    paint.shader = ui.Gradient.linear(const Offset(0, 0), const Offset(100, 0),
        colors, pos, TileMode.mirror, Matrix4.skewX(-pi / 6).storage);
    canvas.drawLine(
      const Offset(0, 0),
      const Offset(200, 0),
      paint,
    );
  }
}
