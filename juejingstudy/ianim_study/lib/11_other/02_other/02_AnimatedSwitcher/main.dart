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
  int _count = 0;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        _buildBtn(Icons.remove, Colors.red, _doMinus),
        SizedBox(
          width: 80,
          child: _buildAnimatedSwitcher(context),
        ),
        _buildBtn(Icons.add, Colors.blue, _doAdd),
      ],
    );
  }

  Widget _buildBtn(IconData icon, Color color, VoidCallback onPressed) =>
      MaterialButton(
          padding: EdgeInsets.zero,
          textColor: const Color(0xffFfffff),
          elevation: 3,
          color: color,
          highlightColor: const Color(0xffF88B0A),
          splashColor: Colors.red,
          shape: const CircleBorder(
            side: BorderSide(width: 2.0, color: Color(0xFFDFDFDF)),
          ),
          onPressed: onPressed,
          child: Icon(
            icon,
            color: Colors.white,
          ));

  void _doMinus() {
    setState(() => _count -= 1);
  }

  void _doAdd() {
    setState(() => _count += 1);
  }

  Widget _buildAnimatedSwitcher(BuildContext context) => AnimatedSwitcher(
        duration: const Duration(milliseconds: 2000),
        transitionBuilder: (Widget child, Animation<double> animation) =>
            ScaleTransition(
          scale: animation,
          child: RotationTransition(
            turns: animation,
            child: child,
          ),
        ),
        child: Text(
          '$_count',
          key: ValueKey(_count),
          style: Theme.of(context).textTheme.displaySmall,
        ),
      );
}
