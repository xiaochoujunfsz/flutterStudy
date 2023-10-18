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
  var _crossFadeState = CrossFadeState.showFirst;

  bool get isFirst => _crossFadeState == CrossFadeState.showFirst;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      direction: Axis.vertical,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        Switch(value: isFirst, onChanged: onChanged),
        AnimatedCrossFade(
          //第一组件透明度动画
          firstChild: buildFirstChild(),
          //第二组件透明度动画
          secondChild: buildSecondChild(),
          //第一组件和第二组件间尺寸变换动画
          crossFadeState: _crossFadeState,
          duration: const Duration(milliseconds: 1000),
          firstCurve: Curves.easeInCirc,
          secondCurve: Curves.easeInToLinear,
          sizeCurve: Curves.bounceOut,
        ),
      ],
    );
  }

  Widget buildFirstChild() => Container(
        height: 60,
        width: 60,
        color: Colors.grey.withAlpha(22),
        alignment: Alignment.center,
        child: const FlutterLogo(
          size: 40,
        ),
      );

  Widget buildSecondChild() => Image.asset(
        "assets/images/icon_head.jpg",
        height: 100,
        width: 100,
      );

  void onChanged(bool value) {
    setState(() {
      _crossFadeState =
          value ? CrossFadeState.showFirst : CrossFadeState.showSecond;
    });
  }
}
