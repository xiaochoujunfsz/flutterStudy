import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_app/CarView.dart';
import 'package:flutter_app/RadioSlider.dart';
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
            GradientButton(
              child: Text("自定义carview"),
              colors: [Colors.orange, Colors.red],
              height: 50,
              onPressed: () {
                Navigator.pushNamed(context, "car_view_page");
              },
            ),
            Row(children: [
              Text("left"),
              Expanded(
                  child:
                      // RadioSlider(
                      //   width: 200,
                      //   height: 10,
                      //   min: 0,
                      //   max: 10,
                      //   progress: 5,
                      // ),
                      SliderTest()),
              Text("right")
            ])
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
    _readCounter().then((value) {
      setState(() {
        _counter = value;
      });
    });
  }

  Future<File> _getLocalFile() async {
    // 获取应用目录
    String dir = (await getApplicationDocumentsDirectory()).path;
    return new File("$dir/counter.txt");
  }

  Future<int> _readCounter() async {
    try {
      File file = await _getLocalFile();
      // 读取点击次数（以字符串）
      String contents = await file.readAsString();
      return int.parse(contents);
    } on FileSystemException {
      return 0;
    }
  }

  Future<Null> _incrementCounter() async {
    setState(() {
      _counter++;
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
  bool _loading = false;
  String _text = "";

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints.expand(),
      child: SingleChildScrollView(
        child: Column(
          children: [
            ElevatedButton(
                onPressed: _loading
                    ? null
                    : () async {
                        setState(() {
                          _loading = true;
                          _text = "正在请求...";
                        });
                        try {
                          //创建一个HttpClient
                          HttpClient httpClient = new HttpClient();
                          //打开Http连接
                          HttpClientRequest request = await httpClient
                              .getUrl(Uri.parse("https://www.baidu.com"));
                          //使用iPhone的UA
                          request.headers.add("user-agent",
                              "Mozilla/5.0 (iPhone; CPU iPhone OS 10_3_1 like Mac OS X) AppleWebKit/603.1.30 (KHTML, like Gecko) Version/10.0 Mobile/14E304 Safari/602.1");
                          //等待连接服务器（会将请求信息发送给服务器）
                          HttpClientResponse response = await request.close();
                          //读取响应内容
                          _text = await response.transform(utf8.decoder).join();
                          //输出响应头
                          print(response.headers);

                          //关闭client后，通过该client发起的所有请求都会中止。
                          httpClient.close();
                        } catch (e) {
                          _text = "请求失败：$e";
                        } finally {
                          setState(() {
                            _loading = false;
                          });
                        }
                      },
                child: Text("获取百度首页")),
            Container(
                width: MediaQuery.of(context).size.width - 50.0,
                child: Text(_text.replaceAll(new RegExp(r"\s"), "")))
          ],
        ),
      ),
    );
  }
}

//失败
class CarPage extends StatelessWidget {
  const CarPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      appBar: AppBar(
        title: Text("自定义喇叭"),
      ),
      body:CarView(),
    );
  }
}
