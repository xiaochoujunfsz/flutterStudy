import 'package:flutter/material.dart';
import 'package:wrapper/wrapper.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HomePage'),
      ),
      body: const Center(
        child: ChatItem(),
      ),
    );
  }
}

class ChatItem extends StatelessWidget {
  const ChatItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 55, top: 5, bottom: 5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildIcon(),
          Flexible(child: _buildContent()),
        ],
      ),
    );
  }

  _buildIcon() {
    return Container(
      width: 40,
      height: 40,
      margin: const EdgeInsets.only(right: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(3),
        image: const DecorationImage(
            image: AssetImage('assets/images/head_icon/icon_0.webp'),
            fit: BoxFit.cover),
      ),
    );
  }

  _buildContent() {
    return Padding(
      padding: const EdgeInsets.only(top: 3),
      child: Wrapper(
        elevation: .5,
        spineHeight: 6,
        shadowColor: Colors.grey.withOpacity(0.3),
        offset: 12,
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
        color: const Color(0xff96EC6D),
        child: const Text(
          '兄弟们，准备问老婆们要钱买布局小册吧！',
          style: TextStyle(color: Colors.black, fontSize: 15),
        ),
      ),
    );
  }
}
