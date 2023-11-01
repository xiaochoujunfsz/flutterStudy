import 'package:flutter/material.dart';
import 'spring_painter.dart';

class SpringWidget extends StatefulWidget {
  const SpringWidget({Key? key}) : super(key: key);

  @override
  State<SpringWidget> createState() => _SpringWidgetState();
}

const double _kDefaultSpringHeight = 100; //弹簧默认高度
const double _kRateOfMove = 1.5; //移动距离与形变量比值

class _SpringWidgetState extends State<SpringWidget>
    with SingleTickerProviderStateMixin {
  ValueNotifier<double> height = ValueNotifier(_kDefaultSpringHeight);
  double s = 0; // 移动距离
  late AnimationController _ctrl;
  double laseMoveLen = 0;

  final Duration animDuration = const Duration(milliseconds: 400);

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(vsync: this, duration: animDuration)
      ..addListener(_updateHeightByAnim);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onVerticalDragUpdate: _updateHeight,
      onVerticalDragEnd: _animateToDefault,
      child: Container(
        width: 200,
        height: 200,
        color: Colors.grey.withAlpha(11),
        child: CustomPaint(
          painter: SpringPainter(
            height: height,
          ),
        ),
      ),
    );
  }

  double get dx => -s / _kRateOfMove;

  void _updateHeight(DragUpdateDetails details) {
    s += details.delta.dy;
    height.value = _kDefaultSpringHeight + dx;
  }

  @override
  void dispose() {
    _ctrl.dispose();
    height.dispose();
    super.dispose();
  }

  void _updateHeightByAnim() {
    s = laseMoveLen * (1 - _ctrl.value);
    height.value = _kDefaultSpringHeight + dx;
  }

  void _animateToDefault(DragEndDetails details) {
    laseMoveLen = s;
    _ctrl.forward(from: 0);
  }
}
