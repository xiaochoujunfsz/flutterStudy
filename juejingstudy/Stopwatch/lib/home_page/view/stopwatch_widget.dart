import 'dart:math';

import 'package:flutter/material.dart';

class StopWatchWidget extends StatelessWidget {
  //半径
  final double radius;
  //当前的时间
  final Duration duration;
  //主题颜色-当前刻度颜色
  final Color? themeColor;
  //文字的样式
  final TextStyle? textStyle;
  //刻度的颜色
  final Color scaleColor;

  const StopWatchWidget(
      {Key? key,
      required this.radius,
      required this.duration,
      this.scaleColor = const Color(0xffDADADA),
      this.textStyle,
      this.themeColor})
      : super(key: key);

  TextStyle get commonStyle => TextStyle(
        fontSize: radius / 3.2,
        fontWeight: FontWeight.w100,
        fontFamily: 'IBMPlexMono',
        color: const Color(0xff343434),
      );

  @override
  Widget build(BuildContext context) {
    TextStyle style = textStyle ?? commonStyle;
    Color themeColor = this.themeColor ?? Theme.of(context).primaryColor;
    return CustomPaint(
      painter: StopwatchPainter(
          radius: radius,
          duration: duration,
          themeColor: themeColor,
          scaleColor: scaleColor,
          textStyle: style),
      size: Size(radius * 2, radius * 2),
    );
  }
}

const double _kScaleWidthRate = 0.4 / 10;
const _kIndicatorRadiusRate = 0.2 / 10;
const _kStrokeWidthRate = 0.8 / 135.0;

class StopwatchPainter extends CustomPainter {
  final Duration duration;
  final double radius;
  final Color themeColor;
  final Color scaleColor;
  final TextStyle textStyle;

  StopwatchPainter({
    required this.duration,
    required this.themeColor,
    required this.scaleColor,
    required this.radius,
    required this.textStyle,
  }) {
    indicatorPainter.color = themeColor;
    scalePainter
      ..style = PaintingStyle.stroke
      ..strokeWidth = _kStrokeWidthRate * radius;
  }

  final Paint scalePainter = Paint();
  final Paint indicatorPainter = Paint();

  final TextPainter textPainter = TextPainter(
    textAlign: TextAlign.center,
    textDirection: TextDirection.ltr,
  );

  @override
  void paint(Canvas canvas, Size size) {
    //平移到圆心
    canvas.translate(size.width / 2, size.height / 2);
    //画刻度
    drawScale(canvas, size);
    final double scaleLineWidth = size.width * _kScaleWidthRate;
    final double indicatorRadius = size.width * _kIndicatorRadiusRate;
    //保存画布状态
    canvas.save();
    int second = duration.inSeconds % 60;
    int milliseconds = duration.inMilliseconds % 1000;
    double radians = (second * 1000 + milliseconds) / (60 * 1000) * 2 * pi;
    //画刻度点
    canvas.rotate(radians);
    canvas.drawCircle(
        Offset(
          0,
          -size.width / 2 + scaleLineWidth + indicatorRadius,
        ),
        indicatorRadius / 2,
        indicatorPainter);
    //还原画布状态
    canvas.restore();
    //画文字
    drawText(canvas);
  }

  void drawText(Canvas canvas) {
    int minus = duration.inMinutes % 60;
    int second = duration.inSeconds % 60;
    int milliseconds = duration.inMilliseconds % 1000;
    //基本主题文字-不足2位用0左补齐
    String commonStr =
        '${minus.toString().padLeft(2, "0")}:${second.toString().padLeft(2, "0")}';
    //高亮主题文字-不足2位用0左补齐
    String highlightStr = ".${(milliseconds ~/ 10).toString().padLeft(2, "0")}";
    textPainter.text = TextSpan(text: commonStr, style: textStyle, children: [
      TextSpan(text: highlightStr, style: textStyle.copyWith(color: themeColor))
    ]);
    textPainter.layout(); // 进行布局
    final double width = textPainter.size.width;
    final double height = textPainter.size.height;
    textPainter.paint(canvas, Offset(-width / 2, -height / 2));
  }

  void drawScale(Canvas canvas, Size size) {
    final double scaleLineWidth = size.width * _kScaleWidthRate;
    //画180个刻度，当前刻度的颜色使用主题颜色
    for (int i = 0; i < 180; i++) {
      if (i == 90 + 45) {
        scalePainter.color = themeColor;
      } else {
        scalePainter.color = scaleColor;
      }
      canvas.drawLine(Offset(size.width / 2, 0),
          Offset(size.width / 2 - scaleLineWidth, 0), scalePainter);
      canvas.rotate(pi / 180 * 2);
    }
  }

  @override
  bool shouldRepaint(covariant StopwatchPainter oldDelegate) {
    return oldDelegate.duration != duration ||
        oldDelegate.textStyle != textStyle ||
        oldDelegate.themeColor != themeColor ||
        oldDelegate.scaleColor != scaleColor;
  }
}
