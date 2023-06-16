import 'package:flutter/material.dart';

void main() {
  runApp(CustomSingleChildLayout(
    delegate: DiyLayoutDelegate(),
    child: const ColoredBox(color: Colors.blue),
  ));
}

class DiyLayoutDelegate extends SingleChildLayoutDelegate {
  @override
  bool shouldRelayout(covariant SingleChildLayoutDelegate oldDelegate) => false;

  @override
  BoxConstraints getConstraintsForChild(BoxConstraints constraints) {
    return BoxConstraints.tight(const Size(100, 100));
  }
}
