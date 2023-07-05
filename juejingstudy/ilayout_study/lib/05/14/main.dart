import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  final double width = 100;
  final double height = 80;

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
              child: LayoutBuilder(
                builder: (_, constraints) {
                  print("SizedOverflowBox 自身受到约束(FC): ${constraints}");
                  print("SizedOverflowBox(size:($width,$height))");
                  return _buildTestContent();
                },
              ),
            ),
          ),
        ));
  }

  Widget _buildTestContent() {
    return SizedOverflowBox(
      size: Size(width, height),
      child: LayoutBuilder(
        builder: (_, constraints) {
          print("SizedOverflowBox 传递的真实约束(PC): ${constraints}");
          return const SizedBox(
            width: 30,
            height: 30,
            child: ColoredBox(
              color: Colors.blue,
            ),
          );
        },
      ),
    );
  }
}
