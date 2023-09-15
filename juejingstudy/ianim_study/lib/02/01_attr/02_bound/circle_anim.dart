import 'package:flutter/material.dart';

class CircleAnim extends StatefulWidget {
  const CircleAnim({super.key});

  @override
  State<CircleAnim> createState() => _CircleAnimState();
}

class _CircleAnimState extends State<CircleAnim>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  final Duration animDuration = const Duration(milliseconds: 1000);

  double get radius => _ctrl.value;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      lowerBound: 32,
      upperBound: 80,
      duration: animDuration,
    );
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

  void _startAnim() {
    _ctrl.forward();
  }

  Widget _buildByAnim(BuildContext context, Widget? child) => Container(
        width: radius * 2,
        height: radius * 2,
        decoration:
            const BoxDecoration(color: Colors.blue, shape: BoxShape.circle),
      );
}
