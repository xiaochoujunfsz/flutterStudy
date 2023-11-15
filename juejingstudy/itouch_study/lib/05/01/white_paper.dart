import 'package:flutter/material.dart';
import 'model/line.dart';
import 'model/point.dart';
import 'paper_painter.dart';
import 'model/paint_model.dart';

class WhitePaper extends StatefulWidget {
  const WhitePaper({super.key});

  @override
  State<WhitePaper> createState() => _WhitePaperState();
}

class _WhitePaperState extends State<WhitePaper> {
  final PaintModel paintModel = PaintModel();

  Color lineColor = Colors.black;
  double strokeWidth = 1;

  @override
  void dispose() {
    paintModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanDown: _initLineData,
      onPanUpdate: _collectPoint,
      onPanEnd: _doneALine,
      onPanCancel: _cancel,
      onDoubleTap: _clear,
      child: CustomPaint(
        size: MediaQuery.of(context).size,
        painter: PaperPainter(model: paintModel),
      ),
    );
  }

  void _initLineData(DragDownDetails details) {
    Line line = Line(color: lineColor, strokeWidth: strokeWidth);
    paintModel.pushLine(line);
  }

  void _collectPoint(DragUpdateDetails details) {
    paintModel.pushPoint(Point.fromOffset(details.localPosition));
  }

  void _doneALine(DragEndDetails details) {
    paintModel.doneLine();
  }

  void _cancel() {
    paintModel.removeEmpty();
  }

  void _clear() {
    paintModel.clear();
  }
}
