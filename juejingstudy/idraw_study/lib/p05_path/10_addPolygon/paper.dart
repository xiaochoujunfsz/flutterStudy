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

    var p0 = const Offset(100, 100);
    path
      ..lineTo(100, 100)
      ..addPolygon([
        p0,
        p0.translate(20, -20),
        p0.translate(40, -20),
        p0.translate(60, 0),
        p0.translate(60, 20),
        p0.translate(40, 40),
        p0.translate(20, 40),
        p0.translate(0, 20),
      ], true)
      ..addPath(
          Path()..relativeQuadraticBezierTo(125, -100, 260, 0), Offset.zero)
      ..lineTo(160, 100);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
