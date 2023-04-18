import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: _buildChild(),
    );
  }

  Widget _buildChild() {
    final Widget just = CustomPaint(
      painter: BgPainter(), // 背景
    );

    final Widget withSize = CustomPaint(
      size: const Size(100, 100),
      painter: BgPainter(), // 背景
    );

    final Widget withChild = CustomPaint(
      painter: BgPainter(),
      child: Container(
        width: 100,
        height: 100,
      ), // 背景
    );

    final Widget withLayoutBuilder = LayoutBuilder(
      builder: _builderByLayout,
    );

    return withLayoutBuilder;
  }

  Widget _builderByLayout(BuildContext context, BoxConstraints constraints) {
    return CustomPaint(
      size: Size(constraints.maxWidth, constraints.maxHeight),
      painter: BgPainter(), // 背景
    );
  }
}

class BgPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    print(size);
    canvas.drawRect(
        Rect.fromPoints(Offset.zero, Offset(size.width, size.height)),
        Paint()..color = Colors.red);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
