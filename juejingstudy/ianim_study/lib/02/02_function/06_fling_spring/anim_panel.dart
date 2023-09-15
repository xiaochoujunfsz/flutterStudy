import 'package:flutter/material.dart';
import 'spring_painter.dart';
import 'point_data.dart';

class AnimPanel extends StatefulWidget {
  const AnimPanel({Key? key}) : super(key: key);

  @override
  State<AnimPanel> createState() => _AnimPanelState();
}

class _AnimPanelState extends State<AnimPanel>
    with SingleTickerProviderStateMixin {
  PointData points = PointData();
  late AnimationController _ctrl;
  final Duration animDuration = const Duration(milliseconds: 1000);

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
        vsync: this, duration: animDuration, lowerBound: 50, upperBound: 100)
      ..addListener(_collectPoint);
  }

  @override
  void dispose() {
    _ctrl.dispose();
    points.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _startAnim,
      child: Container(
        width: 200,
        height: 200,
        color: Colors.grey.withAlpha(11),
        child: CustomPaint(painter: SpringPainter(height: _ctrl)),
      ),
    );
  }

  void _collectPoint() {
    points.push(_ctrl.value);
  }

  void _startAnim() async {
    points.clear();
    _ctrl.reset();
    print('fling start!---${DateTime.now().toIso8601String()}----------');
    await _ctrl.fling(
        velocity: 10,
        springDescription: SpringDescription.withDampingRatio(
          mass: 1.0,
          stiffness: 1000.0,
          ratio: 3.0,
        ));
    print('fling end!---${DateTime.now().toIso8601String()}----------');
  }
}
