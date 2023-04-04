import 'dart:math';

import 'package:flutter/material.dart';
import 'package:idraw_study/p05_path/coordinate.dart';

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
  final Coordinate coordinate = Coordinate();

  @override
  void paint(Canvas canvas, Size size) {
    coordinate.paint(canvas, size);
    canvas.translate(size.width / 2, size.height / 2);

    Path path = Path();
    Paint paint = Paint()
      ..color = Colors.purpleAccent
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    path.lineTo(80, -40);

    //绘制中间  使用劣弧: largeArc: false ,顺时针:clockwise: true
    path
      ..arcToPoint(const Offset(40, 40),
          radius: const Radius.circular(60), largeArc: false)
      ..close();
    canvas.drawPath(path, paint);

    path.reset();
    canvas.translate(-150, 0);
    //绘制左侧  使用优弧: largeArc: true ,逆时针:clockwise: false
    path.lineTo(80, -40);
    path
      ..arcToPoint(const Offset(40, 40),
          radius: const Radius.circular(60), largeArc: true, clockwise: false)
      ..close();
    canvas.drawPath(path, paint);

    path.reset();
    canvas.translate(150 + 150.0, 0);
    //绘制右侧  使用优弧: largeArc: true ,顺时针:clockwise: true
    path.lineTo(80, -40);
    path
      ..arcToPoint(
        const Offset(40, 40),
        radius: const Radius.circular(60),
        largeArc: true,
      )
      ..close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
