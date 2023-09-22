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
      body: Stack(
        children: [
          Positioned(
            right: 20,
            top: 20,
            child: BurstMenu.topRight(
              curve: Curves.bounceOut,
              radius: 60,
              center: _buildMenu(),
              burstMenuItemClick: _burstMenuItemClick,
              menus: _buildMenuItems(),
            ),
          ),
          Positioned(
            left: 20,
            top: 20,
            child: BurstMenu.topLeft(
              curve: Curves.linearToEaseOut,
              radius: 60,
              center: _buildMenu(),
              burstMenuItemClick: _burstMenuItemClick,
              menus: _buildMenuItems(),
            ),
          ),
          Positioned(
            right: 20,
            bottom: 20,
            child: BurstMenu.bottomRight(
              curve: Curves.decelerate,
              radius: 60,
              center: _buildMenu(),
              burstMenuItemClick: _burstMenuItemClick,
              menus: _buildMenuItems(),
            ),
          ),
          Positioned(
            left: 20,
            bottom: 20,
            child: BurstMenu.bottomLeft(
              curve: Curves.easeOutQuart,
              radius: 60,
              center: _buildMenu(),
              burstMenuItemClick: _burstMenuItemClick,
              menus: _buildMenuItems(),
            ),
          ),
          Positioned(
            left: MediaQuery.of(context).size.width / 2 - 120,
            bottom: 80,
            child: BurstMenu(
              radius: 120,
              burstType: BurstType.halfCircle,
              startAngle: -150,
              swapAngle: 90.0 + 30,
              center: _buildMenu(),
              burstMenuItemClick: _burstMenuItemClick,
              menus: _buildMenuItems(),
            ),
          ),
        ],
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

  final List<Color> colors = [
    Colors.red,
    Colors.yellow,
    Colors.blue,
    Colors.green,
  ];

  List<Widget> _buildMenuItems() => colors
      .asMap()
      .keys
      .map((int index) => Container(
            alignment: Alignment.center,
            width: 15.0 * 2,
            height: 15.0 * 2,
            decoration: BoxDecoration(
                color: colors[index],
                borderRadius: const BorderRadius.all(Radius.circular(15.0))),
            child: Text(
              '$index',
              style: const TextStyle(color: Colors.white),
            ),
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
