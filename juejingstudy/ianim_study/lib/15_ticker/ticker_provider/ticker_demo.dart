import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class TickerDemo extends StatefulWidget {
  const TickerDemo({Key? key}) : super(key: key);

  @override
  State<TickerDemo> createState() => _TickerDemoState();
}

class _TickerDemoState extends State<TickerDemo>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrlA;

  final Duration animDuration = const Duration(milliseconds: 2000);

  @override
  void initState() {
    super.initState();
    _ctrlA =
        AnimationController(vsync: this, duration: animDuration, value: 0.4);
  }

  @override
  void dispose() {
    _ctrlA.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _start,
      child: Container(
        width: 60,
        height: 60,
        color: Colors.green,
      ),
    );
  }

  void _start() {}
}
