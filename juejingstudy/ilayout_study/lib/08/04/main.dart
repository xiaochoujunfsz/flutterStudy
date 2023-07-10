import 'package:flutter/material.dart';

void main() {
  runApp(const Align(
    alignment: Alignment.topLeft,
    child: AspectRatio(
      aspectRatio: 0.5,
      child: ColoredBox(
        color: Colors.blue,
      ),
    ),
  ));
}
