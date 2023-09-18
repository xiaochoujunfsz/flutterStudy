import 'package:flutter/material.dart';
import 'package:ianim_study/03_curve/04/toly_curve.dart';
import 'anim_painter.dart';
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
  late Animation<double> curveAnim;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(vsync: this, duration: animDuration)
      ..addListener(_collectPoint);
    // curveAnim = CurvedAnimation(parent: _ctrl, curve: const X2Curve());
    curveAnim = CurvedAnimation(parent: _ctrl, curve: const DampingCurve());
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
      child: CustomPaint(
        painter: AnimPainter(points),
        size: const Size(200, 200),
      ),
    );
  }

  void _collectPoint() {
    points.push(curveAnim.value);
  }

  void _startAnim() async {
    _ctrl.reset();
    points.clear();
    print('start!---${DateTime.now().toIso8601String()}----------');
    await _ctrl.forward();
    print('done!---${DateTime.now().toIso8601String()}----------');
  }
}
