import 'package:flutter/material.dart';
import 'circle.dart';

class CircleAnim extends StatefulWidget {
  const CircleAnim({Key? key}) : super(key: key);

  @override
  State<CircleAnim> createState() => _CircleAnimState();
}

class _CircleAnimState extends State<CircleAnim>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  final Duration animDuration = const Duration(milliseconds: 500);
  final CircleTween tween = CircleTween(
    begin: Circle(center: Offset.zero, radius: 25, color: Colors.blue),
    end: Circle(center: const Offset(100, 0), radius: 50, color: Colors.red),
  );

  late Animation<Circle> circleAnimation;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(vsync: this, duration: animDuration);
    circleAnimation = tween.animate(_ctrl);
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
      behavior: HitTestBehavior.opaque,
      child: Center(
        child: AnimatedBuilder(
          builder: _buildByAnim,
          animation: _ctrl,
        ),
      ),
    );
  }

  void _startAnim() {
    _ctrl.reset();
    _ctrl.forward();
  }

  Widget _buildByAnim(BuildContext context, Widget? child) =>
      CircleWidget(circle: circleAnimation.value);
}

class CircleWidget extends StatelessWidget {
  final Circle circle;

  const CircleWidget({Key? key, required this.circle}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      transform:
          Matrix4.translationValues(circle.center.dx, circle.center.dy, 0),
      width: circle.radius * 2,
      height: circle.radius * 2,
      decoration: BoxDecoration(color: circle.color, shape: BoxShape.circle),
    );
  }
}
