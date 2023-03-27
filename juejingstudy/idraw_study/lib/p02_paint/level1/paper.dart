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
    // drawIsAntiAliasColor(canvas);
    drawStyleStrokeWidth(canvas);
  }

  //测试 isAntiAlias 和 color 属性
  void drawIsAntiAliasColor(Canvas canvas) {
    Paint paint = Paint();
    canvas.drawCircle(
        const Offset(180, 180),
        170,
        paint
          ..color = Colors.blue
          ..isAntiAlias = true);
    canvas.drawCircle(
        const Offset(180 + 360, 180),
        170,
        paint
          ..color = Colors.red
          ..isAntiAlias = false);
  }

  //测试 style 和 strokeWidth 属性
  void drawStyleStrokeWidth(Canvas canvas) {
    Paint paint = Paint()..color = Colors.red;
    canvas.drawCircle(
        const Offset(180, 180),
        125,
        paint
          ..style = PaintingStyle.stroke
          ..strokeWidth = 50);
    canvas.drawCircle(
        const Offset(180 + 360, 180),
        150,
        paint
          ..strokeWidth = 50
          ..style = PaintingStyle.fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
