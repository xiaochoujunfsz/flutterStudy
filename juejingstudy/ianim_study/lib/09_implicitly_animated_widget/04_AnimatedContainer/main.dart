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
  final Decoration startDecoration = const BoxDecoration(
      color: Colors.deepPurple,
      borderRadius: BorderRadius.all(Radius.circular(30)),
      boxShadow: [
        BoxShadow(
            offset: Offset(1, 1),
            color: Colors.purple,
            blurRadius: 5,
            spreadRadius: 2)
      ]);

  final Decoration endDecoration = const BoxDecoration(
      color: Colors.blue,
      borderRadius: BorderRadius.all(Radius.circular(10)),
      boxShadow: [
        BoxShadow(
            offset: Offset(1, 1),
            color: Colors.blue,
            blurRadius: 10,
            spreadRadius: 0)
      ]);

  final Alignment startAlignment = Alignment.topLeft + Alignment(0.2, 0.2);
  final Alignment endAlignment = Alignment.center;

  final double startHeight = 150.0;
  final double endHeight = 100.0;

  late Decoration _decoration;
  late double _height;
  late Alignment _alignment;

  bool get selected => _height == endHeight;

  @override
  void initState() {
    super.initState();
    _decoration = startDecoration;
    _height = startHeight;
    _alignment = startAlignment;
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      direction: Axis.vertical,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        Switch(value: selected, onChanged: onChanged),
        buildAnim(),
      ],
    );
  }

  void onChanged(bool value) {
    setState(() {
      _decoration = value ? endDecoration : startDecoration;
      _height = value ? endHeight : startHeight;
      _alignment = value ? endAlignment : startAlignment;
    });
  }

  Widget buildAnim() => AnimatedContainer(
        decoration: _decoration,
        width: _height,
        height: _height,
        alignment: _alignment,
        duration: const Duration(seconds: 1),
        curve: Curves.fastOutSlowIn,
        onEnd: onEnd,
        child: _buildChild(),
      );

  Widget _buildChild() => const Icon(
        Icons.camera_outlined,
        size: 30,
        color: Colors.white,
      );

  void onEnd() {
    print('End');
  }
}
