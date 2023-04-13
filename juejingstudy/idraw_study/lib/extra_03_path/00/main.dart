import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:idraw_study/extra_03_path/coordinate_pro.dart';

void main() {
  runApp(const PathHit());
}

class PathHit extends StatefulWidget {
  const PathHit({Key? key}) : super(key: key);

  @override
  State<PathHit> createState() => _PathHitState();
}

class _PathHitState extends State<PathHit> {
  ValueNotifier<Offset> pos = ValueNotifier(Offset.zero);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: _onTapDown,
      child: CustomPaint(
        painter: PathPainter(),
      ),
    );
  }

  void _onTapDown(TapDownDetails details) {
    pos.value = details.localPosition;
  }
}

class PathPainter extends CustomPainter {
  Coordinate coordinate = Coordinate();

  @override
  void paint(Canvas canvas, Size size) {
    coordinate.paint(canvas, size);
    Paint paint = Paint()..style = PaintingStyle.stroke;
    Path path = Path()
      ..moveTo(0, 0)
      ..relativeLineTo(40, 40)
      ..relativeLineTo(0, -40)
      ..close();

    Matrix4 m4 = Matrix4.translationValues(size.width / 2, size.height / 2, 0);
    Matrix4 center = Matrix4.translationValues(20, 20, 0);
    Matrix4 back = Matrix4.translationValues(-20, -20, 0);

    Matrix4 rotateM4 = Matrix4.rotationZ(10 * pi / 180);
    Matrix4 scaleM4 = Matrix4.diagonal3Values(2, 2, 1);
    m4.multiply(center);
    m4.multiply(rotateM4);
    m4.multiply(scaleM4);
    m4.multiply(back);
    path = path.transform(m4.storage);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
