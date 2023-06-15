import 'package:flutter/material.dart';
import 'bg_manage.dart';

class BgPainter extends CustomPainter {
  final BgManage manage;

  BgPainter({required this.manage}) : super(repaint: manage);

  Paint clockPaint = Paint();

  @override
  void paint(Canvas canvas, Size size) {
    manage.particles.forEach((particle) {
      clockPaint.color = particle.color;
      canvas.drawCircle(
          Offset(particle.x, particle.y), particle.size, clockPaint);
    });
  }

  @override
  bool shouldRepaint(BgPainter oldDelegate) => false;
}
