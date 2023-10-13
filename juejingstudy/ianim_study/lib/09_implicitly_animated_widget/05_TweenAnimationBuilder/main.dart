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
  Color color1 = Colors.red;
  Color color2 = Colors.orange;

  bool _selected = false;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      direction: Axis.vertical,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        Switch(value: _selected, onChanged: onChanged),
        buildAnim(),
      ],
    );
  }

  void onChanged(bool value) {
    setState(() {
      _selected = !_selected;
    });
  }

  Widget buildAnim() => TweenAnimationBuilder(
        tween: ColorTween(begin: Colors.blue, end: _selected ? color1 : color2),
        duration: const Duration(seconds: 1),
        builder: (_, Color? color, Widget? child) => Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(8),
          ),
          child: child,
        ),
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
