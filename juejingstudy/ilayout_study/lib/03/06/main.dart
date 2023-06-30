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
        child: LoopLayout(
          center: LoopLayout(
            center: LoopLayout(
              center: LoopLayout(
                center: LoopLayout(
                  center: LoopLayout(
                    center: LoopLayout(
                      center: LoopLayout(),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class LoopLayout extends StatelessWidget {
  final Widget? center;

  const LoopLayout({Key? key, this.center}) : super(key: key);

  Widget get decoratedBox {
    return DecoratedBox(
      decoration:
          BoxDecoration(border: Border.all(color: Colors.black, width: 1)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          flex: 1,
          child: ColoredBox(
            color: Colors.red,
            child: decoratedBox,
          ),
        ),
        Expanded(
          flex: 4,
          child: _buildCenter(),
        ),
        Expanded(
          flex: 1,
          child: ColoredBox(
            color: Colors.blue,
            child: decoratedBox,
          ),
        ),
      ],
    );
  }

  Widget _buildCenter() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
            flex: 1,
            child: ColoredBox(
              color: Colors.orange,
              child: decoratedBox,
            )),
        Expanded(
            flex: 4,
            child: center != null
                ? center!
                : ColoredBox(
                    color: Colors.cyanAccent,
                    child: decoratedBox,
                  )),
        Expanded(
            flex: 1,
            child: ColoredBox(
              color: Colors.green,
              child: decoratedBox,
            )),
      ],
    );
  }
}
