import 'dart:async';

import 'package:english_words/english_words.dart';
import 'package:flutter/foundation.dart';

void main() {
  // var name = "Bob";
  // Object name1 = "张三";
  // dynamic name2 = "李四";
  //
  // String name4 = "ssd";

  // int lineCount;
  // assert(lineCount == null);
  // print(lineCount);

  // final name = "ssds";
  // final String name1 = "sdsad";
  //
  // const name2 = "weqw";
  // const String name3 = "sdadw";

  // const speed = 100;
  // const double distance = 2.5 * speed;
  //
  // final speed1 = 100;
  // final distance1 = 2.5 * speed1;
  //
  // print("$distance:::$distance1");

  // var varList = const [];
  // final finalList = const [];
  // const constList = const [];
  //
  // varList = ["jjj"];

  // print(say("Bob", "Howdy"));
  // print(say("Bob", "Howdy", "smoke signal"));

  // enableFlags();
  // enableFlags(hidden: false);

  // Future.delayed(new Duration(seconds: 2), () {
  //   return "hi world";
  // }).then((value) {
  //   print(value);
  // });
  //
  // Future.delayed(new Duration(seconds: 2), () {
  //   throw AssertionError("Error");
  // }).then((value) {
  //   print(value);
  // }).catchError((e) {
  //   print(e);
  // }).whenComplete(() {
  //   print("完成");
  // });
  //
  // Future.delayed(new Duration(seconds: 2), () {
  //   throw AssertionError("Error");
  // }).then((value) {
  //   print(value);
  // }, onError: (e) {
  //   print(e);
  // });

  // Future.wait([
  //   //2秒后返回结果
  //   Future.delayed(new Duration(seconds: 2), () {
  //     print("1111");
  //     return "hello";
  //   }),
  //   Future.delayed(new Duration(seconds: 4), () {
  //     print("2222");
  //     return "world";
  //   }),
  //   Future.delayed(new Duration(seconds: 3), () {
  //     throw AssertionError("wulala");
  //   })
  // ]).then((results) {
  //   print(results[0] + results[1]);
  // }).catchError((e) {
  //   print(e);
  // });

  // print("task:::${task()}");
  // task().then((value){
  //   print("task执行结果:$value");
  // });

  // var i;
  // i = "ss";
  // print(i);
  // i = 20;
  // print(i);
  // Person person = new Person();
  // person._age = 20;
  // print(person._age);

  // print(new WordPair.random());
  //
  // Stream.fromFutures([
  //   Future.delayed(new Duration(seconds: 1), () {
  //     return "hello 1";
  //   }),
  //   Future.delayed(new Duration(seconds: 2), () {
  //     throw AssertionError("Error");
  //   }),
  //   Future.delayed(new Duration(seconds: 3), () {
  //     return "hello 3";
  //   })
  // ]).listen((event) {
  //   print(event);
  // }, onError: (e) {
  //   print(e);
  // }, onDone: () {
  //   print("完成");
  // });

  // try {
  //   Future.delayed(new Duration(seconds: 1))
  //       .then((value) => {Future.error('error')});
  // } catch (e) {
  //   print("无法捕获：$e");
  // }

  // runZonedGuarded(
  //   () => Future.delayed(Duration(seconds: 1))
  //       .then((value) => {print("新方法给你捕获"), Future.error("errorA")}),
  //   (Object error, StackTrace stack) {
  //     print("新方法捕获到了--$error");
  //   },
  //   zoneSpecification: ZoneSpecification(
  //       print: (Zone self, ZoneDelegate parent, Zone zone, String line) {
  //     Future.error("新方法error--$line");
  //   }),
  // );

  // runZoned(
  //   () => Future.delayed(Duration(seconds: 1))
  //       .then((value) => {print("老方法给你捕获"), Future.error("errorB")}),
  //   zoneSpecification: ZoneSpecification(
  //       print: (Zone self, ZoneDelegate parent, Zone zone, String line) {
  //     Future.error("老方法error--$line");
  //   }),
  //   onError: (Object error, StackTrace stack) {
  //     print("老方法捕获到了--$error");
  //   },
  // );
}

String say(String from, String msg, [String device]) {
  var result = '$from says $msg';
  if (device != null) {
    result = "$result with a $device";
  }
  return result;
}

void enableFlags({bool bold, bool hidden}) {
  print("$bold---$hidden");
}

class Test {
  void test() {}
}

class Person {
  String name;
  int _age;
}

Future<String> login(String userName, String pwd) {
  return Future.delayed(new Duration(seconds: 1), () {
    return userName + pwd;
  });
}

Future<String> getUserInfo(String id) {
  return Future.delayed(new Duration(seconds: 1), () {
    return id;
  });
}

Future<String> saveUserInfo(String userInfo) {
  return Future.delayed(new Duration(seconds: 2), () {
    print("saveUserInfo$userInfo");
    return userInfo;
  });
}

Future task() async {
  try {
    String id = await login("userName", "pwd");
    String userInfo = await getUserInfo(id);
    return await saveUserInfo(userInfo);
  } catch (e) {
    print(e);
  }
}
