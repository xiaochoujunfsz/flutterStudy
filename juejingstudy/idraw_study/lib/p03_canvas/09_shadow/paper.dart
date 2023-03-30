import 'package:flutter/material.dart';

import 'coordinate.dart';

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
  final double strokeWidth = 0.5;
  final Color color = Colors.blue;
  final Coordinate coordinate = Coordinate();

  @override
  void paint(Canvas canvas, Size size) {
    coordinate.paint(canvas, size);
    canvas.translate(size.width / 2, size.height / 2);
    Paint paint = Paint()
      ..style = PaintingStyle.fill
      ..color = Colors.white
      ..isAntiAlias = true;
    double relativeX = 100;
    double angle = 0;
    double width = 10;
    double height = 10;
    double center = relativeX + width / 2;
    if (angle == 0) {
      center = relativeX + width / 4;
    } else {
      center = relativeX + width / 4 * 3;
    }

    Path trianglePath = Path()
      ..addPolygon([
        Offset(relativeX, height),
        Offset(relativeX + width, height),
        Offset(center, 0)
      ], false)
      ..close();

    Path rectanglePath = Path()
      ..addRRect(RRect.fromLTRBR(0, 10, 160, 100, const Radius.circular(8)))
      ..close();

    canvas.drawShadow(
        Path.combine(PathOperation.xor, trianglePath, rectanglePath),
        Colors.black,
        3,
        false);

    canvas.drawPath(
        Path.combine(PathOperation.xor, trianglePath, rectanglePath),
        paint..color = Colors.white);
    paint.maskFilter = const MaskFilter.blur(BlurStyle.inner, 20);
    canvas.drawPath(
        Path.combine(PathOperation.xor, trianglePath, rectanglePath),
        paint..color = const Color(0xffBEC4C0));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
