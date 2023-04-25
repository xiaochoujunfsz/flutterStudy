import 'package:flutter/material.dart';
import 'package:idraw_study/p14_bezier/coordinate_pro.dart';
import 'dart:ui' as ui;

class Paper extends StatelessWidget {
  const Paper({Key? key}) : super(key: key);

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
  Coordinate coordinate = Coordinate();

  Offset p1 = const Offset(100, 100);
  Offset p2 = const Offset(120, -60);
  final Paint _helpPaint = Paint();

  @override
  void paint(Canvas canvas, Size size) {
    coordinate.paint(canvas, size);
    canvas.translate(size.width / 2, size.height / 2);

    Paint paint = Paint()
      ..color = Colors.orange
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    Path path = Path();
    path.quadraticBezierTo(p1.dx, p1.dy, p2.dx, p2.dy);
    canvas.drawPath(path, paint);
    _drawHelp(canvas);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;

  void _drawHelp(Canvas canvas) {
    _helpPaint
      ..color = Colors.purple
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;
    canvas.drawPoints(ui.PointMode.lines, [Offset.zero, p1, p1, p2],
        _helpPaint..strokeWidth = 1);
    canvas.drawPoints(ui.PointMode.points, [Offset.zero, p1, p2],
        _helpPaint..strokeWidth = 8);
  }
}
