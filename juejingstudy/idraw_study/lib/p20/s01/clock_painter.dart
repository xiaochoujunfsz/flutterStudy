import 'package:flutter/material.dart';
import 'clock_manage.dart';

class ClockPainter extends CustomPainter {
  final ClockManage manage;

  ClockPainter({required this.manage}) : super(repaint: manage);

  Paint clockPaint = Paint();

  @override
  void paint(Canvas canvas, Size size) {
    manage.particles.where((e) => e.active).forEach((particle) {
      clockPaint.color = particle.color;
      canvas.drawCircle(
          Offset(particle.x, particle.y), particle.size, clockPaint);
    });
  }

  @override
  bool shouldRepaint(ClockPainter oldDelegate) => oldDelegate.manage != manage;
}
