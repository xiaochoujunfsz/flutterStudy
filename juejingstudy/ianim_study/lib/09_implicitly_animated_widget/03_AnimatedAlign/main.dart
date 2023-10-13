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
  final Alignment startAlignment = Alignment.center;
  final Alignment endAlignment = Alignment.bottomRight;

  late Alignment _alignment;

  bool get selected => _alignment == endAlignment;

  @override
  void initState() {
    super.initState();
    _alignment = startAlignment;
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
          width: 200,
          height: 100,
          alignment: Alignment.center,
          child: buildAnim(),
        )
      ],
    );
  }

  void onChanged(bool value) {
    setState(() {
      _alignment = value ? endAlignment : startAlignment;
    });
  }

  Widget buildAnim() => AnimatedAlign(
        alignment: _alignment,
        duration: const Duration(seconds: 1),
        curve: Curves.fastOutSlowIn,
        onEnd: onEnd,
        child: const Icon(
          Icons.accessible_forward_sharp,
          color: Colors.green,
          size: 25,
        ),
      );

  void onEnd() {
    print('End');
  }
}
