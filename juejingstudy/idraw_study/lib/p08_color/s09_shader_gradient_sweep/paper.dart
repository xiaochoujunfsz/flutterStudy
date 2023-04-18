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

    drawShaderSweep(canvas);
  }

  @override
  bool shouldRepaint(PaperPainter oldDelegate) => false;

  void drawShaderSweep(Canvas canvas) {
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
    Paint paint = Paint()
      ..style = PaintingStyle.fill
      ..color = Colors.blue;
    paint.shader =
        ui.Gradient.sweep(Offset.zero, colors, pos, TileMode.clamp, pi / 2, pi);
    canvas.drawCircle(
      Offset.zero,
      50,
      paint,
    );

    canvas.translate(160, 0);
    paint.shader = ui.Gradient.sweep(
        Offset.zero, colors, pos, TileMode.repeated, pi / 2, pi);
    canvas.drawCircle(
      Offset.zero,
      50,
      paint,
    );

    canvas.translate(-160 * 2.0, 0);
    paint.shader = ui.Gradient.sweep(
        Offset.zero, colors, pos, TileMode.mirror, pi / 2, pi);
    canvas.drawCircle(
      Offset.zero,
      50,
      paint,
    );
  }
}
