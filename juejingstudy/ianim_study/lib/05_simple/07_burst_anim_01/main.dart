import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'burst_menu.dart';

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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: 200,
          height: 200,
          alignment: Alignment.center,
          child: IconTheme(
            data: IconTheme.of(context).copyWith(color: Colors.white, size: 18),
            child: BurstMenu(
              center: _buildMenu(),
              menus: _buildMenuItems(),
              burstMenuItemClick: _burstMenuItemClick,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMenu() => Container(
        width: 36,
        height: 36,
        padding: const EdgeInsets.all(2),
        decoration: const BoxDecoration(
          color: Colors.blue,
          shape: BoxShape.circle,
        ),
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.blue,
            shape: BoxShape.circle,
            image: DecorationImage(
                image: AssetImage('assets/images/icon_head.jpg')),
          ),
        ),
      );

  List<Widget> _buildMenuItems() => [
        Colors.red,
        Colors.yellow,
        Colors.blue,
        Colors.green,
        Colors.purple,
        Colors.indigo,
      ]
          .map((Color color) => Container(
                width: 15.0 * 2,
                height: 15.0 * 2,
                decoration: BoxDecoration(
                    color: color,
                    borderRadius:
                        const BorderRadius.all(Radius.circular(15.0))),
              ))
          .toList();

  bool _burstMenuItemClick(int index) {
    print("index:$index");
    if (index == 0) {
      return false;
    }
    return true;
  }
}
