import 'package:flutter/material.dart';
import 'package:idraw_study/p07_color/coordinate_pro.dart';

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
  static const double step = 20;
  final Coordinate coordinate = Coordinate(step: step);

  // 颜色列表 256 个元素
  final Color colors = const Color(0xffBBE9F7).withRed(0);

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint();

    canvas.save();
    canvas.translate(size.width / 2, size.height / 2);

    List<String> values = colors.value.toRadixString(2).split('').toList();

    //遍历列表  绘制矩形色块
    canvas.translate(-step * 4, -step * 2);
    values.asMap().forEach((i, v) {
      int line = (i % 8);
      int row = i ~/ 8;
      var topLeft = Offset(step * line, step * row);
      var rect = Rect.fromPoints(topLeft, topLeft.translate(step, step));
      canvas.drawRect(
          rect, paint..color = v == '0' ? Colors.red : Colors.black);
    });

    canvas.restore();
    coordinate.paint(canvas, size);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
