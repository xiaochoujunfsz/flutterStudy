import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(const Directionality(
      textDirection: TextDirection.ltr, child: FlowMenu()));
}

class FlowMenu extends StatefulWidget {
  static const List<IconData> menuItems = <IconData>[
    Icons.menu,
    Icons.home,
    Icons.new_releases,
    Icons.notifications,
    Icons.settings,
    // Icons.refresh,
    // Icons.close,
  ];

  const FlowMenu({Key? key}) : super(key: key);

  @override
  State<FlowMenu> createState() => _FlowMenuState();
}

class _FlowMenuState extends State<FlowMenu>
    with SingleTickerProviderStateMixin {
  late AnimationController menuAnimation;

  @override
  void initState() {
    super.initState();
    menuAnimation = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 250));
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: ColoredBox(
        color: Colors.orange.withOpacity(0.2),
        child: Flow(
          delegate: CircleFlowDelegate(menuAnimation: menuAnimation),
          children: FlowMenu.menuItems
              .map((IconData icon) => flowMenuItem(icon))
              .toList(),
        ),
      ),
    );
  }

  Widget flowMenuItem(IconData icon) {
    return RawMaterialButton(
      fillColor: Colors.blue,
      shape: const CircleBorder(),
      constraints: BoxConstraints.tight(const Size(40, 40)),
      onPressed: () {
        menuAnimation.status == AnimationStatus.completed
            ? menuAnimation.reverse()
            : menuAnimation.forward();
      },
      child: Icon(
        icon,
        color: Colors.white,
        size: 25.0,
      ),
    );
  }
}

class CircleFlowDelegate extends FlowDelegate {
  final Animation<double> menuAnimation;

  CircleFlowDelegate({required this.menuAnimation})
      : super(repaint: menuAnimation);

  @override
  void paintChildren(FlowPaintingContext context) {
    if (context.childCount == 0) {
      return;
    }
    final double radius = context.size.shortestSide / 2;
    final int count = context.childCount - 1;
    double angle = 120;
    double progress = menuAnimation.value;
    final double perRad = angle / 180 * pi / (count - 1);
    final double fixRotate = (angle / 2) / 180 * pi;
    if (progress != 0) {
      for (int i = 0; i < count; i++) {
        final Size size = context.getChildSize(i) ?? Size.zero;
        final double offsetX =
            progress * (radius - size.width / 2) * cos(i * perRad - fixRotate) +
                radius;
        final double offsetY = progress *
                (radius - size.height / 2) *
                sin(i * perRad - fixRotate) +
            radius;
        context.paintChild(i + 1,
            transform: Matrix4.translationValues(
                offsetX - size.width / 2, offsetY - size.height / 2, 0));
      }
    }

    final Size menuSize = context.getChildSize(0) ?? Size.zero;
    context.paintChild(0,
        transform: Matrix4.translationValues(
            radius - menuSize.width / 2, radius - menuSize.height / 2, 0));
  }

  @override
  bool shouldRepaint(covariant FlowDelegate oldDelegate) {
    return true;
  }

  @override
  BoxConstraints getConstraintsForChild(int i, BoxConstraints constraints) {
    return constraints.loosen();
  }

  @override
  Size getSize(BoxConstraints constraints) {
    final radius = constraints.biggest.shortestSide;
    return Size(radius, radius);
  }
}
