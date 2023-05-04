import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';

const double _kPiePadding = 20; // 饼状图边距

class ICharts extends StatefulWidget {
  const ICharts({Key? key}) : super(key: key);

  @override
  State<ICharts> createState() => _IChartsState();
}

class _IChartsState extends State<ICharts> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1500))
      ..forward();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        Container(
          width: 450,
          height: 300,
          padding: const EdgeInsets.all(20),
          color: Colors.blueAccent.withAlpha(33),
          child: CustomPaint(
            painter: ChartPainter(repaint: _controller),
          ),
        ),
        const Padding(
          padding: EdgeInsets.only(top: 8),
          child: Text(
            "捷特 3 月支出统计图 - 2040 年",
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
          ),
        )
      ],
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class ChartPainter extends CustomPainter {
  final TextPainter _textPainter =
      TextPainter(textDirection: TextDirection.ltr);

  final List<double> yData = [0.12, 0.25, 0.1, 0.18, 0.15, 0.2];
  final List<String> xData = ["学习资料", "伙食费", "话费", "游玩", "游戏", "其他"];
  final List<Color> colors = [
    Colors.red,
    Colors.orangeAccent,
    Colors.blue,
    Colors.green,
    Colors.purple,
    Colors.pink
  ];

  Paint fillPaint = Paint();
  Paint linePaint = Paint()
    ..color = Colors.red
    ..strokeCap = StrokeCap.round
    ..style = PaintingStyle.stroke;

  double radius = 0; // 饼图半径
  double maxData = 0; // 数据最大值

  final Animation<double> repaint;

  ChartPainter({required this.repaint}) : super(repaint: repaint) {
    maxData = yData.reduce(max);
  }

  @override
  void paint(Canvas canvas, Size size) {
    radius = size.shortestSide / 2 - _kPiePadding;
    canvas.drawRect(
        Offset.zero & size, Paint()..color = Colors.black.withAlpha(22));
    canvas.translate(size.width / 2, size.height / 2);
    canvas.rotate(-pi / 2);

    Path clipPath = Path();
    clipPath.lineTo(radius, 0);
    clipPath.arcTo(
        Rect.fromCenter(
            center: Offset.zero, width: radius * 4, height: radius * 4),
        0,
        2 * pi * repaint.value,
        false);
    clipPath.close();

    if (repaint.value != 1.0) {
      canvas.clipPath(clipPath);
    }

    drawPieChart(canvas);
    drawInfo(canvas);
  }

  @override
  bool shouldRepaint(ChartPainter oldDelegate) =>
      oldDelegate.repaint != repaint;

  void drawPieChart(Canvas canvas) {
    for (int i = 0; i < yData.length; i++) {
      Color color = colors[i % colors.length];
      Path path = Path();
      path.lineTo(radius, 0);
      path.arcTo(
          Rect.fromCenter(
              center: Offset.zero, width: radius * 2, height: radius * 2),
          0,
          2 * pi * yData[i],
          false);
      path.close();
      canvas.drawPath(
          path,
          fillPaint
            ..style = PaintingStyle.fill
            ..color = color);
      canvas.rotate(2 * pi * yData[i]);
    }
  }

  void drawInfo(Canvas canvas) {
    canvas.save();
    for (int i = 0; i < yData.length; i++) {
      Color color = colors[i % colors.length];
      canvas.save();
      canvas.rotate(2 * pi * yData[i] / 2);
      _drawAxisText(canvas, "${(yData[i] * 100).toStringAsFixed(1)}%",
          color: Colors.white,
          alignment: Alignment.center,
          offset: Offset(radius / 2 + 5, 0));
      Path showPath = Path();
      showPath.moveTo(radius, 0);
      showPath.relativeLineTo(15, 0);
      showPath.relativeLineTo(5, 10);
      canvas.drawPath(
        showPath,
        linePaint..color = color,
      );

      _drawAxisText(canvas, xData[i],
          color: color,
          fontSize: 9,
          alignment: Alignment.centerLeft,
          offset: Offset(radius + 5, 18));
      canvas.restore();
      canvas.rotate(2 * pi * yData[i]);
    }
    canvas.restore();
  }

  void _drawAxisText(Canvas canvas, String str,
      {Color color = Colors.black,
      double fontSize = 11,
      bool x = false,
      Alignment alignment = Alignment.centerRight,
      Offset offset = Offset.zero}) {
    TextSpan text = TextSpan(
        text: str,
        style: TextStyle(
          fontSize: fontSize,
          color: color,
        ));

    _textPainter.text = text;
    _textPainter.layout(); // 进行布局

    Size size = _textPainter.size;

    Offset offsetPos = Offset(-size.width / 2, -size.height / 2)
        .translate(-size.width / 2 * alignment.x + offset.dx, 0.0 + offset.dy);
    _textPainter.paint(canvas, offsetPos);
  }
}
