import 'package:flutter/material.dart';
import 'pic_man.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
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
        child: Center(
          child: Wrap(
            spacing: 20,
            runSpacing: 20,
            children: buildChildren(),
          ),
        ),
      ),
    );
  }

  List<Widget> buildChildren() => List<Widget>.generate(
      6,
      (index) => PicMan(
            color: Colors.lightBlue,
            angle: (1 + index) * 6.0, // 背景
          ));
}
