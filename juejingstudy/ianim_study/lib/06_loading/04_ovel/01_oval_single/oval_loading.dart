import 'dart:math';

import 'package:flutter/material.dart';

class OvalLoading extends StatefulWidget {
  final double size;

  const OvalLoading({Key? key, this.size = 150}) : super(key: key);

  @override
  State<OvalLoading> createState() => _OvalLoadingState();
}

class _OvalLoadingState extends State<OvalLoading>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> animation;

  @override
  void initState() {
    super.initState();
    _ctrl =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));
    animation = Tween(begin: -pi, end: pi).animate(_ctrl);
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _ctrl.repeat(),
      child: CustomPaint(
        size: Size(widget.size, widget.size),
        painter: OvalLoadingPainter(animation),
      ),
    );
  }
}

class OvalLoadingPainter extends CustomPainter {
  Animation<double> animation;
  final Paint _paint = Paint();
  final double radius;
  final double a;

  OvalLoadingPainter(this.animation, {this.radius = 15, this.a = 0.4})
      : super(repaint: animation);

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawRect(
        Offset.zero & size, Paint()..color = Colors.grey.withAlpha(11));
    double zoneSize = size.shortestSide / 2;
    canvas.translate(size.width / 2, size.height / 2);
    canvas.drawOval(
        Rect.fromCenter(
            center: Offset.zero,
            width: zoneSize * 2 - radius,
            height: zoneSize * a * 2 - radius),
        Paint()..style = PaintingStyle.stroke);
    double x = (zoneSize - radius) * f(animation.value);
    double y = (zoneSize - radius) * g(animation.value);
    canvas.drawCircle(
        Offset(x, y), radius, _paint..color = const Color(0xffF44336));
  }

  @override
  bool shouldRepaint(covariant OvalLoadingPainter oldDelegate) =>
      oldDelegate.a != a || oldDelegate.animation != animation;

  double f(double t) => cos(t);

  double g(double t) => a * sin(t);
}
