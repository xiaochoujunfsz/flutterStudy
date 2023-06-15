import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'bg_manage.dart';
import 'bg_painter.dart';
import 'clock_painter.dart';
import 'clock_manage.dart';

class ClockPanel extends StatefulWidget {
  const ClockPanel({Key? key}) : super(key: key);

  @override
  State<ClockPanel> createState() => _ClockPanelState();
}

class _ClockPanelState extends State<ClockPanel>
    with SingleTickerProviderStateMixin {
  late Ticker _ticker;
  late ClockManage pm;
  late BgManage bgManage;

  @override
  void initState() {
    super.initState();
    pm = ClockManage(size: const Size(550, 200));
    bgManage = BgManage(size: const Size(550, 200));
    _ticker = createTicker(_tick)..start();
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: pm.size,
      painter: ClockPainter(manage: pm),
      foregroundPainter: BgPainter(manage: bgManage),
    );
  }

  @override
  void dispose() {
    _ticker.dispose();
    super.dispose();
  }

  void _tick(Duration duration) {
    DateTime now = DateTime.now();

    if (now.millisecondsSinceEpoch - pm.datetime.millisecondsSinceEpoch >
        1000) {
      pm
        ..datetime = now
        ..tick(now);
    }
    bgManage.tick(now);
  }
}
