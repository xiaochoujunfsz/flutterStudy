import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class CarView extends StatelessWidget {
  const CarView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      alignment: Alignment.center,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            "images/icon_car.png",
            width: 250,
            height: 400,
          ),
          SpeakView()
        ],
      ),
    );
  }
}

class SpeakView extends StatefulWidget {
  const SpeakView({Key key}) : super(key: key);

  @override
  _SpeakViewState createState() => _SpeakViewState();
}

class _SpeakViewState extends State<SpeakView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 50),
      child: Container(
        color: Colors.cyan,
        child: CustomPaint(
          painter: _SpeakPainter(),
        ),
      ),
    );
  }
}

class _SpeakPainter extends CustomPainter {
  double centerX;
  double centerY;

  @override
  void paint(Canvas canvas, Size size) {
    if (centerX == null) {
      centerX = size.width / 2;
    }
    if (centerY == null) {
      centerY = size.height / 4;
    }
    var paint = Paint()
      ..isAntiAlias = true
      ..color = Colors.red
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    //中间点与原点连线与y轴相交的角度
    double angleP = atan(centerX / centerY);
    double angle0 = atan(size.width / size.height);
    //第一个弧角度的1/2
    double angle1 = pi / 2 - 5 * angle0 / 4;
    //第一个弧半径
    double r1 = 40;
    //第一个弧长
    double l1 = 2 * angle1 * r1;

    //左上区域最大半径
    double leftTopLine = sqrt(pow(centerX, 2) + pow(centerY, 2));
    //间距15
    double leftTopSum = (leftTopLine - 40) / 15;
    //左上区域
    for (int i = 0; i < leftTopSum; i++) {
      double r = r1 + 15.0 * i;
      double l = l1 * (leftTopSum - i) / leftTopSum;
      Rect rect1 = Rect.fromCircle(center: Offset(centerX, centerY), radius: r);
      double sweepAngle = -l / r;
      double startAngle1 = 3 * pi / 2 - atan(centerX / centerY) + l / 2 / r;
      canvas.drawArc(rect1, startAngle1, sweepAngle, false, paint);
    }
    //左下区域最大半径
    double leftBottomLine = sqrt(pow(centerX, 2) + pow((size.height - centerY), 2));
    //间距15
    double leftBottomSum = (leftBottomLine - 40) / 15;
    //左下区域
    for (int i = 0; i < leftBottomSum; i++) {
      double r = r1 + 15.0 * i;
      double l = l1 * (leftBottomSum - i) / leftBottomSum;
      Rect rect1 = Rect.fromCircle(center: Offset(centerX, centerY), radius: r);
      double sweepAngle = l / r;
      double startAngle1 = pi / 2 + atan(centerX / (size.height - centerY)) - l / 2 / r;
      canvas.drawArc(rect1, startAngle1, sweepAngle, false, paint);
    }
    //右上区域最大半径
    double rightTopLine = sqrt(pow(size.width - centerX, 2) + pow(centerY, 2));
    //间距15
    double rightTopSum = (rightTopLine - 40) / 15;
    //右上区域
    for (int i = 0; i < rightTopSum; i++) {
      double r = r1 + 15.0 * i;
      double l = l1 * (rightTopSum - i) / rightTopSum;
      Rect rect1 = Rect.fromCircle(center: Offset(centerX, centerY), radius: r);
      double sweepAngle = l / r;
      double startAngle1 =
          3 * pi / 2 + atan((size.width - centerX) / centerY) - l / 2 / r;
      canvas.drawArc(rect1, startAngle1, sweepAngle, false, paint);
    }
    //右下区域最大半径
    double rightBottomLine = sqrt(pow(size.width - centerX, 2) + pow((size.height - centerY), 2));
    //间距15
    double rightBottomSum = (rightBottomLine - 40) / 15;
    //右下区域
    for (int i = 0; i < rightBottomSum; i++) {
      double r = r1 + 15.0 * i;
      double l = l1 * (rightBottomSum - i) / rightBottomSum;
      Rect rect1 = Rect.fromCircle(center: Offset(centerX, centerY), radius: r);
      double sweepAngle = -l / r;
      double startAngle1 =
          pi / 2 - atan((size.width - centerX) / (size.height - centerY)) + l / 2 / r;
      canvas.drawArc(rect1, startAngle1, sweepAngle, false, paint);
    }
  }

  @override
  bool shouldRepaint(_SpeakPainter oldDelegate) {}
}
