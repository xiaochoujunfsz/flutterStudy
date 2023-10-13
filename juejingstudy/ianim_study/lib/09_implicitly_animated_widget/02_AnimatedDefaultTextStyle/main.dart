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
  final TextStyle startStyle = const TextStyle(
      color: Colors.white,
      fontSize: 50,
      shadows: [
        Shadow(offset: Offset(1, 1), color: Colors.black, blurRadius: 3)
      ]);
  final TextStyle endStyle = const TextStyle(
      color: Colors.white,
      fontSize: 20,
      shadows: [
        Shadow(offset: Offset(1, 1), color: Colors.purple, blurRadius: 3)
      ]);

  late TextStyle _style;

  bool get selected => _style == endStyle;

  @override
  void initState() {
    super.initState();
    _style = startStyle;
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
          width: 300,
          height: 100,
          alignment: Alignment.center,
          child: buildAnim(),
        )
      ],
    );
  }

  void onChanged(bool value) {
    setState(() {
      _style = value ? endStyle : startStyle;
    });
  }

  Widget buildAnim() => AnimatedDefaultTextStyle(
      textAlign: TextAlign.start,
      softWrap: true,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: _style,
      duration: const Duration(seconds: 1),
      curve: Curves.fastOutSlowIn,
      onEnd: onEnd,
      child: const Text('张风捷特烈'));

  void onEnd() {
    print('End');
  }
}
