import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'handle_widget.dart';

void main() {
  //确定初始化
  WidgetsFlutterBinding.ensureInitialized();
  //横屏
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);
  //全屏
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);

  runApp(HomePage());
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double _rotate = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Transform.rotate(
              angle: _rotate,
              child: Container(color: Colors.blue, width: 100, height: 100),
            ),
            HandleWidget(onMove: _onMove),
          ],
        ),
      ),
    );
  }

  void _onMove(double rotate, double distance) {
    setState(() {
      _rotate = rotate;
    });
  }
}
