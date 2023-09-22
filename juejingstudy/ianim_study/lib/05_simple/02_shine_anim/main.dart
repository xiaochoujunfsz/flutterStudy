import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'circle_shine_image.dart';

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
            children: const [
              CircleShineImage(
                image: AssetImage('assets/images/wy_300x200.jpg'),
                color: Colors.red,
                maxBlurRadius: 6,
                duration: Duration(seconds: 1),
                curve: Curves.easeIn,
              ),
              CircleShineImage(
                image: AssetImage('assets/images/icon_head.png'),
                color: Colors.purple,
                maxBlurRadius: 8,
                curve: Curves.ease,
              ),
              CircleShineImage(
                image: AssetImage('assets/images/icon_8.jpg'),
                color: Colors.blue,
                maxBlurRadius: 4,
                curve: Curves.decelerate,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
