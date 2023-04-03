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
    _image = await loadImageFromAssets('assets/images/right_chat.png');
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
    _drawImageNine(canvas);
  }

  @override
  bool shouldRepaint(PaperPainter oldDelegate) => image != oldDelegate.image;

  void _drawImageNine(Canvas canvas) {
    if (image != null) {
      canvas.drawImageNine(
          image!,
          Rect.fromCenter(
              center: Offset(image!.width / 2, image!.height - 6),
              width: image!.width - 20,
              height: 2),
          Rect.fromCenter(center: Offset.zero, width: 300, height: 120),
          _paint);
      canvas.drawImageNine(
          image!,
          Rect.fromCenter(
              center: Offset(image!.width / 2, image!.height - 6.0),
              width: image!.width - 20.0,
              height: 2.0),
          Rect.fromCenter(center: Offset.zero, width: 100, height: 50)
              .translate(250, 0),
          _paint);
      canvas.drawImageNine(
          image!,
          Rect.fromCenter(
              center: Offset(image!.width / 2, image!.height - 6.0),
              width: image!.width - 20.0,
              height: 2.0),
          Rect.fromCenter(center: Offset.zero, width: 80, height: 250)
              .translate(-250, 0),
          _paint);
    }
  }
}
