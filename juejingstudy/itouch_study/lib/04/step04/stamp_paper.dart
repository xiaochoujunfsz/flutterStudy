import 'dart:math';

import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import 'stamp_data.dart';

class StampPaper extends StatefulWidget {
  const StampPaper({Key? key}) : super(key: key);

  @override
  State<StampPaper> createState() => _StampPaperState();
}

class _StampPaperState extends State<StampPaper>
    with SingleTickerProviderStateMixin {
  final StampData stamps = StampData();
  int gridCount = 3; //网格数
  double radius = 0; //图章半径
  double width = 0;
  int containsIndex = -1;

  late AnimationController _controller;
  final Duration animDuration = const Duration(milliseconds: 200);

  bool get contains => containsIndex != -1;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: animDuration)
      ..addListener(_listenAnim);
  }

  @override
  void dispose() {
    stamps.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.shortestSide * 0.8;
    radius = width / 2 / gridCount * 0.618;
    return GestureDetector(
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      onTapCancel: _removeLast,
      onDoubleTap: _clear,
      child: CustomPaint(
        // 图章在前景
        foregroundPainter: StampPainter(stamps: stamps, count: gridCount),
        // 网格在背景
        painter: BackGroundPainter(count: gridCount),
        size: Size(width, width),
      ),
    );
  }

  void _onTapDown(TapDownDetails details) {
    containsIndex = checkZone(details.localPosition);
    if (contains) {
      _controller.forward();
      return;
    }
    radius = width / 2 / gridCount * 0.618;
    stamps.push(Stamp(
        radius: radius, center: details.localPosition, color: Colors.grey));
  }

  void _onTapUp(TapUpDetails details) {
    if (contains) {
      return;
    }
    stamps.activeLast(
        color: stamps.stamps.length % 2 == 0 ? Colors.red : Colors.blue);
  }

  void _removeLast() {
    if (contains) {
      return;
    }
    stamps.removeLast();
  }

  void _clear() {
    stamps.clear();
  }

  int checkZone(Offset src) {
    for (int i = 0; i < stamps.stamps.length; i++) {
      Rect zone = Rect.fromCircle(
          center: stamps.stamps[i].center, radius: width / gridCount / 2);
      if (zone.contains(src)) {
        return i;
      }
    }
    return -1;
  }

  void _listenAnim() {
    if (_controller.value == 1) {
      _controller.reverse();
    }
    double rate = (0.9 - 1) * _controller.value + 1;
    stamps.animateAt(containsIndex, rate * radius);
  }
}

class StampPainter extends CustomPainter {
  final StampData stamps;
  final int count;
  final Paint _paint = Paint();
  final Paint _pathPaint = Paint()
    ..color = Colors.white
    ..style = PaintingStyle.stroke
    ..strokeWidth = 2;

  StampPainter({required this.stamps, this.count = 3}) : super(repaint: stamps);

  @override
  void paint(Canvas canvas, Size size) {
    Rect zone = Offset.zero & size;
    canvas.clipRect(zone);

    for (var element in stamps.stamps) {
      double length = size.width / count;
      int x = element.center.dx ~/ (size.width / count);
      int y = element.center.dy ~/ (size.width / count);
      double strokeWidth = element.radius * 0.07;
      Offset center = Offset(length * x + length / 2, length * y + length / 2);
      element.center = center;

      canvas.drawCircle(
          element.center, element.radius, _paint..color = element.color);
      canvas.drawPath(
          element.path,
          _pathPaint
            ..strokeWidth = strokeWidth
            ..color = Colors.white);
      canvas.drawCircle(element.center, element.radius + strokeWidth * 1.5,
          _pathPaint..color = element.color);
    }
  }

  @override
  bool shouldRepaint(covariant StampPainter oldDelegate) {
    return stamps != oldDelegate.stamps || count != oldDelegate.count;
  }
}

class BackGroundPainter extends CustomPainter {
  final int count;

  BackGroundPainter({this.count = 3});

  final Paint _pathPaint = Paint()
    ..style = PaintingStyle.stroke
    ..strokeWidth = 1;
  static const List<Color> colors = [
    Color(0xFFF60C0C),
    Color(0xFFF3B913),
    Color(0xFFE7F716),
    Color(0xFF3DF30B),
    Color(0xFF0DF6EF),
    Color(0xFF0829FB),
    Color(0xFFB709F4)
  ];

  static const List<double> pos = [
    1.0 / 7,
    2.0 / 7,
    3.0 / 7,
    4.0 / 7,
    5.0 / 7,
    6.0 / 7,
    1.0
  ];

  @override
  void paint(Canvas canvas, Size size) {
    Rect zone = Offset.zero & size;
    canvas.clipRect(zone);
    _pathPaint.shader = ui.Gradient.sweep(
        Offset(size.width / 2, size.height / 2),
        colors,
        pos,
        TileMode.mirror,
        pi / 2,
        pi);
    canvas.save();
    for (int i = 0; i < count - 1; i++) {
      canvas.translate(0, size.height / count);
      canvas.drawLine(Offset.zero, Offset(size.width, 0), _pathPaint);
    }
    canvas.restore();

    canvas.save();
    for (int i = 0; i < count - 1; i++) {
      canvas.translate(size.width / count, 0);
      canvas.drawLine(Offset.zero, Offset(0, size.height), _pathPaint);
    }
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant BackGroundPainter oldDelegate) {
    return count != oldDelegate.count;
  }
}
