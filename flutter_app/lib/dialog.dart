import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

//弹出对话框
Future<bool> showDeleteConfirmDialog1(BuildContext context) {
  return showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("提示"),
          content: Text("您确定要删除当前文件吗?"),
          actions: [
            TextButton(
              child: Text("取消"),
              onPressed: () => Navigator.of(context).pop(), // 关闭对话框
            ),
            TextButton(
              child: Text("删除"),
              onPressed: () {
                //关闭对话框并返回true
                Navigator.of(context).pop(true);
              },
            )
          ],
        );
      });
}

Future<void> changeLanguage(BuildContext context) async {
  int i = await showDialog<int>(
      context: context,
      builder: (context) {
        return SimpleDialog(
          title: const Text("请选择语言"),
          children: [
            SimpleDialogOption(
              onPressed: () {
                //返回1
                Navigator.pop(context, 1);
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 6),
                child: const Text('中文简体'),
              ),
            ),
            SimpleDialogOption(
              onPressed: () {
                // 返回2
                Navigator.pop(context, 2);
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 6),
                child: const Text('美国英语'),
              ),
            ),
          ],
        );
      });
  if (i != null) {
    print("选择了：${i == 1 ? "中文简体" : "美国英语"}");
  }
}

Future<void> showListDialog(BuildContext context) async {
  int index = await showDialog<int>(
      context: context,
      builder: (context) {
        return Dialog(
          child: Column(
            children: [
              ListTile(title: Text("请选择")),
              Expanded(
                  child: ListView.builder(
                itemCount: 30,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    title: Text("$index"),
                    onTap: () => Navigator.of(context).pop(index),
                  );
                },
              )),
            ],
          ),
        );
      });
  if (index != null) {
    print("点击了：$index");
  }
}

Future<T> showCustomDialog<T>(
    {@required BuildContext context,
    bool barrierDismissible = true,
    WidgetBuilder builder}) {
  final ThemeData theme = Theme.of(context);
  return showGeneralDialog(
      context: context,
      pageBuilder: (buildContext, animation, secondaryAnimation) {
        final Widget pageChild = Builder(
          builder: builder,
        );
        return SafeArea(child: Builder(builder: (context) {
          return theme != null
              ? Theme(
                  data: theme,
                  child: pageChild,
                )
              : pageChild;
        }));
      },
      barrierDismissible: barrierDismissible,
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      barrierColor: Colors.black87,
      // 自定义遮罩颜色
      transitionDuration: const Duration(milliseconds: 150),
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        return ScaleTransition(
          scale: CurvedAnimation(
            parent: animation,
            curve: Curves.easeOut,
          ),
          child: child,
        );
      });
}

Future<bool> showDeleteConfirmDialog4(BuildContext context) {
  bool _withTree = false;
  return showDialog<bool>(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text("提示"),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text("您确定要删除当前文件吗?"),
            Row(
              children: <Widget>[
                Text("同时删除子目录？"),
                // 通过Builder来获得构建Checkbox的`context`，
                // 这是一种常用的缩小`context`范围的方式
                Builder(
                  builder: (BuildContext context) {
                    return Checkbox(
                      value: _withTree,
                      onChanged: (bool value) {
                        (context as Element).markNeedsBuild();
                        _withTree = !_withTree;
                      },
                    );
                  },
                ),
              ],
            ),
          ],
        ),
        actions: <Widget>[
          TextButton(
            child: Text("取消"),
            onPressed: () => Navigator.of(context).pop(),
          ),
          TextButton(
            child: Text("删除"),
            onPressed: () {
              // 执行删除操作
              Navigator.of(context).pop(_withTree);
            },
          ),
        ],
      );
    },
  );
}

// 弹出底部菜单列表模态对话框
Future<int> showModalBottomSheetTest(BuildContext context) {
  return showModalBottomSheet(
      context: context,
      builder: (context) => ListView.builder(
          itemBuilder: (context, index) => ListTile(
                title: Text("$index"),
                onTap: () => Navigator.of(context).pop(index),
              )));
}

// 返回的是一个controller
PersistentBottomSheetController<int> showBottomSheetTest(BuildContext context) {
  //必须保证父级组件中有Scaffold
  return showBottomSheet<int>(
      context: context,
      builder: (context) => ListView.builder(
          itemCount: 30,
          itemBuilder: (context, index) => ListTile(
                title: Text("$index"),
                onTap: () {
                  // print("$index");
                  // Navigator.of(context).pop();
                },
              )));
}

//Loading框
showLoadingDialog(BuildContext context) {
  showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircularProgressIndicator(),
                Padding(
                  padding: const EdgeInsets.only(top: 26),
                  child: Text("正在加载...请稍后"),
                )
              ],
            ),
          ));
}

//Material风格的日历选择器
Future<DateTime> showDatePick1(BuildContext context) {
  var date = DateTime.now();
  return showDatePicker(
      context: context,
      initialDate: date,
      firstDate: date,
      lastDate: date.add(Duration(days: 30)));
}

//iOS风格的日历选择器
Future<DateTime> showDatePick2(BuildContext context) {
  var date = DateTime.now();
  return showCupertinoModalPopup(
      context: context,
      builder: (context) => SizedBox(
            height: 200,
            child: CupertinoDatePicker(
              backgroundColor: Colors.white,
              mode: CupertinoDatePickerMode.dateAndTime,
              minimumDate: date,
              maximumDate: date.add(Duration(days: 30)),
              maximumYear: date.year + 1,
              onDateTimeChanged: (value) {
                print(value);
              },
            ),
          ));
}
