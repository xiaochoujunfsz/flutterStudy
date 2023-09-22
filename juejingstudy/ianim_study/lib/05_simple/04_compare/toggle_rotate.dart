import 'dart:math';

import 'package:flutter/material.dart';

class ToggleRotate extends StatefulWidget {
  //子组件
  final Widget child;

  //动画结束回调
  final ValueChanged<bool>? onEnd;

  //点击事件
  final VoidCallback? onTap;

  //起始角度
  final double beginAngle;

  //终止角度
  final double endAngle;

  //动画时长
  final int durationMs;

  //是否顺时针旋转
  final bool clockwise;

  //动画曲线
  final Curve curve;

  const ToggleRotate({
    Key? key,
    required this.child,
    this.onEnd,
    this.onTap,
    this.beginAngle = 0,
    this.endAngle = 90,
    this.durationMs = 200,
    this.clockwise = true,
    this.curve = Curves.fastOutSlowIn,
  }) : super(key: key);

  @override
  State<ToggleRotate> createState() => _ToggleRotateState();
}

class _ToggleRotateState extends State<ToggleRotate>
    with SingleTickerProviderStateMixin {
  bool _rotated = false;
  late AnimationController _controller;
  late Animation<double> _rotateAnim;

  double get rad => widget.clockwise ? _rotateAnim.value : -_rotateAnim.value;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this, duration: Duration(milliseconds: widget.durationMs));
    _initTweenAnim();
  }

  @override
  void didUpdateWidget(covariant ToggleRotate oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.durationMs != oldWidget.durationMs) {
      _controller.dispose();
      _controller = AnimationController(
          vsync: this, duration: Duration(milliseconds: widget.durationMs));
    }
    if (widget.beginAngle != oldWidget.beginAngle ||
        widget.endAngle != oldWidget.endAngle ||
        widget.curve != oldWidget.curve ||
        widget.durationMs != oldWidget.durationMs) {
      _initTweenAnim();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: _toggleRotate,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (_, __) => Transform(
          transform: Matrix4.rotationZ(rad),
          alignment: Alignment.center,
          child: widget.child,
        ),
      ),
    );
  }

  void _initTweenAnim() {
    _rotateAnim = Tween<double>(
            begin: widget.beginAngle / 180 * pi,
            end: widget.endAngle / 180 * pi)
        .chain(CurveTween(curve: widget.curve))
        .animate(_controller);
  }

  void _toggleRotate() async {
    widget.onTap?.call();
    if (_rotated) {
      await _controller.reverse();
    } else {
      await _controller.forward();
    }
    _rotated = !_rotated;
    widget.onEnd?.call(_rotated);
  }
}
