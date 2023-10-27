import 'dart:math';

import 'package:flutter/material.dart';

import 'particle.dart';

class ClockFx with ChangeNotifier {
  //宽
  double width;

  //高
  double height;

  //宽高最小值
  double sizeMin;

  //画布中心
  Offset center;

  // 粒子活动区域
  Rect spawnArea;

  // 所有粒子
  List<Particle> particles;

  // 最大粒子数
  int numParticles;

  //时间
  DateTime time;

  ClockFx({
    required Size size,
    required this.time,
    this.width = 0,
    this.height = 0,
    this.sizeMin = 0,
    this.center = Offset.zero,
    this.spawnArea = Rect.zero,
    this.particles = const [],
    this.numParticles = 5000,
  }) {
    particles = List<Particle>.filled(numParticles, Particle());
    setSize(size);
  }

  void setSize(Size size) {
    width = size.width;
    height = size.height;
    sizeMin = min(width, height);
    center = Offset(width / 2, height / 2);
    spawnArea = Rect.fromLTRB(
      center.dx - sizeMin / 100,
      center.dy - sizeMin / 100,
      center.dx + sizeMin / 100,
      center.dy + sizeMin / 100,
    );
    init();
  }

  void init() {
    for (int i = 0; i < numParticles; i++) {
      particles[i] = Particle(color: Colors.black);
      resetParticle(i);
    }
  }

  Particle resetParticle(int i) {
    Particle p = particles[i];
    p.size = p.a = p.vx = p.vy = p.life = p.lifeLeft = 0;
    p.x = center.dx;
    p.y = center.dy;
    return p;
  }

  void setTime(DateTime time) {
    this.time = time;
  }

  void tick(Duration duration) {
    notifyListeners();
  }
}
