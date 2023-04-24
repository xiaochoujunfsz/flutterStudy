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
    // initPoints();
    initPointsWithPolar();
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
    canvas.drawPoints(ui.PointMode.polygon, points, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;

  void initPoints() {
    step = 1;
    min = -240;
    max = 240;
    for (double x = min; x <= max; x += step) {
      points.add(Offset(x, f1(x)));
    }
  }

  double f1(double x) {
    double y = -x * x / 200 + 100;
    return y;
  }

  void initPointsWithPolar() {
    step = 3;
    min = 0;
    max = 360 * 3.0;
    for (double x = min; x <= max; x += step) {
      double thta = (pi / 180 * x); // 角度转化为弧度
      var p = f2(thta);
      points.add(Offset(p * cos(thta), p * sin(thta)));
    }
  }

  double f2(double thta) {
    double p = 10 * thta;
    return p;
  }
}
