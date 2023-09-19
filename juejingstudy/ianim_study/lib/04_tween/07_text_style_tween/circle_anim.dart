import 'package:flutter/material.dart';

class CircleAnim extends StatefulWidget {
  const CircleAnim({Key? key}) : super(key: key);

  @override
  State<CircleAnim> createState() => _CircleAnimState();
}

class _CircleAnimState extends State<CircleAnim>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  final Duration animDuration = const Duration(milliseconds: 500);
  final TextStyleTween tween = TextStyleTween(
    begin: const TextStyle(
      color: Colors.blue,
      fontSize: 14,
      letterSpacing: 4,
    ),
    end: const TextStyle(
      color: Colors.purple,
      fontSize: 40,
      letterSpacing: 10,
    ),
  );

  late Animation<TextStyle> textAnimation;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(vsync: this, duration: animDuration);
    textAnimation = tween.animate(_ctrl);
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

  Widget _buildByAnim(BuildContext context, Widget? child) => Text(
        "张风捷特烈",
        style: textAnimation.value,
      );
}
