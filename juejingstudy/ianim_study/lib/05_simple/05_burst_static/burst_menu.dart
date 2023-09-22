import 'dart:math';

import 'package:flutter/material.dart';

class BurstMenu extends StatefulWidget {
  final List<Widget> menus;
  final Widget center;

  const BurstMenu({Key? key, required this.menus, required this.center})
      : super(key: key);

  @override
  State<BurstMenu> createState() => _BurstMenuState();
}

class _BurstMenuState extends State<BurstMenu> {
  @override
  Widget build(BuildContext context) {
    return Flow(
      delegate: _CircleFlowDelegate(),
      children: [...widget.menus, widget.center],
    );
  }
}

class _CircleFlowDelegate extends FlowDelegate {
  @override
  void paintChildren(FlowPaintingContext context) {
    double radius = context.size.shortestSide / 2;
    final int count = context.childCount - 1;
    final double perRad = 360 / 180 * pi / (count - 1);
    for (int i = 0; i < count; i++) {
      final double cSizeX = context.getChildSize(i)!.width / 2;
      final double cSizeY = context.getChildSize(i)!.height / 2;
      final double offsetX = (radius - cSizeX) * cos(i * perRad) + radius;
      final double offsetY = (radius - cSizeY) * sin(i * perRad) + radius;
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
  bool shouldRepaint(covariant FlowDelegate oldDelegate) => false;
}
