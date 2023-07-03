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
    height: 20,
    width: 30,
    child: const Text(
      '1',
      style: textStyle,
    ),
  );

  final redBox = Container(
    alignment: Alignment.center,
    color: Colors.red,
    height: 35,
    width: 60,
    child: const Text(
      '2',
      style: textStyle,
    ),
  );
  final yellowBox = Container(
    alignment: Alignment.center,
    color: Colors.orange,
    height: 20,
    width: 50,
    child: const Text(
      '3',
      style: textStyle,
    ),
  );
  final greenBox = Container(
    alignment: Alignment.center,
    color: Colors.green,
    height: 30,
    width: 30,
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
    return Wrap(
      children: WrapCrossAlignment.values
          .map((mode) => Column(
                children: [
                  Container(
                    margin: const EdgeInsets.all(5),
                    width: 160,
                    height: 80,
                    color: Colors.grey.withAlpha(33),
                    child: _buildItem(mode),
                  ),
                  Text(mode.toString().split('.')[1])
                ],
              ))
          .toList(),
    );
  }

  Widget _buildItem(WrapCrossAlignment mode) => Wrap(
        crossAxisAlignment: mode,
        children: [blueBox, redBox, yellowBox, greenBox, purpleBox],
      );
}
