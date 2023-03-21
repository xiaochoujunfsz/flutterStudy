import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:stopwatch/home_page/view/button_tools.dart';

import 'stopwatch_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Ticker _ticker;

  //当前时间
  Duration _duration = Duration.zero;

  @override
  void initState() {
    super.initState();
    _ticker = Ticker(_onTick);
  }

  //时间差
  Duration dt = Duration.zero;

  //上一次的时间，暂停会重置
  Duration lastDuration = Duration.zero;

  void _onTick(Duration elapsed) {
    setState(() {
      dt = elapsed - lastDuration;
      _duration += dt;
      lastDuration = elapsed;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        //设置为0，移除阴影
        elevation: 0,
        //右侧显示组件
        actions: buildActions(),
      ),
      body: Column(
        children: [
          buildStopwatchPanel(),
          buildRecordPanel(),
          buildTools(),
        ],
      ),
    );
  }

  List<Widget> buildActions() {
    return [
      PopupMenuButton(
        itemBuilder: _buildItem,
        onSelected: _onSelectItem,
        icon: const Icon(Icons.more_vert_outlined, color: Color(0xff262626)),
        position: PopupMenuPosition.under,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10))),
      )
    ];
  }

  List<PopupMenuEntry<String>> _buildItem(BuildContext context) {
    return const [
      PopupMenuItem(
        value: "设置",
        child: Center(
          child: Text("设置"),
        ),
      )
    ];
  }

  void _onSelectItem(String value) {}

  //秒表表盘
  Widget buildStopwatchPanel() {
    double radius = MediaQuery.of(context).size.width / 2 * 0.75;
    return StopWatchWidget(
      radius: radius,
      duration: _duration,
    );
  }

  //记录面板
  Widget buildRecordPanel() {
    return Expanded(
        child: Container(
      color: Colors.red,
    ));
  }

  StopWatchType _type = StopWatchType.none;

  //工具按钮
  Widget buildTools() {
    return ButtonTools(
      state: _type,
      onRecoder: onRecoder,
      onReset: onReset,
      toggle: toggle,
    );
  }

  void onReset() {
    setState(() {
      _duration = Duration.zero;
      _type = StopWatchType.none;
    });
  }

  void onRecoder() {}

  void toggle() {
    bool running = _type == StopWatchType.running;
    if (running) {
      _ticker.stop();
      lastDuration = Duration.zero;
    } else {
      _ticker.start();
    }
    setState(() {
      _type = running ? StopWatchType.stopped : StopWatchType.running;
    });
  }

  @override
  void dispose() {
    _ticker.dispose();
    super.dispose();
  }
}
