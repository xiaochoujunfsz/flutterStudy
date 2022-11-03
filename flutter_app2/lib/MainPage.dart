import 'dart:math';

import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  static const MODE_STATIC = 0; //文字静止状态
  static const MODE_FOCUS = 1; //文字聚焦状态
  static const MODE_DELETE = 2; //文字删除状态
  int mode = MODE_STATIC;
  final GlobalKey textKey = GlobalKey();
  final GlobalKey deleteKey = GlobalKey();
  String textStr = "哈哈哈哈哈";

  //静止状态下的offse
  Offset idleOffset = Offset(0, 0);

  //本次移动的offset
  Offset moveOffset = Offset(0, 0);

  //最后一次down事件的offset
  Offset lastStartOffset = Offset(0, 0);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.fill,
                  image: AssetImage("assets/home/main_bg.jpeg"),
                )),
            child: Container()),
        Positioned(
          child: IconButton(
            onPressed: () {},
            icon: Image.asset("assets/home/wenzi.png"),
          ),
          right: 15,
          top: 5,
        ),
        Align(
          child: Container(
            key: deleteKey,
            margin: EdgeInsets.only(bottom: 20),
            child: IconButton(
              onPressed: () {},
              icon: Image.asset("assets/home/delete.png"),
            ),
          ),
          alignment: Alignment.bottomCenter,
        ),
        Transform.translate(
          offset: moveOffset,
          child: GestureDetector(
            onLongPress: () {
              setState(() {
                mode = MODE_FOCUS;
              });
            },
            onPanStart: (detail) {
              setState(() {
                lastStartOffset = detail.globalPosition;
              });
            },
            onPanUpdate: (detail) {
              if (mode == MODE_FOCUS) {
                setState(() {
                  if ((detail.globalPosition - lastStartOffset).dx > 0 &&
                      (detail.globalPosition - lastStartOffset).dy > 0) {}
                  moveOffset =
                      detail.globalPosition - lastStartOffset + idleOffset;
                  moveOffset = Offset(
                      min(
                          max(0, moveOffset.dx),
                          (MediaQuery.of(context).size.width -
                              (textKey.currentContext?.size?.width ?? 0))),
                      min(
                          max(0, moveOffset.dy),
                          (MediaQuery.of(context).size.height -
                              MediaQuery.of(context).padding.top -
                              (textKey.currentContext?.size?.height ?? 0))));
                });
              }
            },
            onPanEnd: (detail) {
              setState(() {
                idleOffset = moveOffset * 1;
                var centerOffset = Offset(
                    idleOffset.dx +
                        (textKey.currentContext?.size?.width ?? 0) / 2,
                    idleOffset.dy +
                        MediaQuery.of(context).padding.top +
                        (textKey.currentContext?.size?.height ?? 0) / 2);
                RenderBox? deleteBox =
                deleteKey.currentContext?.findRenderObject() as RenderBox?;
                var offset = (deleteBox?.localToGlobal(Offset(
                    ((deleteBox.size.width) / 2),
                    ((deleteBox.size.height) / 2)))) ??
                    Offset(0, 0);
                var differX = (centerOffset.dx - offset.dx).abs();
                var differY = (centerOffset.dy - offset.dy).abs();
                if (differX < 50 && differY < 50) {
                  mode = MODE_DELETE;
                } else {
                  mode = MODE_STATIC;
                }
                print(
                    "抬起的地方$idleOffset---文字中心的位置---${centerOffset}---垃圾桶的位置---${offset}");
              });
            },
            child: Opacity(
              opacity: (mode == MODE_DELETE) ? 0 : 1,
              child: Container(
                decoration: (mode == MODE_FOCUS)
                    ? BoxDecoration(
                    border: Border.all(width: 2, color: Colors.blue))
                    : null,
                child: Text(
                  textStr,
                  key: textKey,
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
