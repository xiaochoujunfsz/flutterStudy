import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HomePage'),
        elevation: 0,
      ),
      body: const SimpleExpandableText(),
    );
  }
}

class SimpleExpandableText extends StatefulWidget {
  const SimpleExpandableText({Key? key}) : super(key: key);

  @override
  State<SimpleExpandableText> createState() => _SimpleExpandableTextState();
}

class _SimpleExpandableTextState extends State<SimpleExpandableText> {
  final text = '桃树、杏树、梨树，你不让我，我不让你，都开满了花赶趟儿。\n'
      '红的像火，粉的像霞，白的像雪。\n'
      '花里带着甜味儿；闭了眼，树上仿佛已经满是桃儿、杏儿、梨儿。\n'
      '花下成千成百的蜜蜂嗡嗡地闹着，大小的蝴蝶飞来飞去。\n'
      '野花遍地是：杂样儿，有名字的，没名字的，散在草丛里，像眼睛，像星星，还眨呀眨的。';

  bool expand = false;
  int maxLines = 3;

  final TextStyle style = const TextStyle(
      fontSize: 15,
      color: Colors.grey,
      shadows: [Shadow(color: Colors.white, offset: Offset(1, 1))]);

  late TextPainter painter;

  TextStyle get textStyle => expand
      ? style.copyWith(overflow: null)
      : style.copyWith(overflow: TextOverflow.ellipsis);

  @override
  void initState() {
    super.initState();
    painter = TextPainter(
      text: TextSpan(text: text, style: style),
      maxLines: maxLines,
      textDirection: TextDirection.ltr,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: LayoutBuilder(builder: (_, BoxConstraints constraints) {
        painter.layout(maxWidth: constraints.maxWidth);
        if (!painter.didExceedMaxLines) {
          return Text(
            text,
            style: style,
          );
        }
        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              text,
              maxLines: expand ? null : 3,
              style: textStyle,
            ),
            GestureDetector(
              onTap: toggle,
              child: Text(
                expand ? '<< 收起' : '展开 >>',
                style: const TextStyle(color: Colors.blue),
              ),
            )
          ],
        );
      }),
    );
  }

  void toggle() {
    setState(() {
      expand = !expand;
    });
  }
}
