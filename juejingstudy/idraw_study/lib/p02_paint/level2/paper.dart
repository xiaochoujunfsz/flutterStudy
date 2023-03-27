import 'package:flutter/material.dart';

class Paper extends StatelessWidget {
  const Paper({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: CustomPaint(
        painter: PaperPainter(),
      ),
    );
  }
}

class PaperPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // drawStrokeCap(canvas);
    // drawStrokeJoin(canvas);
    drawStrokeMiterLimit(canvas);
  }

  //测试线帽类型 strokeCap属性
  void drawStrokeCap(Canvas canvas) {
    Paint paint = Paint();
    paint
      ..style = PaintingStyle.stroke
      ..color = Colors.red
      ..strokeWidth = 20;
    //不出头
    canvas.drawLine(const Offset(50, 50), const Offset(50, 150),
        paint..strokeCap = StrokeCap.butt);
    //圆头
    canvas.drawLine(const Offset(100, 50), const Offset(100, 150),
        paint..strokeCap = StrokeCap.round);
    //方头
    canvas.drawLine(const Offset(150, 50), const Offset(150, 150),
        paint..strokeCap = StrokeCap.square);
  }

  //测试线接类型 strokeJoin属性
  void drawStrokeJoin(Canvas canvas) {
    Paint paint = Paint();
    Path path = Path();
    paint
      ..style = PaintingStyle.stroke
      ..strokeWidth = 20
      ..color = Colors.blue;
    path.moveTo(50, 50);
    path.lineTo(50, 150);
    path.relativeLineTo(100, -50);
    path.relativeLineTo(0, 100);
    //斜角
    canvas.drawPath(path, paint..strokeJoin = StrokeJoin.bevel);

    path.reset();
    path.moveTo(50 + 150, 50);
    path.lineTo(50 + 150, 150);
    path.relativeLineTo(100, -50);
    path.relativeLineTo(0, 100);
    //锐角
    canvas.drawPath(path, paint..strokeJoin = StrokeJoin.miter);

    path.reset();
    path.moveTo(50 + 150 * 2, 50);
    path.lineTo(50 + 150 * 2, 150);
    path.relativeLineTo(100, -50);
    path.relativeLineTo(0, 100);
    //圆角
    canvas.drawPath(path, paint..strokeJoin = StrokeJoin.round);
  }

  //测试斜接限制 strokeMiterLimit属性 只适用于【StrokeJoin.miter】
  void drawStrokeMiterLimit(Canvas canvas) {
    Paint paint = Paint();
    Path path = Path();
    paint
      ..style = PaintingStyle.stroke
      ..color = Colors.blue
      ..strokeJoin = StrokeJoin.miter
      ..strokeWidth = 20;
    for (int i = 0; i < 4; i++) {
      path.reset();
      path.moveTo(50 + 150.0 * i, 50);
      path.lineTo(50 + 150.0 * i, 150);
      path.relativeLineTo(100, -(40.0 * i + 20));
      canvas.drawPath(path, paint..strokeMiterLimit = 2);
    }
    for (int i = 0; i < 4; i++) {
      path.reset();
      path.moveTo(50 + 150.0 * i, 50 + 150.0);
      path.lineTo(50 + 150.0 * i, 150 + 150.0);
      path.relativeLineTo(100, -(40.0 * i + 20));
      canvas.drawPath(path, paint..strokeMiterLimit = 3);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
