import 'dart:math';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:idraw_study/p13_path_pro/coordinate_pro.dart';

class Paper extends StatelessWidget {
  const Paper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: CustomPaint(
        // 使用CustomPaint
        painter: PaperPainter(),
      ),
    );
  }
}

class PaperPainter extends CustomPainter {
  Coordinate coordinate = Coordinate();
  final List<Offset> points = [];

  double step = 1;
  double min = -240;
  double max = 240;

  @override
  void paint(Canvas canvas, Size size) {
    coordinate.paint(canvas, size);
    canvas.translate(size.width / 2, size.height / 2);
    initPoints();
    Paint paint = Paint()
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke;
    var colors = const [
      Color(0xFFF60C0C),
      Color(0xFFF3B913),
      Color(0xFFE7F716),
      Color(0xFF3DF30B),
      Color(0xFF0DF6EF),
      Color(0xFF0829FB),
      Color(0xFFB709F4),
    ];
    var pos = [1.0 / 7, 2.0 / 7, 3.0 / 7, 4.0 / 7, 5.0 / 7, 6.0 / 7, 1.0];

    paint.shader = ui.Gradient.linear(
        const Offset(0, 0), const Offset(100, 0), colors, pos, TileMode.mirror);

    Offset p1 = points[0];
    Path path = Path()..moveTo(p1.dx, p1.dy);
    for (var i = 1; i < points.length - 1; i++) {
      double xc = (points[i].dx + points[i + 1].dx) / 2;
      double yc = (points[i].dy + points[i + 1].dy) / 2;
      Offset p2 = points[i];
      path.quadraticBezierTo(p2.dx, p2.dy, xc, yc);
    }
    canvas.drawPath(path, paint);
    // canvas.drawPoints(ui.PointMode.polygon, points, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;

  void initPoints() {
    step = 60;
    min = -240;
    max = 240;
    for (double x = min; x <= max; x += step) {
      points.add(Offset(x, f1(x)));
    }
    points.add(Offset(max, f1(max)));
    points.add(Offset(max, f1(max)));
  }

  double f1(double x) {
    double y = -x * x / 200 + 100;
    return y;
  }
}
