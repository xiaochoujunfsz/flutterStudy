import 'package:flutter/material.dart';

class CircleAnim extends StatefulWidget {
  const CircleAnim({Key? key}) : super(key: key);

  @override
  State<CircleAnim> createState() => _CircleAnimState();
}

class _CircleAnimState extends State<CircleAnim>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  final Duration animDuration = const Duration(milliseconds: 1000);

  final ColorTween tween = ColorTween(begin: Colors.blue, end: Colors.red);

  Color? get color => tween.transform(_ctrl.value);

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

  void _startAnim() {
    _ctrl.forward();
  }

  Widget _buildByAnim(BuildContext context, Widget? child) => Container(
        width: 80,
        height: 80,
        decoration: BoxDecoration(color: color, shape: BoxShape.circle),
      );
}
