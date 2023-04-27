import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:idraw_study/p15_bezier_wave/s06/toly_wave_loading.dart';

void main() {
  //确定初始化
  WidgetsFlutterBinding.ensureInitialized();
  //横屏
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);
  //全屏
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Wrap(
            spacing: 30,
            runSpacing: 30,
            children: List.generate(9, (index) => 0.1 * index + 0.1)
                .map((e) => TolyWaveLoading(
                      isOval: (e * 10).toInt().isEven,
                      progress: e,
                      waveHeight: 3,
                      color: [
                        Colors.blue,
                        Colors.red,
                        Colors.green
                      ][(e * 10).toInt() % 3],
                    ))
                .toList(),
          ),
        ),
      ),
    );
  }
}
