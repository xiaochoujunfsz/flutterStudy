import 'package:flutter/material.dart';

void main() {
  runApp(Align(
    alignment: Alignment.center,
    child: ColoredBox(
      color: Colors.orange.withOpacity(0.2),
      child: CustomSingleChildLayout(
        delegate: PolarLayoutDelegate(),
        child: const SizedBox(
          width: 20,
          height: 20,
          child: ColoredBox(color: Colors.blue),
        ),
      ),
    ),
  ));
}

/*
    [1]: 子级受到松约束，最小尺寸是 0, 最大值是父级约束最大尺寸
    [2]: 自身尺寸是父级约束最大区域，其中的 [正方形区域]
    [3]: 子级相对于父级区域左上角偏移 [Offset(10, 10)]
 */
class PolarLayoutDelegate extends SingleChildLayoutDelegate {
  @override
  bool shouldRelayout(covariant SingleChildLayoutDelegate oldDelegate) => false;

  @override
  Size getSize(BoxConstraints constraints) {
    final radius = constraints.biggest.shortestSide;
    return Size(radius, radius);
  }

  @override
  BoxConstraints getConstraintsForChild(BoxConstraints constraints) {
    return constraints.loosen();
  }

  @override
  Offset getPositionForChild(Size size, Size childSize) {
    return const Offset(10, 10);
  }
}
