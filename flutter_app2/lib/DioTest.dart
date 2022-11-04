import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class DioTestPage extends StatefulWidget {
  const DioTestPage({Key? key}) : super(key: key);

  @override
  State<DioTestPage> createState() => _DioTestPageState();
}

class _DioTestPageState extends State<DioTestPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("DioTest"),
      ),
      body: Container(),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          Response _headReq = await Dio().get('https://www.baidu.com/');
          print("HEAD请求到数据：${_headReq.data}\n");
          print("HEAD请求到extra：${_headReq.extra}\n");
          print("HEAD请求到headers：${_headReq.headers}\n");
          print("HEAD请求到isRedirect：${_headReq.isRedirect}\n");
          print("HEAD请求到statusCode：${_headReq.statusCode}\n");
          print("HEAD请求到statusMessage：${_headReq.statusMessage}\n");
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
