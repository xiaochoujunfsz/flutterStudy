import 'dart:math';

import 'package:flutter/material.dart';

class CurveBox extends StatefulWidget {
  final Color color;
  final Curve curve;

  const CurveBox(
      {Key? key, this.color = Colors.lightBlue, this.curve = Curves.linear})
      : super(key: key);

  @override
  State<CurveBox> createState() => _CurveBoxState();
}

class _CurveBoxState extends State<CurveBox>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _angleAnimation;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 3));
    _angleAnimation = CurveTween(curve: widget.curve).animate(_controller);
    _controller.repeat();
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: const Size(100, 100),
      painter: CurveBoxPainter(_controller, _angleAnimation),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class CurveBoxPainter extends CustomPainter {
  final Animation<double> repaint;
  Animation<double> angleAnimation;

  Paint _paint = Paint();

  CurveBoxPainter(this.repaint, this.angleAnimation) : super(repaint: repaint);

  @override
  void paint(Canvas canvas, Size size) {
    canvas.clipRect(Offset.zero & size);
    canvas.translate(size.width / 2, size.height / 2);
    _drawRing(canvas, size);
    _drawRedCircle(canvas, size);
    _drawGreenCircle(canvas, size);
  }

  @override
  bool shouldRepaint(CurveBoxPainter oldDelegate) =>
      oldDelegate.repaint != repaint;

  //绘制环
  void _drawRing(Canvas canvas, Size size) {
    const double strokeWidth = 5;
    _paint
      ..color = Colors.blue
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;
    canvas.drawCircle(Offset.zero, size.width / 2 - strokeWidth, _paint);
  }

  // 绘制红球
  void _drawRedCircle(Canvas canvas, Size size) {
    canvas.save();
    canvas.rotate(angleAnimation.value * 2 * pi);
    _paint
      ..color = Colors.red
      ..style = PaintingStyle.fill;
    canvas.drawCircle(
        Offset.zero.translate(0, -(size.width / 2 - 5)), 5, _paint);
    canvas.restore();
  }

  // 绘制绿球
  void _drawGreenCircle(Canvas canvas, Size size) {
    canvas.save();
    canvas.translate(0, angleAnimation.value * (size.height - 10));
    _paint
      ..color = Colors.green
      ..style = PaintingStyle.fill;
    canvas.drawCircle(
        Offset.zero.translate(0, -(size.width / 2 - 5)), 5, _paint);
    canvas.restore();
  }
}
