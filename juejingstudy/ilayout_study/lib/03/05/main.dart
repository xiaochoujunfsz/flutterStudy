import 'package:flutter/material.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Material(
        child: LoopLayout(),
      ),
    );
  }
}

class LoopLayout extends StatelessWidget {
  const LoopLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          flex: 1,
          child: _buildLeft(),
        ),
        Expanded(
          flex: 4,
          child: _buildCenter(),
        ),
        Expanded(
          flex: 1,
          child: _buildRight(),
        ),
      ],
    );
  }

  Widget _buildLeft() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: const [
        Icon(Icons.drive_file_rename_outline, color: Colors.blue),
        Icon(Icons.spellcheck),
        Icon(Icons.format_size),
        Icon(Icons.addchart),
        Icon(Icons.delete_sweep),
        Icon(Icons.skip_next),
      ],
    );
  }

  Widget _buildCenter() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(flex: 1, child: _buildTop()),
        Expanded(flex: 4, child: _buildCenterPanel()),
        Expanded(flex: 1, child: _buildFoot()),
      ],
    );
  }

  Widget _buildRight() {
    return Align(
      alignment: Alignment.topCenter,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
            child: Container(
              width: 34,
              height: 34,
              padding: const EdgeInsets.all(2),
              decoration: const BoxDecoration(
                  color: Colors.blue,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(blurRadius: 3, color: Colors.blue),
                  ]),
              child: const Image(
                image: AssetImage('assets/images/icon_head.webp'),
              ),
            ),
          ),
          const Text('捷特诗集',
              style: TextStyle(
                  color: Colors.blue,
                  fontSize: 12,
                  fontWeight: FontWeight.bold)),
          const Spacer(),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 18.0),
            child: Icon(
              Icons.contact_support,
              color: Colors.red,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTop() {
    return const Center(
        child: Text(
      '应龙',
      style: TextStyle(
        color: Colors.indigo,
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    ));
  }

  Widget _buildCenterPanel() {
    return const DecoratedBox(
      decoration: BoxDecoration(
          color: Colors.white,
          image: DecorationImage(
              opacity: 0.5,
              image: AssetImage('assets/images/dragon.webp'),
              fit: BoxFit.fitHeight)),
      child: Center(
        child: Text(
          """
一游小池两岁月，
洗却凡世几闲尘。
时逢雷霆风会雨，
应乘扶摇化入云。
        """,
          style: TextStyle(
            fontSize: 16,
            shadows: [
              Shadow(color: Colors.grey, blurRadius: 1, offset: Offset(0, 1))
            ],
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildFoot() {
    TextStyle style = const TextStyle(fontSize: 12, color: Colors.black);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          '张风捷特烈',
          style: style,
        ),
        Text('2018年02月02日', style: style)
      ],
    );
  }
}
