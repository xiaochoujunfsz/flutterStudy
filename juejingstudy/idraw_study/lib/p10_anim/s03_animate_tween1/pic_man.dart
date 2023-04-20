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
  late Animation<Color?> _colorCtrl; // 声明颜色控制器
  late Animation<double> _angleCtrl; // 声明角度控制器

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));
    // 使用 double 范围 [10,40] 的 Tween 创建动画器
    _angleCtrl = _controller.drive(Tween(begin: 10, end: 40));
    // 使用 color 范围 [Colors.blue,Colors.red] 的 ColorTween 创建动画器
    _colorCtrl =
        ColorTween(begin: Colors.blue, end: Colors.red).animate(_controller);
    // 重复执行动画
    _controller.repeat(reverse: true);
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: const Size(100, 100),
      painter: PicManPainter(
          color: _colorCtrl, angle: _angleCtrl, repaint: _controller),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class PicManPainter extends CustomPainter {
  final Animation<double> repaint;
  final Animation<double> angle;
  final Animation<Color?> color;

  Paint _paint = Paint();

  PicManPainter(
      {required this.repaint, required this.color, required this.angle})
      : super(repaint: repaint);

  @override
  void paint(Canvas canvas, Size size) {
    canvas.clipRect(Offset.zero & size); //剪切画布
    final double radius = size.width / 2;
    canvas.translate(radius, size.height / 2);

    _drawHead(canvas, size);
    _drawEye(canvas, radius);
  }

  @override
  bool shouldRepaint(PicManPainter oldDelegate) =>
      oldDelegate.repaint != repaint;

  //绘制头
  void _drawHead(Canvas canvas, Size size) {
    var rect = Rect.fromCenter(
        center: const Offset(0, 0), height: size.width, width: size.height);
    var a = angle.value / 180 * pi;
    canvas.drawArc(rect, a, 2 * pi - a.abs() * 2, true,
        _paint..color = color.value ?? Colors.black);
  }

  //绘制眼睛
  void _drawEye(Canvas canvas, double radius) {
    canvas.drawCircle(Offset(radius * 0.15, -radius * 0.6), radius * 0.12,
        _paint..color = Colors.white);
  }
}
