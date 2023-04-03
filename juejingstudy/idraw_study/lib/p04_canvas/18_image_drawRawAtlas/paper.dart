import 'dart:math';
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
    _image = await loadImageFromAssets('assets/images/shoot.png');
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
  final List<Sprite> allSprites = [];

  late Paint _paint;

  PaperPainter(this.image) {
    _paint = Paint()
      ..style = PaintingStyle.fill
      ..strokeWidth = strokeWidth
      ..color = color;
  }

  @override
  void paint(Canvas canvas, Size size) {
    if (image == null) {
      return;
    }
    coordinate.paint(canvas, size);
    allSprites.add(Sprite(
        position: const Rect.fromLTWH(0, 325, 257, 166),
        offset: Offset.zero,
        alpha: 255,
        rotation: 0));
    allSprites.add(Sprite(
        position: const Rect.fromLTWH(0, 325, 257, 166),
        offset: const Offset(257, 130),
        anchor: const Offset(50, 83),
        alpha: 255,
        rotation: pi / 2,
        scale: 0.5));
    Float32List rectList = Float32List(allSprites.length * 4);
    Float32List transformList = Float32List(allSprites.length * 4);

    for (int i = 0; i < allSprites.length; i++) {
      final Sprite sprite = allSprites[i];
      rectList[i * 4 + 0] = sprite.position.left;
      rectList[i * 4 + 1] = sprite.position.top;
      rectList[i * 4 + 2] = sprite.position.right;
      rectList[i * 4 + 3] = sprite.position.bottom;

      final RSTransform transform = RSTransform.fromComponents(
        rotation: sprite.rotation,
        scale: sprite.scale,
        anchorX: sprite.anchor.dx,
        anchorY: sprite.anchor.dy,
        translateX: sprite.offset.dx,
        translateY: sprite.offset.dy,
      );

      transformList[i * 4 + 0] = transform.scos;
      transformList[i * 4 + 1] = transform.ssin;
      transformList[i * 4 + 2] = transform.tx;
      transformList[i * 4 + 3] = transform.ty;
    }

    canvas.drawRawAtlas(
        image!, transformList, rectList, null, null, null, _paint);
  }

  @override
  bool shouldRepaint(PaperPainter oldDelegate) => image != oldDelegate.image;
}

class Sprite {
  Rect position; // 雪碧图 中 图片矩形区域
  Offset offset; // 移动偏倚
  Offset anchor; // 移动偏倚
  int alpha; // 透明度
  double rotation; // 旋转角度
  double scale; //缩放
  Sprite({
    this.offset = Offset.zero,
    this.anchor = Offset.zero,
    this.alpha = 255,
    this.rotation = 0,
    required this.position,
    this.scale = 1.0,
  });
}
