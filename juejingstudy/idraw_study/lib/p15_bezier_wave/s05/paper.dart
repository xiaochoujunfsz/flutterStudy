import 'package:flutter/material.dart';
import '../coordinate_pro.dart';

class Paper extends StatefulWidget {
  const Paper({Key? key}) : super(key: key);

  @override
  State<Paper> createState() => _PaperState();
}

class _PaperState extends State<Paper> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500))
      ..repeat();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: CustomPaint(
        painter:
            PaperPainter(CurveTween(curve: Curves.linear).animate(_controller)),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class PaperPainter extends CustomPainter {
  Coordinate coordinate = Coordinate();
  final Animation<double> repaint;

  PaperPainter(this.repaint) : super(repaint: repaint);

  double waveWidth = 80;
  double waveHeight = 10;
  double wrapHeight = 100; // 包裹高度

  @override
  void paint(Canvas canvas, Size size) {
    coordinate.paint(canvas, size);
    canvas.translate(size.width / 2, size.height / 2);
    // 添加裁剪
    //矩形
    // canvas.clipRect((Rect.fromCenter(
    //     center: Offset(waveWidth, 0), width: waveWidth * 2, height: 200.0)));

    //圆形
    // canvas.clipPath(Path()
    //   ..addOval(Rect.fromCenter(
    //       center: Offset(waveWidth, 0),
    //       width: waveWidth * 2,
    //       height: waveWidth * 2)));

    //椭圆
    // canvas.clipPath(Path()
    //   ..addOval(Rect.fromCenter(
    //       center: Offset(waveWidth, 0), width: waveWidth * 2, height: 200.0)));

    //圆角矩形
    canvas.clipPath(Path()
      ..addRRect(RRect.fromRectXY(
          Rect.fromCenter(
              center: Offset(waveWidth, 0),
              width: waveWidth * 2,
              height: 200.0),
          30,
          30)));
    Path path = Path();
    Paint paint = Paint()
      ..color = Colors.orange
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    path.relativeQuadraticBezierTo(
        waveWidth / 2, -waveHeight * 2, waveWidth, 0);
    path.relativeQuadraticBezierTo(waveWidth / 2, waveHeight * 2, waveWidth, 0);
    path.relativeQuadraticBezierTo(
        waveWidth / 2, -waveHeight * 2, waveWidth, 0);
    path.relativeQuadraticBezierTo(waveWidth / 2, waveHeight * 2, waveWidth, 0);
    path.relativeQuadraticBezierTo(
        waveWidth / 2, -waveHeight * 2, waveWidth, 0);
    path.relativeQuadraticBezierTo(waveWidth / 2, waveHeight * 2, waveWidth, 0);
    path.relativeLineTo(0, wrapHeight);
    path.relativeLineTo(-waveWidth * 3 * 2.0, 0);
    path.close();
    canvas.translate(-4 * waveWidth + 2 * waveWidth * repaint.value, 0);
    canvas.drawPath(path, paint..style = PaintingStyle.fill);

    canvas.translate(2 * waveWidth * repaint.value, 0);
    canvas.drawPath(path, paint..color = Colors.orange.withAlpha(88));
  }

  @override
  bool shouldRepaint(PaperPainter oldDelegate) =>
      oldDelegate.repaint != repaint;
}
