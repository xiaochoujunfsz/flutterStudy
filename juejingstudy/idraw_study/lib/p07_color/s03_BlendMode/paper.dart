import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:idraw_study/p07_color/coordinate_pro.dart';
import 'dart:ui' as ui;

class Paper extends StatefulWidget {
  const Paper({super.key});

  @override
  State<Paper> createState() => _PaperState();
}

class _PaperState extends State<Paper> {
  ui.Image? _image;

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
        painter: PaperPainter(_image),
      ),
    );
  }

  void _loadImage() async {
    _image = await loadImageFromAssets('assets/images/icon_head.png');
    setState(() {});
  }

  //读取 assets 中的图片
  Future<ui.Image>? loadImageFromAssets(String path) async {
    ByteData data = await rootBundle.load(path);
    return decodeImageFromList(data.buffer.asUint8List());
  }
}

class PaperPainter extends CustomPainter {
  final ui.Image? image;

  static const double step = 20;
  final Coordinate coordinate = Coordinate(step: step);

  // 颜色列表 256 个元素
  final List<Color> colors = List<Color>.generate(
      256, (index) => Color.fromARGB(255 - index, 255, 0, 0));

  PaperPainter(this.image);

  @override
  void paint(Canvas canvas, Size size) {
    if (image == null) {
      return;
    }
    Paint srcPaint = Paint();
    canvas.translate(size.width / 2, size.height / 2);
    canvas.translate(-step * 17, -step * 7);
    Paint dstPaint = Paint();
    BlendMode.values.asMap().forEach((i, value) {
      int line = i ~/ 10;
      int row = i % 10;
      canvas.save();

      canvas.translate(3.7 * step * row, 5.5 * step * line);
      canvas.drawImageRect(
          image!,
          Rect.fromPoints(
              Offset.zero, Offset(image!.width * 1.0, image!.height * 1.0)),
          Rect.fromCenter(
              center: Offset.zero, width: 25 * 2.0, height: 25 * 2.0),
          dstPaint);
      srcPaint
        ..color = const Color(0xFFFF0000)
        ..blendMode = value;
      canvas.drawRect(
          Rect.fromPoints(Offset.zero, const Offset(20 * 2.0, 20 * 2.0)),
          srcPaint);
      _simpleDrawText(canvas, value.toString().split(".")[1],
          offset: const Offset(-10, 50));
      canvas.restore();
    });
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;

  void _simpleDrawText(Canvas canvas, String str,
      {Offset offset = Offset.zero, Color color = Colors.black}) {
    var builder = ui.ParagraphBuilder(ui.ParagraphStyle(
      textAlign: TextAlign.left,
      fontSize: 11,
      textDirection: TextDirection.ltr,
      maxLines: 1,
    ))
      ..pushStyle(
          ui.TextStyle(color: color, textBaseline: ui.TextBaseline.alphabetic))
      ..addText(str);

    canvas.drawParagraph(
        builder.build()
          ..layout(ui.ParagraphConstraints(width: 11.0 * str.length)),
        offset);
  }
}
