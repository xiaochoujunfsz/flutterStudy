import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
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
          child: Demo(),
        ),
      ),
    );
  }
}

class Demo extends StatelessWidget {
  Demo({Key? key}) : super(key: key);

  static const TextStyle textStyle =
      TextStyle(color: Colors.white, fontWeight: FontWeight.bold);

  final blueBox = Container(
    alignment: Alignment.center,
    color: Colors.blue,
    height: 100,
    width: 100,
    child: const Text(
      '1',
      style: textStyle,
    ),
  );

  final redBox = Container(
    alignment: Alignment.center,
    color: Colors.red,
    height: 80,
    width: 80,
    child: const Text(
      '2',
      style: textStyle,
    ),
  );
  final yellowBox = Container(
    alignment: Alignment.center,
    color: Colors.orange,
    height: 60,
    width: 60,
    child: const Text(
      '3',
      style: textStyle,
    ),
  );
  final greenBox = Container(
    alignment: Alignment.center,
    color: Colors.green,
    height: 40,
    width: 40,
    child: const Text(
      '4',
      style: textStyle,
    ),
  );

  final purpleBox = Container(
    alignment: Alignment.center,
    color: Colors.purple,
    height: 20,
    width: 20,
    child: const Text(
      '5',
      style: textStyle,
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Wrap(
        direction: Axis.vertical,
        spacing: 10,
        alignment: WrapAlignment.center,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          Container(
            margin: const EdgeInsets.all(5),
            width: 200,
            height: 120,
            color: Colors.green.withAlpha(33),
            child: Stack(
              fit: StackFit.loose,
              clipBehavior: Clip.none,
              children: [
                blueBox,
                redBox,
                yellowBox,
                Positioned(
                  right: 10,
                  top: 10,
                  child: greenBox,
                )
              ],
            ),
          ),
          const Text('Clip.none')
        ],
      ),
    );
  }
}
