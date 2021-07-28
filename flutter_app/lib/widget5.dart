import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/CarView.dart';
import 'package:flutter_app/RadioSlider.dart';
import 'package:flutter_app/model.dart';
import 'package:flutter_app/widget4.dart';
import 'package:path_provider/path_provider.dart';
import 'package:web_socket_channel/io.dart';

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
            GradientButton(
              child: Text("dio基础"),
              colors: [Colors.orange, Colors.red],
              height: 50,
              onPressed: () {
                Navigator.pushNamed(context, "dio_page");
              },
            ),
            GradientButton(
              child: Text("web socket测试"),
              colors: [Colors.orange, Colors.red],
              height: 50,
              onPressed: () {
                Navigator.pushNamed(context, "web_socket_page");
              },
            ),
            GradientButton(
              child: Text("json测试"),
              colors: [Colors.orange, Colors.red],
              height: 50,
              onPressed: () {
                Navigator.pushNamed(context, "json_test_page");
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
      body: CarView(),
    );
  }
}

//dio基础使用
class DioPage extends StatefulWidget {
  const DioPage({Key key}) : super(key: key);

  @override
  _DioPageState createState() => _DioPageState();
}

class _DioPageState extends State<DioPage> {
  Dio _dio = new Dio();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("dio基础使用"),
      ),
      body: Container(
        alignment: Alignment.center,
        child: FutureBuilder(
          future: _dio.get("https://api.github.com/orgs/flutterchina/repos"),
          builder: (context, snapshot) {
            //请求完成
            if (snapshot.connectionState == ConnectionState.done) {
              Response response = snapshot.data;
              //发生错误
              if (snapshot.hasError) {
                return Text(snapshot.error.toString());
              }
              //请求成功，通过项目信息构建用于显示项目名称的ListView
              return ListView(
                children: response.data
                    .map<Widget>((e) => ListTile(
                          title: Text(e["full_name"]),
                        ))
                    .toList,
              );
            }
            //请求未完成时弹出loading
            return CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}

Future downloadWithChunks(url, savePath,
    {ProgressCallback onReceiveProgress}) async {
  const firstChunkSize = 102;
  const maxChunk = 3;

  int total = 0;
  var dio = Dio();
  var progress = <int>[];

  createCallback(no) {
    return (int received, _) {
      progress[no] = received;
      if (onReceiveProgress != null && total != 0) {
        onReceiveProgress(
            progress.reduce((value, element) => value + element), total);
      }
    };
  }

  Future<Response> downloadChunk(url, start, end, no) async {
    progress.add(0);
    --end;
    return dio.download(url, savePath + "temp$no",
        onReceiveProgress: createCallback(no),
        options: Options(headers: {"range": "bytes=$start-$end"}));
  }

  Future mergeTempFiles(chunk) async {
    File f = File(savePath + "temp0");
    IOSink ioSink = f.openWrite(mode: FileMode.writeOnlyAppend);
    for (int i = 1; i < chunk; ++i) {
      File _f = File(savePath + "temp$i");
      await ioSink.addStream(_f.openRead());
      await _f.delete();
    }
    await ioSink.close();
    await f.rename(savePath);
  }

  Response response = await downloadChunk(url, 0, firstChunkSize, 0);
  if (response.statusCode == 206) {
    total = int.parse(
        response.headers.value(HttpHeaders.contentRangeHeader).split("/").last);
    int reserved = total -
        int.parse(response.headers.value(HttpHeaders.contentLengthHeader));
    int chunk = (reserved / firstChunkSize).ceil() + 1;
    if (chunk > 1) {
      int chunkSize = firstChunkSize;
      if (chunk > maxChunk + 1) {
        chunk = maxChunk + 1;
        chunkSize = (reserved / maxChunk).ceil();
      }
      var futures = <Future>[];
      for (int i = 0; i < maxChunk; ++i) {
        int start = firstChunkSize + i * chunkSize;
        futures.add(downloadChunk(url, start, start + chunkSize, i + 1));
      }
      await Future.wait(futures);
    }
    await mergeTempFiles(chunk);
  }
}

class WebSocketRoute extends StatefulWidget {
  const WebSocketRoute({Key key}) : super(key: key);

  @override
  _WebSocketRouteState createState() => _WebSocketRouteState();
}

class _WebSocketRouteState extends State<WebSocketRoute> {
  TextEditingController _controller = TextEditingController();
  IOWebSocketChannel channel;
  String _text = "";

  @override
  void initState() {
    super.initState();
    //创建websocket连接
    channel = IOWebSocketChannel.connect('wss://echo.websocket.org');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("WebSocket(内容回显)"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Form(
                child: TextFormField(
              controller: _controller,
              decoration: InputDecoration(labelText: "Send a message"),
            )),
            StreamBuilder(
              builder: (context, snapshot) {
                //网络不通会走到这
                if (snapshot.hasError) {
                  _text = "网络不通...";
                } else if (snapshot.hasData) {
                  _text = "echo: ${snapshot.data}";
                }
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 24),
                  child: Text(_text),
                );
              },
              stream: channel.stream,
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _sendMessage,
        tooltip: 'Send message',
        child: Icon(Icons.send),
      ),
    );
  }

  void _sendMessage() {
    if (_controller.text.isNotEmpty) {
      channel.sink.add(_controller.text);
    }
  }

  @override
  void dispose() {
    channel.sink.close();
    super.dispose();
  }
}

class JsonTestRoute extends StatelessWidget {
  const JsonTestRoute({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("json测试"),
      ),
      body: Column(
        children: [
          ElevatedButton(
              onPressed: () {
                String jsonStr =
                    '{"name":"John Smith","email": "john@example.com"}';
                Map userMap = json.decode(jsonStr);
                var user = User.fromJson(userMap);
                print("Hello,${user.name}!");
                print("We sent the verification link to ${user.email}.");
                print("转json${json.encode(user)}");
              },
              child: Text("decode user"))
        ],
      ),
    );
  }
}
