import 'dart:math';

import 'package:flutter/material.dart';

class CrossLoading extends StatefulWidget {
  final double size;

  const CrossLoading({Key? key, this.size = 100}) : super(key: key);

  @override
  State<CrossLoading> createState() => _CrossLoadingState();
}

class _CrossLoadingState extends State<CrossLoading> {
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(widget.size, widget.size),
      painter: CrossLoadingPainter(),
    );
  }
}

class CrossLoadingPainter extends CustomPainter {
  final double itemWidth;
  final Paint _paint = Paint();

  CrossLoadingPainter({this.itemWidth = 33});

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawRect(
        Offset.zero & size, Paint()..color = Colors.grey.withAlpha(11));
    canvas.translate(size.width / 2, size.height / 2);
    final double offset = -size.height / 2 + itemWidth / sqrt(2);
    drawDiamond(canvas, offset, const Color(0xffF44336));
  }

  @override
  bool shouldRepaint(CrossLoadingPainter oldDelegate) =>
      itemWidth != oldDelegate.itemWidth;

  void drawDiamond(Canvas canvas, double offset, Color color) {
    canvas.save();
    canvas.translate(0, offset);
    canvas.rotate(45 / 180 * pi);
    canvas.drawRect(
        Rect.fromCenter(
            center: Offset.zero, width: itemWidth, height: itemWidth),
        _paint..color = color);
    canvas.restore();
  }
}
