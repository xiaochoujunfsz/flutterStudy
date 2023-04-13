import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:idraw_study/p07_color/s04_BlendMode_detail/paper.dart';

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
