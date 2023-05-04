import 'dart:math';

import 'package:flutter/material.dart';

const double _kScaleHeight = 8; // 刻度高

class ICharts extends StatelessWidget {
  const ICharts({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 380,
      height: 260,
      padding: const EdgeInsets.all(20),
      color: Colors.blueAccent.withAlpha(33),
      child: CustomPaint(
        painter: ChartPainter(),
      ),
    );
  }
}

class ChartPainter extends CustomPainter {
  final TextPainter _textPainter =
      TextPainter(textDirection: TextDirection.ltr);

  // 测试数据
  final List<double> yData = [88, 98, 70, 80, 100, 75];
  final List<String> xData = ["7月", "8月", "9月", "10月", "11月", "12月"];
  Path axisPath = Path();
  Paint axisPaint = Paint()
    ..style = PaintingStyle.stroke
    ..strokeWidth = 1;
  Paint gridPaint = Paint()
    ..style = PaintingStyle.stroke
    ..color = Colors.grey
    ..strokeWidth = 0.5;
  Paint fillPaint = Paint()..color = Colors.red;

  double xStep = 0; // x 间隔
  double yStep = 0; // y 间隔
  double maxData = 0; // 数据最大值

  ChartPainter() {
    maxData = yData.reduce(max);
  }

  @override
  void paint(Canvas canvas, Size size) {
    //画背景
    canvas.drawRect(
        Offset.zero & size, Paint()..color = Colors.black.withAlpha(22));

    //画轴
    canvas.translate(0, size.height);
    canvas.translate(_kScaleHeight, -_kScaleHeight);

    axisPath.moveTo(-_kScaleHeight, 0);
    axisPath.relativeLineTo(size.width, 0);
    axisPath.moveTo(0, _kScaleHeight);
    axisPath.relativeLineTo(0, -size.height);
    canvas.drawPath(axisPath, axisPaint);

    drawYText(canvas, size);
    drawXText(canvas, size);
    drawBarChart(canvas, size);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;

  void drawYText(Canvas canvas, Size size) {
    canvas.save();
    yStep = (size.height - _kScaleHeight) / 5;
    double numStep = maxData / 5;
    for (int i = 0; i <= 5; i++) {
      if (i == 0) {
        _drawAxisText(canvas, "0", offset: const Offset(-10, 2));
        canvas.translate(0, -yStep);
        continue;
      }
      canvas.drawLine(
          Offset.zero, Offset(size.width - _kScaleHeight, 0), gridPaint);
      canvas.drawLine(const Offset(-_kScaleHeight, 0), Offset.zero, axisPaint);
      String str = (numStep * i).toStringAsFixed(0);
      _drawAxisText(canvas, str, offset: const Offset(-10, 2));
      canvas.translate(0, -yStep);
    }
    canvas.restore();
  }

  void drawXText(Canvas canvas, Size size) {
    xStep = (size.width - _kScaleHeight) / xData.length;
    canvas.save();
    canvas.translate(xStep, 0);
    for (int i = 0; i < xData.length; i++) {
      canvas.drawLine(Offset.zero, const Offset(0, _kScaleHeight), axisPaint);
      _drawAxisText(canvas, xData[i],
          alignment: Alignment.center, offset: Offset(-xStep / 2, 10));
      canvas.translate(xStep, 0);
    }
    canvas.restore();
  }

  void _drawAxisText(Canvas canvas, String str,
      {Color color = Colors.black,
      bool x = false,
      Alignment alignment = Alignment.centerRight,
      Offset offset = Offset.zero}) {
    TextSpan text = TextSpan(
        text: str,
        style: TextStyle(
          fontSize: 11,
          color: color,
        ));

    _textPainter.text = text;
    _textPainter.layout(); // 进行布局

    Size size = _textPainter.size;

    Offset offsetPos = Offset(-size.width / 2, -size.height / 2)
        .translate(-size.width / 2 * alignment.x + offset.dx, 0.0 + offset.dy);
    _textPainter.paint(canvas, offsetPos);
  }

  void drawBarChart(Canvas canvas, Size size) {
    canvas.save();
    for (int i = 0; i < xData.length; i++) {
      canvas.drawRect(
          Rect.fromLTWH(
              15, 0, 30, -(yData[i] / maxData * (size.height - _kScaleHeight))),
          fillPaint);
      canvas.translate(xStep, 0);
    }
    canvas.restore();
  }
}
