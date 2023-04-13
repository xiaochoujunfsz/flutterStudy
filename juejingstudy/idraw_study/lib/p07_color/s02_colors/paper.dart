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
  static const double step = 15;
  final Coordinate coordinate = Coordinate(step: step);

  // 颜色列表 256 个元素
  final List<Color> colors = List<Color>.generate(
      256, (index) => Color.fromARGB(255 - index, 255, 0, 0));

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint();

    canvas.save();
    canvas.translate(size.width / 2, size.height / 2);

    // 遍历列表 绘制矩形色块
    canvas.translate(-step * 8.0, -step * 8.0);
    colors.asMap().forEach((i, color) {
      int line = (i % 16);
      int row = i ~/ 16;
      var topLeft = Offset(step * line, step * row);
      var rect = Rect.fromPoints(topLeft, topLeft.translate(step, step));
      canvas.drawRect(rect, paint..color = color);
    });
    canvas.restore();
    coordinate.paint(canvas, size);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
