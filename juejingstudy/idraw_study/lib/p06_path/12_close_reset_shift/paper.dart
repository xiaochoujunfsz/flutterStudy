import 'dart:math';

import 'package:flutter/material.dart';
import 'package:idraw_study/p06_path/coordinate_pro.dart';

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
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;
    //path#close ：用于将路径尾点和起点，进行路径封闭。
    path
      ..lineTo(100, 100)
      ..relativeLineTo(0, -50)
      ..close();
    canvas.drawPath(path, paint);
    //path#shift ：指定点Offset将路径进行平移，且返回一条新的路径。
    canvas.drawPath(path.shift(const Offset(100, 0)), paint);
    canvas.drawPath(path.shift(const Offset(200, 0)), paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
