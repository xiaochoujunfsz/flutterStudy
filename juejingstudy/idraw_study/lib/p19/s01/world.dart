import 'dart:async';
import 'dart:math';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'particle.dart';
import 'world_render.dart';
import 'particle_manage.dart';
import 'package:image/image.dart' as image;

class World extends StatefulWidget {
  final Size size;

  const World({Key? key, required this.size}) : super(key: key);

  @override
  _WorldState createState() => _WorldState();
}

class _WorldState extends State<World> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  ParticleManage pm = ParticleManage();
  Random random = Random();

  @override
  void initState() {
    super.initState();
    loadImageFromAssets("assets/images/sword.png");
    pm.size = widget.size;

    initParticles();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )
      ..addListener(pm.tick)
      ..repeat();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
            width: widget.size.width,
            height: widget.size.height,
            child: Image.asset(
              'assets/images/bg.jpeg',
              fit: BoxFit.cover,
            )),
        GestureDetector(
          onTap: theWorld,
          child: CustomPaint(
            size: pm.size,
            painter: WorldRender(manage: pm),
          ),
        ),
      ],
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

  void initParticles() async {
    for (int i = 0; i < 60; i++) {
      Particle particle = Particle(
        x: pm.size.width / 60 * i,
        y: 0,
        vx: 1 * random.nextDouble() * pow(-1, random.nextInt(20)),
        vy: 4 * random.nextDouble() + 1,
      );
      pm.particles.add(particle);
    }
  }

  //读取 assets 中的图片
  void loadImageFromAssets(String path) async {
    ByteData data = await rootBundle.load(path);
    pm.setImage(await decodeImageFromList(data.buffer.asUint8List()));
  }
}
