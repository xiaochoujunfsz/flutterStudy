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
  const World({Key? key}) : super(key: key);

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
    pm.size = const Size(400, 260);

    initParticles();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )
      ..addListener(pm.tick);
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

  void initParticles() async {
    ByteData data = await rootBundle.load("assets/images/flutter.png");
    List<int> bytes =
    data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
    image.Image? imageSrc = image.decodeImage(Uint8List.fromList(bytes));
    if (imageSrc == null) return;

    double offsetX = (pm.size.width - imageSrc.width) / 2;
    double offsetY = (pm.size.height - imageSrc.height) / 2;

    for (int i = 0; i < imageSrc.width; i++) {
      for (int j = 0; j < imageSrc.height; j++) {
        if (imageSrc.getPixel(i, j).toString() == "(0, 0, 0, 255)") {
          Particle particle = Particle(
              x: i * 1.0 + offsetX,
              y: j * 1.0 + offsetY,
              vx: 4 * random.nextDouble() * pow(-1, random.nextInt(20)),
              vy: 4 * random.nextDouble() * pow(-1, random.nextInt(20)),
              ay: 0.1,
              size: 0.5,
              color: Colors.blue); //产生粒子---每个粒子拥有随机的一些属性信息
          pm.particles.add(particle);
        }
      }
    }
  }
}
