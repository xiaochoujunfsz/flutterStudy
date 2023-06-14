import 'dart:math';

import 'package:flutter/material.dart';

import 'particle.dart';

class ParticleManage with ChangeNotifier {
  // 粒子集合
  List<Particle> particles = [];
  Random random = Random();

  Size size;

  ParticleManage({this.size = Size.zero});

  void addParticle(Particle particle) {
    particles.add(particle);
    notifyListeners();
  }

  void tick() {
    for (int i = 0; i < particles.length; i++) {
      doUpdate(particles[i]);
    }
    notifyListeners();
  }

  void doUpdate(Particle p) {
    p.vx += p.ax;
    p.vy += p.ay;
    p.x += p.vx;
    p.y += p.vy;
    if (p.x > size.width) {
      particles.remove(p);
    }
    if (p.x < 0) {
      particles.remove(p);
    }
    if (p.y > size.height) {
      particles.remove(p);
    }
    if (p.y < 0) {
      particles.remove(p);
    }
  }

  // 获取随机色
  Color randomRGB({
    int limitR = 0,
    int limitG = 0,
    int limitB = 0,
  }) {
    var r = limitR + random.nextInt(256 - limitR); //红值
    var g = limitG + random.nextInt(256 - limitG); //绿值
    var b = limitB + random.nextInt(256 - limitB); //蓝值
    return Color.fromARGB(255, r, g, b); //生成argb模式的颜色
  }
}
