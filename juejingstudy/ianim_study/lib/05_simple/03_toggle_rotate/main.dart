import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'toggle_rotate.dart';

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
      home: Scaffold(
        body: Center(
          child: Wrap(
            spacing: 50,
            children: [
              ToggleRotate(
                beginAngle: 0,
                endAngle: 45,
                curve: Curves.decelerate,
                durationMs: 400,
                clockwise: true,
                child: const Icon(
                  Icons.forward,
                  size: 60,
                  color: Colors.orangeAccent,
                ),
                onEnd: (v) {
                  print("---expanded---:$v-------");
                },
              ),
              ToggleRotate(
                beginAngle: -30,
                endAngle: 45,
                curve: Curves.ease,
                child: const Image(
                    width: 60,
                    height: 60,
                    image: AssetImage("assets/images/icon_head.jpg")),
                onEnd: (v) {
                  print("---expanded---:$v-------");
                },
                onTap: () {
                  print("---tap----------");
                },
              ),
              ToggleRotate(
                beginAngle: 180,
                endAngle: 180 + 45.0,
                curve: Curves.decelerate,
                durationMs: 400,
                clockwise: false,
                child: const Icon(
                  Icons.forward,
                  size: 60,
                  color: Colors.orangeAccent,
                ),
                onEnd: (v) {
                  print("---expanded---:$v-------");
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
