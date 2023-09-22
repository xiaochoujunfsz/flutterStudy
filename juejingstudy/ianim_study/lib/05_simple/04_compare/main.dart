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
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ValueNotifier<double> angle = ValueNotifier(90);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: 300,
          child: ValueListenableBuilder(
            valueListenable: angle,
            builder: (_, value, __) => Wrap(
              alignment: WrapAlignment.center,
              children: [
                Slider(
                    value: value,
                    min: 0,
                    max: 360,
                    onChanged: (v) {
                      angle.value = v;
                    }),
                ToggleRotate(
                  beginAngle: 0,
                  endAngle: value,
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
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
