import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app2/HttpManager.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //强制竖屏
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  //顶部 底部 都显示状态栏
  await SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);

  //网络请求管理初始化
  HttpManager().init(baseUrl: 'https://tieba.baidu.com/f');
  runApp(const MaterialApp(
    home: DioTestPage(),
  ));
}

class DioTestPage extends StatefulWidget {
  const DioTestPage({Key? key}) : super(key: key);

  @override
  State<DioTestPage> createState() => _DioTestPageState();
}

class _DioTestPageState extends State<DioTestPage> {
  var _tag;

  void _testDioPostReq() async {
    _tag = "${DateTime.now().millisecondsSinceEpoch}";
    HttpManager().post(
        url: "",
        params: {"ie": "utf-8", "kw": "大佬", "fr": "search"},
        successCallback: (data) {
          print("响应数据：$data");
          //取消请求
          HttpManager().cancel(_tag);
        },
        errorCallback: (data) {
          print("响应数据错误：$data");
        },
        tag: "$_tag");
  }

  void _testDioGetReq() async {
    _tag = "${DateTime.now().millisecondsSinceEpoch}";
    HttpManager().get(
        url: "https://www.baidu.com/",
        params: {},
        successCallback: (data) {
          print("响应数据：$data");
          //取消请求
          HttpManager().cancel(_tag);
        },
        errorCallback: (data) {
          print("响应数据错误：$data");
        },
        tag: "$_tag");
  }

  void _testDioPrintInfo() async {
    Response _headReq = await Dio().get('https://www.baidu.com/');
    print("HEAD请求到数据：${_headReq.data}\n");
    print("HEAD请求到extra：${_headReq.extra}\n");
    print("HEAD请求到headers：${_headReq.headers}\n");
    print("HEAD请求到isRedirect：${_headReq.isRedirect}\n");
    print("HEAD请求到statusCode：${_headReq.statusCode}\n");
    print("HEAD请求到statusMessage：${_headReq.statusMessage}\n");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("DioTest"),
      ),
      body: Container(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _testDioPostReq();
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
