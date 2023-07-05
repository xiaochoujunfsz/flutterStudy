import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  final BoxConstraints addToChild = const BoxConstraints(
    maxWidth: 100,
    maxHeight: 280,
    minWidth: 50,
    minHeight: 25,
  );

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
              child: LayoutBuilder(
                builder: (_, constraints) {
                  print("ConstrainedBox 自身受到约束(FC): ${constraints}");
                  print("ConstrainedBox 额外施加约束(AC): ${addToChild}");
                  return _buildTestContent();
                },
              ),
            ),
          ),
        ));
  }

  Widget _buildTestContent() {
    return ConstrainedBox(
      constraints: addToChild,
      child: LayoutBuilder(
        builder: (_, constraints) {
          print("ConstrainedBox 传递的真实约束(PC): ${constraints}");
          return const ColoredBox(
            color: Colors.blue,
          );
        },
      ),
    );
  }
}
