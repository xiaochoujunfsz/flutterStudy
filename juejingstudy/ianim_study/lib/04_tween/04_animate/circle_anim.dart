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

  // 1.定义 Color 泛型动画器
  late Animation<Color?> colorAnim;

  // 2.创建 ColorTween 对象
  final ColorTween tween = ColorTween(begin: Colors.blue, end: Colors.red);

  // 4. 使用颜色动画器
  Color? get color => colorAnim.value;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(vsync: this, duration: animDuration);
    // 3. 通过 animate 方法创建新动画器
    colorAnim = tween.animate(_ctrl);
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
