import 'package:flutter/material.dart';

import 'particle.dart';

class ParticleManage with ChangeNotifier {
  // 粒子集合
  List<Particle> particles = [];

  Size size;

  ParticleManage({this.size = Size.zero});

  void addParticle(Particle particle) {
    particles.add(particle);
    notifyListeners();
  }

  void tick() {
    particles.forEach(doUpdate);
    notifyListeners();
  }

  void doUpdate(Particle p) {
    p.vx += p.ax;
    p.vy += p.ay;
    p.x += p.vx;
    p.y += p.vy;
    if (p.x > size.width) {
      p.x = size.width;
      p.vx = -p.vx;
    }
    if (p.x < 0) {
      p.x = 0;
      p.vx = -p.vx;
    }
    if (p.y > size.height) {
      p.y = size.height;
      p.vy = -p.vy;
    }
    if (p.y < 0) {
      p.y = 0;
      p.vy = -p.vy;
    }
  }
}
