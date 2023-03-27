import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:idraw_study/p02_paint/level4/01_colorFilter_mode/paper.dart';

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
