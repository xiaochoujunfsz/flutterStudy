import 'dart:async';

import 'package:flutter/material.dart';
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

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(vsync: this, duration: animDuration)
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
      onDoubleTap: _restartAnim,
      child: CustomPaint(
        painter: AnimPainter(points),
        size: const Size(200, 200),
      ),
    );
  }

  void _collectPoint() {
    points.push(_ctrl.value);
  }

  void _startAnim() async {
    points.clear();
    Timer(const Duration(milliseconds: 1500), _stop);
    print('start!---${DateTime.now().toIso8601String()}----------');
    _ctrl.repeat(reverse: true).orCancel.then((value) {
      print('cancel!---${DateTime.now().toIso8601String()}----------');
    }, onError: (e) {
      print('cancel!---$e----------');
    });
  }

  //停止动画
  void _stop() {
    _ctrl.stop();
  }

  //双击时反向开启动画
  void _restartAnim() {
    _ctrl.reverse();
  }
}
