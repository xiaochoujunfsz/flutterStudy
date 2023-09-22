import 'dart:math';

import 'package:flutter/material.dart';

typedef BurstMenuItemClick = bool Function(int index);

class BurstMenu extends StatefulWidget {
  final List<Widget> menus;
  final Widget center;
  final BurstMenuItemClick? burstMenuItemClick;

  const BurstMenu(
      {Key? key,
      required this.menus,
      required this.center,
      this.burstMenuItemClick})
      : super(key: key);

  @override
  State<BurstMenu> createState() => _BurstMenuState();
}

class _BurstMenuState extends State<BurstMenu>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  bool _closed = true;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Flow(
      delegate: _CircleFlowDelegate(animation: _controller),
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

  final Animation<double> animation;

  _CircleFlowDelegate(
      {this.swapAngle = 120, this.startAngle = -60, required this.animation})
      : super(repaint: animation);

  @override
  void paintChildren(FlowPaintingContext context) {
    double radius = context.size.shortestSide / 2;
    final int count = context.childCount - 1;
    final double perRad = swapAngle / 180 * pi / (count - 1);
    double rotate = startAngle / 180 * pi;
    for (int i = 0; i < count; i++) {
      final double cSizeX = context.getChildSize(i)!.width / 2;
      final double cSizeY = context.getChildSize(i)!.height / 2;
      final double offsetX =
          animation.value * (radius - cSizeX) * cos(i * perRad + rotate) +
              radius;
      final double offsetY =
          animation.value * (radius - cSizeY) * sin(i * perRad + rotate) +
              radius;
      context.paintChild(i,
          transform:
              Matrix4.translationValues(offsetX - cSizeX, offsetY - cSizeY, 0));
    }
    context.paintChild(context.childCount - 1,
        transform: Matrix4.translationValues(
          radius - context.getChildSize(context.childCount - 1)!.width / 2,
          radius - context.getChildSize(context.childCount - 1)!.height / 2,
          0,
        ));
  }

  @override
  bool shouldRepaint(_CircleFlowDelegate oldDelegate) =>
      swapAngle != oldDelegate.swapAngle ||
      startAngle != oldDelegate.startAngle;
}
