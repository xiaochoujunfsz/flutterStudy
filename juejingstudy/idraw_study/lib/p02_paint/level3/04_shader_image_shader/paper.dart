import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/material.dart';
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
    _loadImage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: hasImage
          ? CustomPaint(
              painter: ImageShaderPainter(_img),
            )
          : Container(),
    );
  }

  void _loadImage() async {
    _img = await loadImage(const AssetImage("assets/images/wy_200x300.jpg"));
    setState(() {});
  }

  late ImageStreamListener listener;

  //异步加载图片成为ui.Image
  Future<ui.Image> loadImage(ImageProvider provider) {
    Completer<ui.Image> completer = Completer<ui.Image>();
    ImageStream stream = provider.resolve(const ImageConfiguration());
    listener = ImageStreamListener((info, synchronousCall) {
      //监听图片流，获取图片
      final ui.Image image = info.image;
      completer.complete(image);
      stream.removeListener(listener);
    });
    stream.addListener(listener);
    return completer.future;
  }
}

class ImageShaderPainter extends CustomPainter {
  ui.Image? img;
  late Paint _paint;

  ImageShaderPainter(this.img) {
    _paint = Paint();
  }

  @override
  void paint(Canvas canvas, Size size) {
    if (img == null) {
      return;
    }
    _paint.shader = ImageShader(
        img!,
        TileMode.repeated,
        TileMode.repeated,
        Float64List.fromList([
          1, 0, 0, 0,
          0, 1, 0, 0,
          0, 0, 1, 0,
          0, 0, 0, 1,
        ]));
    canvas.drawCircle(const Offset(100, 100), 50, _paint);
    canvas.drawCircle(
        const Offset(100 + 120, 100),
        50,
        _paint
          ..strokeWidth = 10
          ..style = PaintingStyle.stroke);
    canvas.drawLine(
        const Offset(100 + 120 * 2, 50),
        const Offset(100 + 120 * 2, 50 + 100),
        _paint
          ..strokeWidth = 30
          ..style = PaintingStyle.stroke);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
