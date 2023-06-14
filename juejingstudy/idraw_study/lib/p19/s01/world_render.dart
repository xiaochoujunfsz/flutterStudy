import 'dart:math';

import 'package:flutter/material.dart';
import 'particle.dart';
import 'particle_manage.dart';

class WorldRender extends CustomPainter {
  final ParticleManage manage;

  Paint fillPaint = Paint()
    ..colorFilter = const ColorFilter.matrix(<double>[
      1,
      0,
      0,
      0,
      0,
      0,
      1,
      0,
      0,
      0,
      0,
      0,
      1,
      0,
      0,
      0,
      0,
      0,
      0.4,
      0,
    ]);

  Paint stokePaint = Paint()
    ..strokeWidth = 0.5
    ..style = PaintingStyle.stroke;

  WorldRender({required this.manage}) : super(repaint: manage);

  @override
  void paint(Canvas canvas, Size size) {
    if (manage.image == null) return;
    manage.particles.forEach((particle) {
      drawParticle(canvas, particle);
    });
  }

  @override
  bool shouldRepaint(WorldRender oldDelegate) => oldDelegate.manage != manage;

  void drawParticle(Canvas canvas, Particle particle) {
    fillPaint.color = particle.color;
    if (manage.image == null) return;
    canvas.save();
    canvas.translate(particle.x, particle.y);
    var dis = sqrt(particle.vy * particle.vy + particle.vx * particle.vx);
    canvas.rotate(acos(particle.vx / dis) + pi + pi / 2);
    canvas.drawImageRect(
        manage.image!,
        Rect.fromLTWH(
            0, 0, manage.image!.width * 1.0, manage.image!.height * 1.0),
        Rect.fromLTWH(
            0, 0, manage.image!.width * 0.18, manage.image!.height * 0.18),
        fillPaint);
    canvas.restore();
  }
}
