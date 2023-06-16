import 'dart:js';

import 'package:flutter/material.dart';

void main() {
  runApp(LayoutBuilder(builder: (context, constraints) {
    return MyApp(constraints);
  }));
}

class MyApp extends StatelessWidget {
  final BoxConstraints rootBoxConstraints;

  const MyApp(this.rootBoxConstraints, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LayoutBuilder(
        builder: (context, constraints) {
          //false 说明不是同一个对象
          print(identical(constraints, rootBoxConstraints));
          //true 说明值相等
          print(constraints == rootBoxConstraints);
          return const ColoredBox(color: Colors.blue);
        },
      ),
    );
  }
}
