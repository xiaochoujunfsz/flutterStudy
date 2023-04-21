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
  final ValueNotifier<Color> _color = ValueNotifier<Color>(Colors.blue);

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this,
        duration: const Duration(seconds: 1),
        lowerBound: 10,
        upperBound: 40);
    _controller.addStatusListener(_statusListen);
    _controller.repeat(reverse: true);
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: const Size(100, 100),
      painter: PicManPainter(
          color: _color,
          angle: _controller,
          repaint: Listenable.merge([_controller, _color])),
    );
  }

  void _statusListen(AnimationStatus status) {
    switch (status) {
      //在正在开始时停止了
      case AnimationStatus.dismissed:
        _color.value = Colors.black;
        break;
      //运动中
      case AnimationStatus.forward:
        _color.value = Colors.blue;
        break;
      // 跑到终点，再跑回来的时候
      case AnimationStatus.reverse:
        _color.value = Colors.red;
        break;
      //跑到终点时
      case AnimationStatus.completed:
        _color.value = Colors.green;
        break;
    }
  }
}

class PicManPainter extends CustomPainter {
  final Animation<double> angle; // 角度(与x轴交角 角度制)
  final Listenable repaint;
  final ValueNotifier<Color> color; // 颜色
  Paint _paint = Paint();

  PicManPainter(
      {required this.color, required this.angle, required this.repaint})
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
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    print('-----shouldRepaint---------');
    return true;
  }

  //绘制头
  void _drawHead(Canvas canvas, Size size) {
    var rect = Rect.fromCenter(
        center: const Offset(0, 0), height: size.width, width: size.height);
    var a = angle.value / 180 * pi;
    canvas.drawArc(
        rect, a, 2 * pi - a.abs() * 2, true, _paint..color = color.value);
  }

  //绘制眼睛
  void _drawEye(Canvas canvas, double radius) {
    canvas.drawCircle(Offset(radius * 0.15, -radius * 0.6), radius * 0.12,
        _paint..color = Colors.white);
  }
}
