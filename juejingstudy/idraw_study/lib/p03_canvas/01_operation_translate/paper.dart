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
    var paint = Paint()
      ..style = PaintingStyle.fill
      ..color = Colors.blue;
    //画布起点移到屏幕中心
    canvas.translate(size.width / 2, size.height / 2);
    canvas.drawCircle(const Offset(0, 0), 50, paint);
    canvas.drawLine(
        const Offset(20, 20),
        const Offset(50, 50),
        paint
          ..color = Colors.red
          ..strokeWidth = 5
          ..strokeCap = StrokeCap.round
          ..style = PaintingStyle.stroke);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
