import 'dart:math';

import 'package:flutter/material.dart';

import 'particle.dart';
import 'dart:ui' as ui;

class ParticleManage with ChangeNotifier {
  // 粒子集合
  List<Particle> particles = [];
  Random random = Random();
  ui.Image? image;

  Size size;

  ParticleManage({this.size = Size.zero});

  void addParticle(Particle particle) {
    particles.add(particle);
    notifyListeners();
  }

  void setImage(ui.Image image) {
    this.image = image;
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
      p.x = size.width;
      p.vx = -p.vx;
    }
    if (p.x < 0) {
      p.x = 0;
      p.vx = -p.vx;
    }
    if (p.y > size.height) {
      p.y = 0;
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
