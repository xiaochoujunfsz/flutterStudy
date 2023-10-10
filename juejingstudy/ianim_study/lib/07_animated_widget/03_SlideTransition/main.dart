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

class _AnimDemoState extends State<AnimDemo>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<Offset> animation;

  @override
  void initState() {
    super.initState();
    _ctrl =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));
    animation =
        Tween(begin: Offset.zero, end: const Offset(0.5, 0.5)).animate(_ctrl);
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _ctrl.forward(from: 0),
      child: Container(
        color: Colors.grey.withAlpha(33),
        width: 200,
        height: 100,
        child: _buildContent(),
      ),
    );
  }

  // 构建主体内容
  Widget _buildContent() => Stack(
        fit: StackFit.expand,
        children: [
          SlideTransition(
            position: animation,
            textDirection: TextDirection.ltr,
            child: _buildChild(),
          ),
          SlideTransition(
            position: animation,
            textDirection: TextDirection.rtl,
            child: _buildChild(),
          )
        ],
      );

  Widget _buildChild() => const Icon(
        Icons.accessible_forward_sharp,
        color: Colors.green,
        size: 25,
      );
}
