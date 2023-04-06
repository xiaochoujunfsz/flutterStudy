import 'dart:math';
import 'dart:ui';

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
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;

    path
      ..relativeMoveTo(0, 0)
      ..relativeLineTo(-30, 120)
      ..relativeLineTo(30, -30)
      ..relativeLineTo(30, 30)
      ..close();
    path.addOval(Rect.fromCenter(center: Offset.zero, width: 50, height: 50));

    PathMetrics pms = path.computeMetrics();
    for (var pm in pms) {
      Tangent? tangent = pm.getTangentForOffset(pm.length * 0.5);
      if (tangent == null) {
        return;
      }
      print(
          "---position:-${tangent.position}----angle:-${tangent.angle}----vector:-${tangent.vector}----");
      canvas.drawCircle(
          tangent.position, 5, Paint()..color = Colors.deepOrange);
      print(
          "---length:-${pm.length}----contourIndex:-${pm.contourIndex}----contourIndex:-${pm.isClosed}----");
    }
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
