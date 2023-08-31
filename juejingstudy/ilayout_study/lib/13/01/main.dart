import 'package:flutter/material.dart';

void main() {
  runApp(const Align(
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 50,
      height: 80,
      child: GestureDetector(
        onTap: () => printInfo(context),
        child: const ColoredBox(
          color: Colors.blue,
        ),
      ),
    );
  }

  void printInfo(BuildContext context) {
    RenderObject? renderObject = context.findRenderObject();
    if (renderObject != null && renderObject is RenderBox) {
      //获取尺寸
      print(renderObject.size);
      //获取相对屏幕左上角的偏移量
      print(renderObject.localToGlobal(Offset.zero));
    }
  }
}
