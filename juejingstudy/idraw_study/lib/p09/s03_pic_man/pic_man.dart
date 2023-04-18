import 'dart:math';

import 'package:flutter/material.dart';

class PicMan extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    //剪切画布  相当于canvas.clipRect(Rect.fromLTWH(0, 0, size.width, size.height));
    canvas.clipRect(Offset.zero & size);
    canvas.translate(size.width / 2, size.height / 2);
    _drawArcDetail(canvas);
  }

  void _drawArcDetail(Canvas canvas) {
    var rect =
        Rect.fromCenter(center: const Offset(0, 0), height: 100, width: 100);
    Paint paint = Paint();

    var a = pi / 8;
    canvas.drawArc(rect, a, 2 * pi - a.abs() * 2, true,
        paint..color = Colors.yellowAccent);
    canvas.translate(40, 0);

    canvas.translate(40, 0);
    canvas.drawCircle(const Offset(0, 0), 6, paint);
    canvas.translate(25, 0);
    canvas.drawCircle(const Offset(0, 0), 6, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
