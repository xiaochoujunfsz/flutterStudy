import 'package:flutter/material.dart';

void main() {
  runApp(const ColoredBox(
    color: Colors.blue,
    child: Align(
      alignment: Alignment.topLeft,
      child: SizedBox(
        width: 100,
        height: 100,
        child: ColoredBox(color: Colors.green),
      ),
    ),
  ));
}
