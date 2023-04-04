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

    // 绘制左侧
    var rect =
        Rect.fromCenter(center: const Offset(0, 0), width: 160, height: 100);
    path.lineTo(30, 30);
    path.arcTo(rect, 0, pi * 1.5, true);
    canvas.drawPath(path, paint);

    path.reset();
    canvas.translate(200, 0);
    //绘制右侧
    path.lineTo(30, 30);
    path.arcTo(rect, 0, pi * 1.5, false);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
