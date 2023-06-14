import 'package:flutter/material.dart';
import 'particle.dart';
import 'particle_manage.dart';

class WorldRender extends CustomPainter {
  final ParticleManage manage;
  Paint fillPaint = Paint();

  Paint stokePaint = Paint()
    ..strokeWidth = 0.5
    ..style = PaintingStyle.stroke;

  WorldRender({required this.manage}) : super(repaint: manage);

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawRect(Offset.zero & size, stokePaint);
    manage.particles.forEach((particle) {
      drawParticle(canvas, particle);
    });
  }

  @override
  bool shouldRepaint(WorldRender oldDelegate) => oldDelegate.manage != manage;

  void drawParticle(Canvas canvas, Particle particle) {
    fillPaint.color = particle.color;
    canvas.drawCircle(Offset(particle.x, particle.y), particle.size, fillPaint);
  }
}
