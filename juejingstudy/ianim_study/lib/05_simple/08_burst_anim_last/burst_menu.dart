import 'dart:math';

import 'package:flutter/material.dart';

enum BurstType {
  circle,
  topLeft,
  bottomLeft,
  topRight,
  bottomRight,
  halfCircle,
}

typedef BurstMenuItemClick = bool Function(int index);

class BurstMenu extends StatefulWidget {
  final List<Widget> menus;
  final Widget center;
  final double radius;
  final double startAngle;
  final double swapAngle;
  final double hideOpacity;
  final Duration duration;
  final BurstType burstType;
  final Curve curve;
  final BurstMenuItemClick? burstMenuItemClick;

  const BurstMenu(
      {Key? key,
      required this.menus,
      required this.center,
      this.radius = 100,
      this.swapAngle = 120,
      this.startAngle = -60,
      this.hideOpacity = 0,
      this.curve = Curves.ease,
      this.duration = const Duration(milliseconds: 300),
      this.burstType = BurstType.circle,
      this.burstMenuItemClick})
      : super(key: key);

  const BurstMenu.topLeft({
    super.key,
    required this.menus,
    this.burstMenuItemClick,
    this.radius = 100,
    required this.center,
    this.hideOpacity = 0,
    this.curve = Curves.ease,
    this.duration = const Duration(milliseconds: 300),
    this.burstType = BurstType.topLeft,
    this.swapAngle = 90,
    this.startAngle = 0,
  });

  const BurstMenu.bottomLeft({
    super.key,
    required this.menus,
    this.burstMenuItemClick,
    this.radius = 100,
    required this.center,
    this.hideOpacity = 0,
    this.curve = Curves.ease,
    this.duration = const Duration(milliseconds: 300),
    this.burstType = BurstType.bottomLeft,
    this.swapAngle = 90,
    this.startAngle = -90,
  });

  const BurstMenu.topRight({
    super.key,
    required this.menus,
    this.burstMenuItemClick,
    this.radius = 100,
    required this.center,
    this.hideOpacity = 0,
    this.curve = Curves.ease,
    this.duration = const Duration(milliseconds: 500),
    this.burstType = BurstType.topRight,
    this.swapAngle = -90,
    this.startAngle = 180,
  });

  const BurstMenu.bottomRight({
    super.key,
    required this.menus,
    this.burstMenuItemClick,
    this.radius = 100,
    required this.center,
    this.hideOpacity = 0,
    this.curve = Curves.ease,
    this.duration = const Duration(milliseconds: 300),
    this.burstType = BurstType.bottomRight,
    this.swapAngle = 90,
    this.startAngle = 180,
  });

  @override
  State<BurstMenu> createState() => _BurstMenuState();
}

class _BurstMenuState extends State<BurstMenu>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  bool _closed = true;
  late Animation<double> curveAnim; // 1.定义曲线动画

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300));
    curveAnim =
        CurvedAnimation(parent: _controller, curve: widget.curve); //<--2.创建曲线动画
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant BurstMenu oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.duration != oldWidget.duration) {
      _controller.dispose();
      _controller = AnimationController(duration: widget.duration, vsync: this);
    }
    if (widget.curve != oldWidget.curve ||
        widget.duration != oldWidget.duration) {
      curveAnim = CurvedAnimation(parent: _controller, curve: widget.curve);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.radius * 2,
      height: widget.burstType == BurstType.halfCircle
          ? widget.radius
          : widget.radius * 2,
      alignment: Alignment.center,
      child: Flow(
        delegate: _CircleFlowDelegate(
          animation: curveAnim,
          startAngle: widget.startAngle,
          swapAngle: widget.swapAngle,
          hideOpacity: widget.hideOpacity,
          burstType: widget.burstType,
        ),
        children: [
          ...widget.menus.asMap().keys.map((int index) => GestureDetector(
                onTap: () => _handleItemClick(index),
                child: widget.menus[index],
              )),
          GestureDetector(
            onTap: toggle,
            child: widget.center,
          )
        ],
      ),
    );
  }

  void toggle() {
    if (_closed) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
    _closed = !_closed;
  }

  _handleItemClick(int index) {
    if (widget.burstMenuItemClick == null) {
      toggle();
      return;
    }
    bool close = widget.burstMenuItemClick!.call(index);
    if (close) {
      toggle();
    }
  }
}

class _CircleFlowDelegate extends FlowDelegate {
  // 菜单圆弧的扫描角度
  final double swapAngle;

  // 菜单圆弧的起始角度
  final double startAngle;
  final double hideOpacity;
  final BurstType burstType;

  final Animation<double> animation;

  _CircleFlowDelegate(
      {this.swapAngle = 120,
      this.startAngle = -60,
      this.hideOpacity = 0.3,
      this.burstType = BurstType.circle,
      required this.animation})
      : super(repaint: animation);

  @override
  void paintChildren(FlowPaintingContext context) {
    double radius = context.size.shortestSide / 2;
    final double halfCenterSize =
        context.getChildSize(context.childCount - 1)!.width / 2;
    switch (burstType) {
      case BurstType.circle:
        paintWithOffset(context, Offset.zero);
        break;
      case BurstType.topLeft:
        Offset centerOffset =
            Offset(-radius + halfCenterSize, -radius + halfCenterSize);
        paintWithOffset(context, centerOffset);
        break;
      case BurstType.bottomLeft:
        Offset centerOffset =
            Offset(-radius + halfCenterSize, radius - halfCenterSize);
        paintWithOffset(context, centerOffset);
        break;
      case BurstType.topRight:
        Offset centerOffset =
            Offset(radius - halfCenterSize, -radius + halfCenterSize);
        paintWithOffset(context, centerOffset);
        break;
      case BurstType.bottomRight:
        Offset centerOffset =
            Offset(radius - halfCenterSize, radius - halfCenterSize);
        paintWithOffset(context, centerOffset);
        break;
      case BurstType.halfCircle:
        Offset centerOffset = Offset(radius, radius - halfCenterSize);
        paintWithOffset(context, centerOffset);
        break;
    }
  }

  @override
  bool shouldRepaint(_CircleFlowDelegate oldDelegate) => false;

  void paintWithOffset(FlowPaintingContext context, Offset centerOffset) {
    final double radius = context.size.shortestSide / 2;
    final int count = context.childCount - 1;
    final double perRad = swapAngle / 180 * pi / (count - 1);
    double rotate = startAngle / 180 * pi;
    if (animation.value > hideOpacity) {
      for (int i = 0; i < count; i++) {
        final double cSizeX = context.getChildSize(i)!.width / 2;
        final double cSizeY = context.getChildSize(i)!.height / 2;

        final double beforeRadius = (radius - cSizeX);
        final double now = beforeRadius + centerOffset.dy.abs();
        final swapRadius = (radius - cSizeX) / beforeRadius * now;
        final double offsetX =
            animation.value * swapRadius * cos(i * perRad + rotate) +
                radius +
                centerOffset.dx;
        final double offsetY =
            animation.value * swapRadius * sin(i * perRad + rotate) +
                radius +
                centerOffset.dy;
        context.paintChild(i,
            transform: Matrix4.translationValues(
                offsetX - cSizeX, offsetY - cSizeY, 0),
            opacity: animation.value);
      }
    }
    context.paintChild(context.childCount - 1,
        transform: Matrix4.translationValues(
          radius -
              context.getChildSize(context.childCount - 1)!.width / 2 +
              centerOffset.dx,
          radius -
              context.getChildSize(context.childCount - 1)!.height / 2 +
              centerOffset.dy,
          0,
        ));
  }
}
