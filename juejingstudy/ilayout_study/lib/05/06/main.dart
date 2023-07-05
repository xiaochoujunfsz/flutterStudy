import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  final double maxWidth = 100;
  final double maxHeight = 280;

  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Scaffold(
          body: Center(
            child: Container(
              margin: const EdgeInsets.all(5),
              alignment: Alignment.topLeft,
              width: 250,
              height: 150,
              color: Colors.grey.withAlpha(33),
              child: Row(
                children: [
                  LayoutBuilder(
                    builder: (_, constraints) {
                      print("LimitedBox 自身受到约束(FC): ${constraints}");
                      print(
                          "LimitedBox{maxWidth: $maxWidth, maxHeight:$maxHeight}");
                      return _buildTestContent();
                    },
                  ),
                ],
              ),
            ),
          ),
        ));
  }

  Widget _buildTestContent() {
    return LimitedBox(
      maxWidth: maxWidth,
      maxHeight: maxHeight,
      child: LayoutBuilder(
        builder: (_, constraints) {
          print("LimitedBox 传递的真实约束(PC): ${constraints}");
          return ColoredBox(
            color: Colors.blue,
            child: Text('张风捷特烈 ' * 1000),
          );
        },
      ),
    );
  }
}
