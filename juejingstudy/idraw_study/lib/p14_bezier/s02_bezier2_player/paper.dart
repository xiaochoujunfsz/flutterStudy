import 'package:flutter/material.dart';
import 'package:idraw_study/p14_bezier/coordinate_pro.dart';
import 'dart:ui' as ui;

import 'touch_info.dart';

class Paper extends StatefulWidget {
  const Paper({Key? key}) : super(key: key);

  @override
  State<Paper> createState() => _PaperState();
}

class _PaperState extends State<Paper> {
  final TouchInfo touchInfo = TouchInfo();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanDown: _onPanDown,
      onPanUpdate: _onPanUpdate,
      child: Container(
        color: Colors.white,
        child: CustomPaint(
          painter: PaperPainter(repaint: touchInfo),
        ),
      ),
    );
  }

  @override
  void dispose() {
    touchInfo.dispose();
    super.dispose();
  }

  //按下时
  void _onPanDown(DragDownDetails details) {
    if (touchInfo.points.length < 3) {
      touchInfo.addPoint(details.localPosition);
    } else {
      judgeZone(details.localPosition);
    }
  }

  //更新触点
  void _onPanUpdate(DragUpdateDetails details) {
    judgeZone(details.localPosition, update: true);
  }

  //判断哪个点被选中
  void judgeZone(Offset src, {bool update = false}) {
    for (int i = 0; i < touchInfo.points.length; i++) {
      if (judgeCircleArea(src, touchInfo.points[i], 15)) {
        touchInfo.selectIndex = i;
        if (update) {
          touchInfo.updatePoint(i, src);
        }
      }
    }
  }

  //判断出是否在某点的半径为r圆范围内
  bool judgeCircleArea(Offset src, Offset dst, double r) =>
      (src - dst).distance <= r;
}

class PaperPainter extends CustomPainter {
  Coordinate coordinate = Coordinate();

  final Paint _helpPaint = Paint()
    ..color = Colors.purple
    ..style = PaintingStyle.stroke
    ..strokeCap = StrokeCap.round;

  final TouchInfo repaint;

  PaperPainter({required this.repaint}) : super(repaint: repaint);
  List<Offset> pos = [];

  @override
  void paint(Canvas canvas, Size size) {
    coordinate.paint(canvas, size);
    canvas.translate(size.width / 2, size.height / 2);

    pos = repaint.points
        .map((e) => e.translate(-size.width / 2, -size.height / 2))
        .toList();

    Path path = Path();
    Paint paint = Paint()
      ..color = Colors.orange
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    if (pos.length < 3) {
      canvas.drawPoints(ui.PointMode.points, pos, _helpPaint..strokeWidth = 8);
    } else {
      path.moveTo(pos[0].dx, pos[0].dy);
      path.quadraticBezierTo(pos[1].dx, pos[1].dy, pos[2].dx, pos[2].dy);
      canvas.drawPath(path, paint);
      _drawHelp(canvas);
      _drawSelectPos(canvas, size);
    }
  }

  @override
  bool shouldRepaint(PaperPainter oldDelegate) =>
      oldDelegate.repaint != repaint;

  void _drawHelp(Canvas canvas) {
    _helpPaint.color = Colors.purple;
    canvas.drawPoints(ui.PointMode.polygon, pos, _helpPaint..strokeWidth = 1);
    canvas.drawPoints(ui.PointMode.points, pos, _helpPaint..strokeWidth = 8);
  }

  void _drawSelectPos(Canvas canvas, Size size) {
    Offset? selectPos = repaint.selectPoint;
    if (selectPos == null) return;
    selectPos = selectPos.translate(-size.width / 2, -size.height / 2);
    canvas.drawCircle(
        selectPos,
        10,
        _helpPaint
          ..color = Colors.green
          ..strokeWidth = 2);
  }
}
