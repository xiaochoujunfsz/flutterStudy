import 'dart:typed_data';

import 'package:flutter/material.dart';

import 'dart:ui' as ui;

import 'package:flutter/services.dart';

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

  Future<ui.Image>? loadImageFromAssets(String path) async {
    ByteData data = await rootBundle.load(path);
    Uint8List bytes =
        data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
    return decodeImageFromList(bytes);
  }
}

class PaperPainter extends CustomPainter {
  ui.Image? img;

  double get imgW => img?.width.toDouble() ?? 0;

  double get imgH => img?.height.toDouble() ?? 0;

  PaperPainter(this.img);

  @override
  void paint(Canvas canvas, Size size) {
    if (img == null) return;
    drawColorFilter(canvas);
  }

  void drawColorFilter(Canvas canvas) {
    var paint = Paint();
    paint.colorFilter = const ColorFilter.linearToSrgbGamma();
    _drawImage(canvas, paint, move: false);

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

  void _drawImage(Canvas canvas, Paint paint, {bool move = true}) {
    if (move) {
      canvas.translate(120, 0);
    } else {
      canvas.translate(20, 20);
    }
    canvas.drawImageRect(img!, Rect.fromLTRB(0, 0, imgW, imgH),
        Rect.fromLTRB(0, 0, imgW / 2, imgH / 2), paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
