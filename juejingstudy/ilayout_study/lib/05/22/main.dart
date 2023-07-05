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
        home: const Scaffold(
          body: Center(
            child: Demo(),
          ),
        ));
  }
}

class Demo extends StatelessWidget {
  const Demo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
        spacing: 80,
        runSpacing: 80,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: BoxFit.values
            .map((mode) => Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 140,
                      height: 50,
                      color: Colors.grey.withAlpha(88),
                      child: FittedBox(
                        fit: mode,
                        child: Container(
                          width: 30,
                          height: 30,
                          color: Colors.cyanAccent,
                          child: Text(mode.toString().split('.')[0]),
                        ),
                      ),
                    ),
                    Text('$mode')
                  ],
                ))
            .toList());
  }
}
