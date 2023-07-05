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
        ));
  }
}

class Demo extends StatelessWidget {
  Demo({Key? key}) : super(key: key);

  final alignments = [
    Alignment.topLeft,
    Alignment.topCenter,
    Alignment.topRight,
    Alignment.centerLeft,
    Alignment.center,
    Alignment.centerRight,
    Alignment.bottomLeft,
    Alignment.bottomCenter,
    Alignment.bottomRight,
  ];

  final alignmentsInfo = [
    "topLeft",
    "topCenter",
    "topRight",
    "centerLeft",
    "center",
    "centerRight",
    "bottomLeft",
    "bottomCenter",
    "bottomRight",
  ];

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: alignments
          .map((mode) => Column(
                children: [
                  Container(
                    margin: const EdgeInsets.all(5),
                    width: 100,
                    height: 60,
                    color: Colors.grey.withAlpha(88),
                    child: Align(
                      alignment: mode,
                      child: Container(
                        width: 30,
                        height: 30,
                        color: Colors.cyanAccent,
                      ),
                    ),
                  ),
                  Text(alignmentsInfo[alignments.indexOf(mode)])
                ],
              ))
          .toList(),
    );
  }
}
