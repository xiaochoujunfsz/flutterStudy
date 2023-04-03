import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../coordinate.dart';
import 'dart:ui' as ui;

class Paper extends StatefulWidget {
  const Paper({super.key});

  @override
  State<StatefulWidget> createState() => _PaperState();
}

class _PaperState extends State<Paper> {
  ui.Image? _image;

  @override
  void initState() {
    _loadImage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: CustomPaint(
        painter: PaperPainter(_image),
      ),
    );
  }

  void _loadImage() async {
    _image = await loadImageFromAssets('assets/images/wy_300x200.jpg');
    setState(() {});
  }

  Future<ui.Image> loadImageFromAssets(String path) async {
    ByteData data = await rootBundle.load(path);
    return decodeImageFromList(data.buffer.asUint8List());
  }
}

class PaperPainter extends CustomPainter {
  final ui.Image? image;
  final double strokeWidth = 0.5;
  final Color color = Colors.blue;
  final Coordinate coordinate = Coordinate();

  late Paint _paint;

  PaperPainter(this.image) {
    _paint = Paint()
      ..style = PaintingStyle.fill
      ..strokeWidth = strokeWidth
      ..color = color;
  }

  @override
  void paint(Canvas canvas, Size size) {
    coordinate.paint(canvas, size);
    canvas.translate(size.width / 2, size.height / 2);
    _drawImage(canvas);
    _drawImageRect(canvas);
  }

  @override
  bool shouldRepaint(PaperPainter oldDelegate) => image != oldDelegate.image;

  void _drawImage(Canvas canvas) {
    if (image != null) {
      canvas.drawImage(
          image!, Offset(-image!.width / 2, -image!.height / 2), _paint);
    }
  }

  void _drawImageRect(Canvas canvas) {
    if (image != null) {
      canvas.drawImageRect(
          image!,
          Rect.fromCenter(
              center: Offset(image!.width / 2, image!.height / 2),
              width: 60,
              height: 60),
          const Rect.fromLTRB(0, 0, 100, 100).translate(200, 0),
          _paint);

      canvas.drawImageRect(
          image!,
          Rect.fromCenter(
              center: Offset(image!.width / 2, image!.height / 2 - 60),
              width: 60,
              height: 60),
          const Rect.fromLTRB(0, 0, 100, 100).translate(-280, -100),
          _paint);
      canvas.drawImageRect(
          image!,
          Rect.fromCenter(
              center: Offset(image!.width / 2 + 60, image!.height / 2),
              width: 60,
              height: 60),
          const Rect.fromLTRB(0, 0, 100, 100).translate(-280, 50),
          _paint);
    }
  }
}
