import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:idraw_study/p03_canvas/10_path/paper.dart';

void main() {
  //确定初始化
  WidgetsFlutterBinding.ensureInitialized();
  //横屏
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);
  //全屏
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);

  runApp(const Paper());
}
