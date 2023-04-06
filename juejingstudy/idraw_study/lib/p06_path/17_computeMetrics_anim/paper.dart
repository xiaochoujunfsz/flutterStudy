import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:idraw_study/p06_path/coordinate_pro.dart';

class Paper extends StatefulWidget {
  const Paper({super.key});

  @override
  State<Paper> createState() {
    return _PaperState();
  }
}

class _PaperState extends State<Paper> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 3))
          ..forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: CustomPaint(
        painter: PaperPainter(progress: _controller),
      ),
    );
  }
}

class PaperPainter extends CustomPainter {
  final Coordinate coordinate = Coordinate();
  final Animation<double> progress;

  PaperPainter({required this.progress}) : super(repaint: progress);

  @override
  void paint(Canvas canvas, Size size) {
    coordinate.paint(canvas, size);
    canvas.translate(size.width / 2, size.height / 2);

    Path path = Path();
    Paint paint = Paint()
      ..color = Colors.purple
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;

    path
      ..relativeMoveTo(0, 0)
      ..relativeLineTo(-30, 120)
      ..relativeLineTo(30, -30)
      ..relativeLineTo(30, 30)
      ..close();
    path.addOval(Rect.fromCenter(center: Offset.zero, width: 50, height: 50));

    PathMetrics pms = path.computeMetrics();
    for (var pm in pms) {
      Tangent? tangent = pm.getTangentForOffset(pm.length * progress.value);
      if (tangent == null) {
        return;
      }
      canvas.drawCircle(
          tangent.position, 5, Paint()..color = Colors.deepOrange);
    }
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(PaperPainter oldDelegate) =>
      oldDelegate.progress != progress;
}
