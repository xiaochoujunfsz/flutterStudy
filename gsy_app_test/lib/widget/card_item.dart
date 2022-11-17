import 'package:flutter/material.dart';
import 'package:gsy_app_test/common/style/style.dart';

class CardItem extends StatelessWidget {
  final Widget child;
  final EdgeInsets? margin;
  final Color? color;
  final RoundedRectangleBorder? shape;
  final double elevation;

  CardItem(
      {required this.child,
      this.margin,
      this.color,
      this.shape,
      this.elevation = 5.0});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: elevation,
      shape: shape ??
          const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(4))),
      color: color ?? ColorUtil.cardWhite,
      margin: margin ??
          const EdgeInsets.only(left: 10, top: 10, right: 10, bottom: 10),
      child: child,
    );
  }
}
