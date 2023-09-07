import 'dart:math';

import 'package:flutter/material.dart';

class SkewShadowText extends StatefulWidget {
  const SkewShadowText({Key? key}) : super(key: key);

  @override
  State<SkewShadowText> createState() => _SkewShadowTextState();
}

class _SkewShadowTextState extends State<SkewShadowText>
    with SingleTickerProviderStateMixin {
  final TextStyle commonStyle =
      const TextStyle(fontSize: 60, color: Colors.blue);

  final TextStyle shadowStyle =
      TextStyle(fontSize: 60, color: Colors.blue.withAlpha(88));

  final String text = '张风捷特烈';

  late AnimationController _ctrl;
  final Duration animDuration = const Duration(milliseconds: 800);

  double get rad => 6 * (_ctrl.value) / 180 * pi;

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
      child: Stack(
        children: [
          Text(
            text,
            style: commonStyle,
          ),
          AnimatedBuilder(
            animation: _ctrl,
            builder: _buildByAnim,
          )
        ],
      ),
    );
    return const Placeholder();
  }

  void _startAnim() {
    _ctrl.forward(from: 0);
  }

  Widget _buildByAnim(_, __) => Transform(
        transform: Matrix4.skewX(rad),
        child: Text(
          text,
          style: shadowStyle,
        ),
      );
}
