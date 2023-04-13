import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:idraw_study/p07_color/coordinate_pro.dart';
import 'package:image/image.dart' as image;

class Paper extends StatefulWidget {
  const Paper({super.key});

  @override
  State<Paper> createState() => _PaperState();
}

class _PaperState extends State<Paper> {
  image.Image? _image;
  List<Ball> balls = [];
  double d = 4; //复刻的像素边长

  @override
  void initState() {
    super.initState();
    _initBalls();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: CustomPaint(
        painter: PaperPainter(balls),
      ),
    );
  }

  void _initBalls() async {
    _image = await loadImageFromAssets('assets/images/icon_head.png');
    if (_image == null) return;
    for (int i = 0; i < _image!.width; i++) {
      for (int j = 0; j < _image!.height; j++) {
        Ball ball = Ball();
        ball.x = i * d + d / 2;
        ball.y = j * d + d / 2;
        ball.r = d / 2;
        image.Pixel pixel = _image!.getPixel(i, j);
        var color = Color.fromARGB(
            pixel.a.toInt(), pixel.r.toInt(), pixel.g.toInt(), pixel.b.toInt());
        ball.color = color;
        balls.add(ball);
      }
    }
    setState(() {});
  }

  //读取 assets 中的图片
  Future<image.Image?> loadImageFromAssets(String path) async {
    ByteData data = await rootBundle.load(path);
    List<int> bytes = data.buffer.asUint8List();
    return image.decodeImage(Uint8List.fromList(bytes));
  }
}

class PaperPainter extends CustomPainter {
  late Paint _paint;

  final double strokeWidth = 0.5;
  final Color color = Colors.blue;

  final List<Ball> balls;
  final Coordinate coordinate = Coordinate();

  PaperPainter(this.balls) {
    _paint = Paint()
      ..style = PaintingStyle.fill
      ..strokeWidth = strokeWidth
      ..color = color;
  }

  @override
  void paint(Canvas canvas, Size size) {
    coordinate.paint(canvas, size);
    _drawImage(canvas);
  }

  @override
  bool shouldRepaint(PaperPainter oldDelegate) => balls != oldDelegate.balls;

  void _drawImage(Canvas canvas) {
    for (var ball in balls) {
      canvas.drawCircle(
          Offset(ball.x, ball.y), ball.r, _paint..color = ball.color);
    }
  }
}

class Ball {
  double x; //点位X
  double y; //点位Y
  Color color; //颜色
  double r; // 半径

  Ball({this.x = 0, this.y = 0, this.color = Colors.black, this.r = 5});
}
