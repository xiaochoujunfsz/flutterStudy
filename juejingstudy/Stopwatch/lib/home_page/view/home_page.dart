import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stopwatch/home_page/bloc/bloc.dart';
import 'package:stopwatch/home_page/view/button_tools.dart';
import 'package:stopwatch/home_page/view/record_panel.dart';
import 'package:stopwatch/setting_page/setting_page.dart';

import 'stopwatch_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  StopWatchBloc get stopWatchBloc => BlocProvider.of<StopWatchBloc>(context);

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

  void _onSelectItem(String value) {
    if (value == "设置") {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (_) => const SettingPage()));
    }
  }

  //秒表表盘
  Widget buildStopwatchPanel() {
    double radius = MediaQuery.of(context).size.shortestSide / 2 * 0.75;
    return BlocBuilder<StopWatchBloc, StopWatchState>(
        buildWhen: (p, n) => p.duration != n.duration,
        builder: (_, state) => StopWatchWidget(
              radius: radius,
              duration: state.duration,
              themeColor: Theme.of(context).primaryColor,
            ));
  }

  //记录面板
  Widget buildRecordPanel() {
    return Expanded(
        child: BlocBuilder<StopWatchBloc, StopWatchState>(
      buildWhen: (p, n) => p.durationRecord != n.durationRecord,
      builder: (_, state) => RecordPanel(
        record: state.durationRecord,
      ),
    ));
  }

  //工具按钮
  Widget buildTools() {
    return BlocBuilder<StopWatchBloc, StopWatchState>(
      buildWhen: (p, n) => p.type != n.type,
      builder: (_, state) => ButtonTools(
        state: state.type,
        onRecoder: onRecoder,
        onReset: onReset,
        toggle: toggle,
      ),
    );
  }

  void onReset() => stopWatchBloc.add(const ResetStopWatch());

  void onRecoder() => stopWatchBloc.add(const RecordeStopWatch());

  void toggle() => stopWatchBloc.add(const ToggleStopWatch());
}
