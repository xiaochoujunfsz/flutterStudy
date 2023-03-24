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
    //创建画笔
    final Paint paint = Paint();
    paint
      ..color = Colors.blue //颜色
      ..strokeWidth = 4 //线宽
      ..style = PaintingStyle.stroke; //模式--线型
    canvas.drawLine(const Offset(0, 0), const Offset(100, 100), paint); //绘制线

    Path path = Path();
    path.moveTo(100, 100);
    path.lineTo(200, 0);
    canvas.drawPath(path, paint..color = Colors.red);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
