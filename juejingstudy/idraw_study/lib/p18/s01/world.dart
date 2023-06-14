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

  @override
  void initState() {
    super.initState();
    initParticleManage();
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

  void initParticleManage() {
    pm.size = const Size(300, 200);
    Particle particle = Particle(
        x: 0, y: 0, vx: 3, vy: 0, ay: 0.05, color: Colors.blue, size: 8);
    pm.particles = [particle];
  }
}
