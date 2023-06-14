import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'particle.dart';
import 'world_render.dart';
import 'particle_manage.dart';

class World extends StatefulWidget {
  const World({Key? key}) : super(key: key);

  @override
  _WorldState createState() => _WorldState();
}

class _WorldState extends State<World> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  ParticleManage pm = ParticleManage();
  Random random = Random();
  late Timer timer;

  @override
  void initState() {
    super.initState();
    pm.size = const Size(300, 200);
    //定义计时器
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      //如果粒子数大于20，停止计时器
      if (pm.particles.length > 20) {
        timer.cancel();
      }
      //添加随机粒子
      pm.addParticle(Particle(
          color: randomRGB(),
          size: 5 + 4 * random.nextDouble(),
          vx: 3 * random.nextDouble() * pow(-1, random.nextInt(20)),
          vy: 3 * random.nextDouble() * pow(-1, random.nextInt(20)),
          ay: 0.1,
          x: 150,
          y: 100));
    });
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )
      ..addListener(pm.tick)
      ..repeat();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: theWorld,
      child: CustomPaint(
        size: pm.size,
        painter: WorldRender(manage: pm),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  theWorld() {
    if (_controller.isAnimating) {
      _controller.stop();
    } else {
      _controller.repeat();
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
