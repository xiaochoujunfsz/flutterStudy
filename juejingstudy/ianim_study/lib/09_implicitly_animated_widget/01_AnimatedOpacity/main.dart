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
  final double beginOpacity = 1.0; // 开始透明度
  final double endOpacity = 0; // 结束透明度

  late double _opacity; // 当前透明度

  bool get selected => _opacity == 0;

  @override
  void initState() {
    super.initState();
    _opacity = beginOpacity;
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
          width: 100,
          height: 100,
          child: buildAnimatedOpacity(),
        )
      ],
    );
  }

  void onChanged(bool value) {
    setState(() {
      _opacity = value ? endOpacity : beginOpacity;
    });
  }

  Widget buildAnimatedOpacity() => AnimatedOpacity(
        opacity: _opacity,
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
