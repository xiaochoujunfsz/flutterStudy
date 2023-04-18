import 'package:flutter/material.dart';
import 'package:idraw_study/p09/s03_pic_man/pic_man.dart';

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
      body: Padding(
        padding: const EdgeInsets.only(top: 58, left: 20),
        child: CustomPaint(
          size: const Size(100, 100),
          painter: PicMan(),
        ),
      ),
    );
  }
}
