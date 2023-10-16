import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
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
          child: AnimDemo(),
        )));
  }
}

class AnimDemo extends StatefulWidget {
  const AnimDemo({Key? key}) : super(key: key);

  @override
  State<AnimDemo> createState() => _AnimDemoState();
}

class _AnimDemoState extends State<AnimDemo> {
  final EdgeInsets beginPadding = const EdgeInsets.all(10);
  final EdgeInsets endPadding = const EdgeInsets.all(30);

  late EdgeInsets _padding;

  bool get selected => _padding == endPadding;

  @override
  void initState() {
    super.initState();
    _padding = beginPadding;
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      direction: Axis.vertical,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        Switch(value: selected, onChanged: onChanged),
        Container(
          color: Colors.grey.withAlpha(22),
          alignment: Alignment.topLeft,
          width: 100,
          height: 100,
          child: buildAnimatedOpacity(),
        )
      ],
    );
  }

  void onChanged(bool value) {
    setState(() {
      _padding = value ? endPadding : beginPadding;
    });
  }

  Widget buildAnimatedOpacity() => AnimatedPadding(
        padding: _padding,
        duration: const Duration(seconds: 1),
        curve: Curves.fastOutSlowIn,
        onEnd: onEnd,
        child: _buildChild(),
      );

  void onEnd() {
    print('End');
  }

  Widget _buildChild() => const Icon(
        Icons.camera_outlined,
        color: Colors.green,
        size: 60,
      );
}
