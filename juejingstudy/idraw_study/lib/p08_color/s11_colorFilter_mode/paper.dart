import 'dart:math';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:idraw_study/p08_color/coordinate_pro.dart';
import 'dart:ui' as ui;

class Paper extends StatefulWidget {
  const Paper({super.key});

  @override
  State<Paper> createState() => _PaperState();
}

class _PaperState extends State<Paper> {
  ui.Image? _img;

  bool get hasImage => _img != null;

  @override
  void initState() {
    super.initState();
    _loadImage();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: CustomPaint(
        painter: PaperPainter(_img),
      ),
    );
  }

  void _loadImage() async {
    _img = await loadImageFromAssets('assets/images/wy_200x300.jpg');
    setState(() {});
  }

  //读取 assets 中的图片
  Future<ui.Image>? loadImageFromAssets(String path) async {
    ByteData data = await rootBundle.load(path);
    return decodeImageFromList(data.buffer.asUint8List());
  }
}

class PaperPainter extends CustomPainter {
  ui.Image? img;

  PaperPainter(this.img);

  Coordinate coordinate = Coordinate();

  double get imgW => img!.width.toDouble();

  double get imgH => img!.height.toDouble();

  @override
  void paint(Canvas canvas, Size size) {
    if (img == null) return;
    coordinate.paint(canvas, size);
    canvas.translate(size.width / 2, size.height / 2);
    canvas.translate(-120 * 2.0 - imgW / 4, -imgH / 4);
    drawColorFilter(canvas);
  }

  @override
  bool shouldRepaint(PaperPainter oldDelegate) => true;

  void drawColorFilter(Canvas canvas) {
    var paint = Paint();
    paint.colorFilter = const ColorFilter.linearToSrgbGamma();
    _drawImage(canvas, paint);

    paint.colorFilter =
        const ColorFilter.mode(Colors.yellow, BlendMode.modulate);
    _drawImage(canvas, paint);

    paint.colorFilter =
        const ColorFilter.mode(Colors.yellow, BlendMode.difference);
    _drawImage(canvas, paint);

    paint.colorFilter = const ColorFilter.mode(Colors.blue, BlendMode.plus);
    _drawImage(canvas, paint);

    paint.colorFilter = const ColorFilter.mode(Colors.blue, BlendMode.lighten);
    _drawImage(canvas, paint);
  }

  void _drawImage(Canvas canvas, Paint paint) {
    canvas.drawImageRect(img!, Rect.fromLTRB(0, 0, imgW, imgH),
        Rect.fromLTRB(0, 0, imgW / 2, imgH / 2), paint);
    canvas.translate(120, 0);
  }
}
