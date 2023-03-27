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
  @override
  void paint(Canvas canvas, Size size) {
    drawBlendMode(canvas, BlendMode.lighten);
    canvas.translate(150, 0);
    drawBlendMode(canvas, BlendMode.hue);
    canvas.translate(150, 0);
    drawBlendMode(canvas, BlendMode.plus);
    canvas.translate(150, 0);
    drawBlendMode(canvas, BlendMode.hardLight);
  }

  void drawBlendMode(Canvas canvas, BlendMode mode) {
    var paint = Paint();
    canvas.drawCircle(
        const Offset(100, 100), 50, paint..color = const Color(0x88ff0000));
    canvas.drawCircle(
        const Offset(140, 70),
        50,
        paint
          ..color = const Color(0x8800ff00)
          ..blendMode = mode);
    canvas.drawCircle(
        const Offset(140, 130),
        50,
        paint
          ..color = const Color(0x880000ff)
          ..blendMode = mode);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
