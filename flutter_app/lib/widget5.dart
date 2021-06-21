import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_app/widget4.dart';
import 'package:path_provider/path_provider.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("自定义组件"),
      ),
      body: Center(
        child: Column(
          children: [
            GradientButton(
              child: Text("文件操作"),
              colors: [Colors.orange, Colors.red],
              height: 50,
              onPressed: () {
                Navigator.pushNamed(context, "file_operation");
              },
            ),
          ],
        ),
      ),
    );
  }
}

class FileOperationRoute extends StatefulWidget {
  const FileOperationRoute({Key key}) : super(key: key);

  @override
  _FileOperationRouteState createState() => _FileOperationRouteState();
}

class _FileOperationRouteState extends State<FileOperationRoute> {
  int _counter;

  @override
  void initState() {
    super.initState();
    //从文件读取点击次数
    _readCounter().then((value){
      setState(() {
        _counter = value;
      });
    });
  }

  Future<File> _getLocalFile() async{
    // 获取应用目录
    String dir = (await getApplicationDocumentsDirectory()).path;
    return new File("$dir/counter.txt");
  }

  Future<int> _readCounter() async {
    try{
      File file = await _getLocalFile();
      // 读取点击次数（以字符串）
      String contents = await file.readAsString();
      return int.parse(contents);
    } on FileSystemException{
      return 0;
    }
  }

  Future<Null> _incrementCounter() async {
    setState(() {
      _counter ++;
    });
    // 将点击次数以字符串类型写到文件中
    await (await _getLocalFile()).writeAsString('$_counter');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(title: new Text('文件操作')),
      body: new Center(
        child: new Text('点击了 $_counter 次'),
      ),
      floatingActionButton: new FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: new Icon(Icons.add),
      ),
    );
  }
}

class HttpTestRoute extends StatefulWidget {
  const HttpTestRoute({Key key}) : super(key: key);

  @override
  _HttpTestRouteState createState() => _HttpTestRouteState();
}

class _HttpTestRouteState extends State<HttpTestRoute> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
