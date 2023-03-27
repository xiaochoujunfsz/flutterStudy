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
    var paint = Paint();
    paint.color = const Color(0xff009A44);
    canvas.drawCircle(const Offset(100, 100), 50, paint..invertColors = false);
    canvas.drawCircle(
        const Offset(100 + 120.0, 100), 50, paint..invertColors = true);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
