import 'package:flutter/material.dart';
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
  @override
  void paint(Canvas canvas, Size size) {
    var colors = [
      const Color(0xFFF60C0C),
      const Color(0xFFF3B913),
      const Color(0xFFE7F716),
      const Color(0xFF3DF30B),
      const Color(0xFF0DF6EF),
      const Color(0xFF0829FB),
      const Color(0xFFB709F4),
    ];
    var pos = [1.0 / 7, 2.0 / 7, 3.0 / 7, 4.0 / 7, 5.0 / 7, 6.0 / 7, 1.0];
    Paint paint = Paint();
    paint
      ..style = PaintingStyle.fill
      ..color = Colors.blue;
    paint.shader = ui.Gradient.radial(
        const Offset(80 + 150.0 * 0, 80), 25, colors, pos, TileMode.clamp);
    canvas.drawCircle(
      const Offset(80 + 150.0 * 0, 80),
      50,
      paint,
    );

    paint.shader = ui.Gradient.radial(
        const Offset(80 + 150.0 * 1, 80), 25, colors, pos, TileMode.repeated);
    canvas.drawCircle(
      const Offset(80 + 150.0 * 1, 80),
      50,
      paint,
    );

    paint.shader = ui.Gradient.radial(
        const Offset(80 + 150.0 * 2, 80), 25, colors, pos, TileMode.mirror);
    canvas.drawCircle(
      const Offset(80 + 150.0 * 2, 80),
      50,
      paint,
    );
    paint.shader = ui.Gradient.radial(
        const Offset(80 + 150.0 * 3, 80),
        25,
        colors,
        pos,
        TileMode.mirror,
        null,
        const Offset(80 + 150.0 * 3 - 5, 80 - 5.0),
        10);
    canvas.drawCircle(
      const Offset(80 + 150.0 * 3, 80),
      50,
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
