import 'package:flutter/material.dart';

void main() {
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
        home: const GreenPage());
  }
}

class GreenPage extends StatelessWidget {
  const GreenPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      appBar: AppBar(
        title: const Text('GreenPage'),
        actions: [
          IconButton(
            onPressed: () => _toRed(context),
            icon: const Icon(Icons.navigate_next),
          )
        ],
      ),
    );
  }

  _toRed(BuildContext context) {
    Navigator.of(context).push(PageRouteBuilder(
      pageBuilder: (BuildContext context, Animation<double> animation,
              Animation<double> secondaryAnimation) =>
          const RedPage(),
      transitionDuration: const Duration(milliseconds: 300),
      reverseTransitionDuration: const Duration(milliseconds: 300),
      transitionsBuilder: _buildTransitions,
    ));
  }

  Widget _buildTransitions(BuildContext context, Animation<double> animation,
          Animation<double> secondaryAnimation, Widget child) =>
      SlideTransition(
        position: Tween(begin: const Offset(1.0, 0), end: Offset.zero)
            .animate(animation),
        child: FadeTransition(
          opacity: Tween(begin: 0.5, end: 1.0).animate(animation),
          child: child,
        ),
      );
}

class RedPage extends StatelessWidget {
  const RedPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red,
      appBar: AppBar(
        title: const Text('RedPage'),
      ),
    );
  }
}
