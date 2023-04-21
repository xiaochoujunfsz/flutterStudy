import 'dart:math';

import 'package:flutter/material.dart';

class PicMan extends StatefulWidget {
  final Color color;

  const PicMan({Key? key, this.color = Colors.lightBlue}) : super(key: key);

  @override
  State<PicMan> createState() => _PicManState();
}

class _PicManState extends State<PicMan> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this,
        duration: const Duration(seconds: 1),
        lowerBound: 10,
        upperBound: 40);
    //执行运动直到上界，可指定初始值。(执行完就会停止)
    // _controller.forward();

    //执行运动直到下界，可指定初始值。(执行完就会停止)
    // _controller.reverse(from: 40);

    // _controller.repeat();
    // _controller.repeat(reverse: true);
    _controller.fling(velocity: 0.5);
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: const Size(100, 100),
      painter: PicManPainter(color: widget.color, angle: _controller),
    );
  }
}

class PicManPainter extends CustomPainter {
  final Animation<double> angle; // 角度(与x轴交角 角度制)
  final Color color; // 颜色
  Paint _paint = Paint();

  PicManPainter({this.color = Colors.yellowAccent, required this.angle})
      : super(repaint: angle);

  @override
  void paint(Canvas canvas, Size size) {
    canvas.clipRect(Offset.zero & size); //剪切画布
    final double radius = size.width / 2;
    canvas.translate(radius, size.height / 2);
    _drawHead(canvas, size);
    _drawEye(canvas, radius);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    print('-----shouldRepaint---------');
    return true;
  }

  //绘制头
  void _drawHead(Canvas canvas, Size size) {
    var rect = Rect.fromCenter(
        center: const Offset(0, 0), height: size.width, width: size.height);
    var a = angle.value / 180 * pi;
    canvas.drawArc(rect, a, 2 * pi - a.abs() * 2, true, _paint..color = color);
  }

  //绘制眼睛
  void _drawEye(Canvas canvas, double radius) {
    canvas.drawCircle(Offset(radius * 0.15, -radius * 0.6), radius * 0.12,
        _paint..color = Colors.white);
  }
}
