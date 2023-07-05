import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        body: Center(
          child: Container(
            width: 240,
            height: 100,
            color: Colors.grey.withAlpha(55),
            child: FittedBox(
              alignment: Alignment.topLeft,
              child: Container(
                width: 70,
                height: 70,
                alignment: Alignment.center,
                color: Colors.cyanAccent,
                child: const Text("BoxFit.contain"),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
