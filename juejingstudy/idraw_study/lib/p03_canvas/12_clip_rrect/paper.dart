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

    var rect = Rect.fromCenter(center: Offset.zero, width: 200, height: 100);
    canvas.clipRRect(RRect.fromRectAndRadius(rect, const Radius.circular(30)));
    canvas.drawColor(Colors.red, BlendMode.darken);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
