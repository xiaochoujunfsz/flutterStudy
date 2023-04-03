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
    // 通过 allSprites 创建 RSTransform 集合
    final List<RSTransform> transforms = allSprites
        .map((sprite) => RSTransform.fromComponents(
              rotation: sprite.rotation,
              scale: sprite.scale,
              anchorX: sprite.anchor.dx,
              anchorY: sprite.anchor.dy,
              translateX: sprite.offset.dx,
              translateY: sprite.offset.dy,
            ))
        .toList();
    // 通过 allSprites 创建 Rect 集合
    final List<Rect> rects =
        allSprites.map((sprite) => sprite.position).toList();
    canvas.drawAtlas(image!, transforms, rects, null, null, null, _paint);
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
