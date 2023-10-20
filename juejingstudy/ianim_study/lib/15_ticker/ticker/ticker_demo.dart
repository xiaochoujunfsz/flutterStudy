import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class TickerDemo extends StatefulWidget {
  const TickerDemo({Key? key}) : super(key: key);

  @override
  State<TickerDemo> createState() => _TickerDemoState();
}

class _TickerDemoState extends State<TickerDemo> {
  late Ticker _ticker;

  @override
  void initState() {
    super.initState();
    _ticker = Ticker(_tick);
  }

  @override
  void dispose() {
    _ticker.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _startTicker,
      child: Container(
        width: 60,
        height: 60,
        color: Colors.green,
      ),
    );
  }

  void _tick(Duration elapsed) {
    print('----elapsed:$elapsed---------------');
  }

  void _startTicker() {
    if (_ticker.isTicking) {
      _ticker.stop();
    } else {
      _ticker.start().then((value) => print('start finish'));
    }
  }
}
