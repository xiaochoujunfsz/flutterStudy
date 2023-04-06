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
      ..color = Colors.purple
      ..style = PaintingStyle.fill;

    path
      ..relativeMoveTo(0, 0)
      ..relativeLineTo(-30, 120)
      ..relativeLineTo(30, -30)
      ..relativeLineTo(30, 30)
      ..close();
    var pathOval = Path()
      ..addOval(
          Rect.fromCenter(center: const Offset(0, 0), width: 60, height: 60));
    canvas.drawPath(
        Path.combine(PathOperation.difference, path, pathOval), paint);

    canvas.translate(120, 0);
    canvas.drawPath(
        Path.combine(PathOperation.intersect, path, pathOval), paint);

    canvas.translate(120, 0);
    canvas.drawPath(Path.combine(PathOperation.union, path, pathOval), paint);

    canvas.translate(-120 * 3.0, 0);
    canvas.drawPath(
        Path.combine(PathOperation.reverseDifference, path, pathOval), paint);

    canvas.translate(-120, 0);
    canvas.drawPath(Path.combine(PathOperation.xor, path, pathOval), paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
