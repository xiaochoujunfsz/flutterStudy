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
      ..style = PaintingStyle.stroke
      ..color = Colors.blue
      ..strokeJoin = StrokeJoin.miter
      ..strokeWidth = 100;
    paint.shader = ui.Gradient.linear(
        const Offset(0, 0), const Offset(100, 0), colors, pos, TileMode.clamp);
    canvas.drawLine(const Offset(0, 100), const Offset(200, 100), paint);

    paint.shader = ui.Gradient.linear(const Offset(0 + 220, 0),
        const Offset(100 + 220, 0), colors, pos, TileMode.repeated);
    canvas.drawLine(
        const Offset(0 + 220, 100), const Offset(200 + 220, 100), paint);

    paint.shader = ui.Gradient.linear(const Offset(0 + 220 * 2, 0),
        const Offset(100 + 220 * 2, 0), colors, pos, TileMode.mirror);
    canvas.drawLine(
      const Offset(0 + 220.0 * 2, 100),
      const Offset(200 + 220.0 * 2, 100),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
