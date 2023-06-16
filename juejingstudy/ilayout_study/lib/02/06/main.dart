import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Flex(
      direction: Axis.horizontal,
      children: [
        Container(
          color: Colors.blue,
          width: 100,
          height: 100,
        )
      ],
    ),
  ));
}
