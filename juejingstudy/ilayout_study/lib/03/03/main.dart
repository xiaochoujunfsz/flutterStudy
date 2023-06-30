import 'package:flutter/material.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Material(
        child: LoopLayout(),
      ),
    );
  }
}

class LoopLayout extends StatelessWidget {
  const LoopLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: const [
        Expanded(
          flex: 1,
          child: ColoredBox(color: Colors.red),
        ),
        Expanded(
          flex: 2,
          child: ColoredBox(color: Colors.cyanAccent),
        ),
        Spacer(
          flex: 1,
        ),
        Flexible(
            flex: 3, fit: FlexFit.tight, child: ColoredBox(color: Colors.blue)),
      ],
    );
  }
}
