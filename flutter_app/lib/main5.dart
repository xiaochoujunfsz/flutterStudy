import 'package:flutter/material.dart';
import 'package:flutter_app/widget5.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        routes: {
          "/": (context) => HomePage(),
          "file_operation": (context) => FileOperationRoute(),
          "car_view_page": (context) => CarPage(),
          "dio_page": (context) => DioPage(),
          "web_socket_page": (context) => WebSocketRoute(),
          "json_test_page": (context) => JsonTestRoute(),
        });
  }
}