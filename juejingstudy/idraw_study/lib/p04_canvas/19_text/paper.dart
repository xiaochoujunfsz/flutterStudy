import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../coordinate.dart';
import 'dart:ui' as ui;

class Paper extends StatelessWidget {
  const Paper({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: CustomPaint(
        painter: PaperPainter(),
      ),
    );
  }
}

class PaperPainter extends CustomPainter {
  final double strokeWidth = 0.5;
  final Color color = Colors.blue;
  final Coordinate coordinate = Coordinate();

  late Paint _paint;

  PaperPainter() {
    _paint = Paint()
      ..style = PaintingStyle.fill
      ..strokeWidth = strokeWidth
      ..color = color;
  }

  @override
  void paint(Canvas canvas, Size size) {
    coordinate.paint(canvas, size);
    canvas.translate(size.width / 2, size.height / 2);

    // _drawTextWithParagraph(canvas, TextAlign.left);
    // _drawTextWithParagraph(canvas, TextAlign.center);
    // _drawTextWithParagraph(canvas, TextAlign.right);

    // _drawTextPaint(canvas);
    // _drawTextPaintShowSize(canvas);
    _drawTextPaintWithPaint(canvas);
  }

  void _drawTextWithParagraph(Canvas canvas, TextAlign textAlign) {
    var builder = ui.ParagraphBuilder(ui.ParagraphStyle(
      textAlign: textAlign,
      fontSize: 40,
      textDirection: TextDirection.ltr,
      maxLines: 1,
    ));
    builder.pushStyle(
      ui.TextStyle(
          color: Colors.black87, textBaseline: ui.TextBaseline.alphabetic),
    );
    builder.addText("Flutter Unit");
    ui.Paragraph paragraph = builder.build();
    paragraph.layout(const ui.ParagraphConstraints(width: 300));
    canvas.drawParagraph(paragraph, const Offset(0, 0));
    canvas.drawRect(const Rect.fromLTRB(0, 0, 300, 40),
        _paint..color = Colors.blue.withAlpha(33));
  }

  void _drawTextPaint(Canvas canvas) {
    var textPainter = TextPainter(
      text: const TextSpan(
          text: 'Flutter Unit',
          style: TextStyle(fontSize: 40, color: Colors.black)),
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );
    //进行布局
    textPainter.layout();
    //进行绘制
    textPainter.paint(canvas, Offset.zero);
  }

  void _drawTextPaintShowSize(Canvas canvas) {
    TextPainter textPainter = TextPainter(
        text: const TextSpan(
          text: 'Flutter Unit',
          style: TextStyle(fontSize: 40, color: Colors.black),
        ),
        textAlign: TextAlign.center,
        textDirection: TextDirection.ltr);
    //进行布局
    textPainter.layout();
    //尺寸必须在布局后获取
    Size size = textPainter.size;
    textPainter.paint(canvas, Offset(-size.width / 2, -size.height / 2));

    canvas.drawRect(
        Rect.fromLTRB(0, 0, size.width, size.height)
            .translate(-size.width / 2, -size.height / 2),
        _paint..color = Colors.blue.withAlpha(33));
  }

  void _drawTextPaintWithPaint(Canvas canvas) {
    Paint textPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;
    TextPainter textPainter = TextPainter(
        text: TextSpan(
            text: 'Flutter Unit by 张风捷特烈',
            style: TextStyle(foreground: textPaint, fontSize: 40)),
        textAlign: TextAlign.center,
        textDirection: TextDirection.ltr);
    //进行布局
    textPainter.layout(maxWidth: 280);
    //尺寸必须在布局后获取
    Size size = textPainter.size;
    textPainter.paint(canvas, Offset(-size.width / 2, -size.height / 2));

    canvas.drawRect(
        Rect.fromLTRB(0, 0, size.width, size.height)
            .translate(-size.width / 2, -size.height / 2),
        _paint..color = Colors.blue.withAlpha(33));
  }

  @override
  bool shouldRepaint(PaperPainter oldDelegate) => false;
}
