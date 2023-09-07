import 'dart:math';

import 'package:flutter/material.dart';
import 'dart:ui' as ui;

class AnimText extends StatefulWidget {
  const AnimText({super.key});

  @override
  State<AnimText> createState() => _AnimTextState();
}

class _AnimTextState extends State<AnimText>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  final Duration animDuration = const Duration(milliseconds: 1000); // 动画时长

  final String text = "张风捷特烈";

  final List<Color> colors = const [
    Color(0xFFF60C0C),
    Color(0xFFF3B913),
    Color(0xFFE7F716),
    Color(0xFF3DF30B),
    Color(0xFF0DF6EF),
    Color(0xFF0829FB),
    Color(0xFFB709F4),
  ];

  final List<double> pos = [
    1.0 / 7,
    2.0 / 7,
    3.0 / 7,
    4.0 / 7,
    5.0 / 7,
    6.0 / 7,
    1.0,
  ];

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(vsync: this, duration: animDuration);
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _startAnim,
      child: AnimatedBuilder(
        animation: _ctrl,
        builder: _buildByAnim,
      ),
    );
  }

  Paint getPaint() {
    Paint paint = Paint();
    paint
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    paint.shader = ui.Gradient.linear(const Offset(0, 0), const Offset(100, 0),
        colors, pos, TileMode.mirror, Matrix4.rotationZ(pi / 6).storage);
    paint.maskFilter = MaskFilter.blur(BlurStyle.solid, 15 * _ctrl.value);
    return paint;
  }

  Widget _buildByAnim(BuildContext context, Widget? child) {
    return Text(
      text,
      style: TextStyle(fontSize: 60, foreground: getPaint()),
    );
  }

  void _startAnim() {
    _ctrl.forward(from: 0);
  }
}
