import 'package:flutter/material.dart';

class CircleHalo extends StatefulWidget {
  const CircleHalo({Key? key}) : super(key: key);

  @override
  State<CircleHalo> createState() => _CircleHaloState();
}

class _CircleHaloState extends State<CircleHalo> {
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: const Size(200, 200),
      painter: CircleHaloPainter(),
    );
  }
}

class CircleHaloPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    canvas.translate(size.width / 2, size.height / 2);
    final Paint paint = Paint()..style = PaintingStyle.stroke;
    paint.maskFilter = const MaskFilter.blur(BlurStyle.solid, 4);
    final Path circlePath = Path()
      ..addOval(
          Rect.fromCenter(center: const Offset(0, 0), width: 100, height: 100));
    Path circlePath2 = Path()
      ..addOval(Rect.fromCenter(
          center: const Offset(-1, 0), width: 100, height: 100));
    Path result =
        Path.combine(PathOperation.difference, circlePath, circlePath2);
    paint.shader = null;
    paint
      ..style = PaintingStyle.fill
      ..color = const Color(0xff00abf2);
    canvas.drawPath(result, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
