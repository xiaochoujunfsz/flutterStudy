import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/dialog.dart';
import 'package:flutter_app/mock.dart';
import 'package:flutter_app/model.dart';

import 'data.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("首页"),
      ),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, "willpop_scope_test");
                },
                child: Text("WillPopScopeTestRoute组件")),
            ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, "inherited_widget_test");
                },
                child: Text("InheritedWidgetTestRoute组件")),
            ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, "provider_test");
                },
                child: Text("ProvideRoute组件")),
            ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, "theme_test");
                },
                child: Text("ThemeTest组件")),
            ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, "future_stream_test");
                },
                child: Text("FutureBuilderAndStreamBuilderTest组件")),
            ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, "dialog_test");
                },
                child: Text("DialogTest组件")),
          ],
        ),
      ),
    );
  }
}

class ShareDataWidget extends InheritedWidget {
  final int data; //需要在子树中共享的数据，保存点击次数

  ShareDataWidget({@required this.data, Widget child}) : super(child: child);

  //定义一个便捷方法，方便子树中的widget获取共享数据
  static ShareDataWidget of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<ShareDataWidget>();
  }

  //该回调决定当data发生变化时，是否通知子树中依赖data的Widget
  @override
  bool updateShouldNotify(ShareDataWidget oldWidget) {
    //如果返回true，则子树中依赖(build函数中有调用)本widget的子widget的`state.didChangeDependencies`会被调用
    return oldWidget.data != data;
  }
}

class _TestWidget extends StatefulWidget {
  @override
  _TestWidgetState createState() {
    return _TestWidgetState();
  }
}

class _TestWidgetState extends State<_TestWidget> {
  @override
  Widget build(BuildContext context) {
    //使用InheritedWidget中的共享数据
    return Text(ShareDataWidget.of(context).data.toString());
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    //父或祖先widget中的InheritedWidget改变(updateShouldNotify返回true)时会被调用，如果build中没有依赖InheritedWidget，则此回调不会被调用
    print("Dependencies change");
  }
}

class InheritedWidgetTestRoute extends StatefulWidget {
  @override
  _InheritedWidgetTestRouteState createState() {
    return _InheritedWidgetTestRouteState();
  }
}

class _InheritedWidgetTestRouteState extends State<InheritedWidgetTestRoute> {
  int count = 0;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ShareDataWidget(
        data: count,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: _TestWidget(),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  ++count;
                });
              },
              child: Text("Increment"),
            ),
            //背景为蓝色，则title自动为白色
            NavBar(
              color: Colors.blue,
              title: "标题",
            ),
            //背景为白色，则title自动为黑色
            NavBar(
              color: Colors.white,
              title: "标题",
            ),
          ],
        ),
      ),
    );
  }
}

class InheritedProvider<T> extends InheritedWidget {
  InheritedProvider({@required this.data, Widget child}) : super(child: child);

  final T data;

  @override
  bool updateShouldNotify(InheritedProvider<T> oldWidget) {
    //在此简单返回true，则每次更新都会调用依赖其的子孙节点的`didChangeDependencies`。
    return true;
  }
}

class ChangeNotifierProvider<T extends ChangeNotifier> extends StatefulWidget {
  final Widget child;
  final T data;

  ChangeNotifierProvider({Key key, this.data, this.child});

  //定义一个便捷方法，方便子树中的widget获取共享数据
  //添加listen参数，表示是否建立依赖关系
  static T of<T>(BuildContext context, {bool listen = true}) {
    final provider = listen
        ? context.dependOnInheritedWidgetOfExactType<InheritedProvider<T>>()
        : context
            .getElementForInheritedWidgetOfExactType<InheritedProvider<T>>()
            ?.widget as InheritedProvider<T>;
    return provider.data;
  }

  @override
  _ChangeNotifierProviderState createState() {
    return _ChangeNotifierProviderState<T>();
  }
}

class _ChangeNotifierProviderState<T extends ChangeNotifier>
    extends State<ChangeNotifierProvider<T>> {
  void update() {
    //如果数据发生变化（model类调用了notifyListeners），重新构建InheritedProvider
    setState(() {});
  }

  @override
  void didUpdateWidget(ChangeNotifierProvider<T> oldWidget) {
    //当Provider更新时，如果新旧数据不"=="，则解绑旧数据监听，同时添加新数据监听
    if (widget.data != oldWidget.data) {
      oldWidget.data.removeListener(update);
      widget.data.addListener(update);
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void initState() {
    // 给model添加监听器
    widget.data.addListener(update);
    super.initState();
  }

  @override
  void dispose() {
    // 移除model的监听器
    widget.data.removeListener(update);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return InheritedProvider<T>(
      data: widget.data,
      child: widget.child,
    );
  }
}

class ProvideRoute extends StatefulWidget {
  @override
  _ProvideRouteState createState() {
    return _ProvideRouteState();
  }
}

class _ProvideRouteState extends State<ProvideRoute> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("跨组件状态管理"),
      ),
      body: Center(
        child: ChangeNotifierProvider<CartModel>(
          data: CartModel(),
          child: Builder(
            builder: (context) {
              return Column(
                children: [
                  // Builder(
                  //   builder: (context) {
                  //     var cart = ChangeNotifierProvider.of<CartModel>(context);
                  //     return Text("总价：${cart.totalPrice}");
                  //   },
                  // ),
                  Consumer<CartModel>(
                      builder: (context, cart) =>
                          Text("总价：${cart.totalPrice}")),
                  Builder(builder: (context) {
                    print("RaisedButton build");
                    return ElevatedButton(
                      onPressed: () {
                        //给购物车中添加商品，添加后总价会更新
                        ChangeNotifierProvider.of<CartModel>(context,
                                listen: false)
                            .add(Item(20, 1));
                      },
                      child: Text("添加商品"),
                    );
                  })
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

// 这是一个便捷类，会获得当前context和指定数据类型的Provider
class Consumer<T> extends StatelessWidget {
  final Widget child;
  final Widget Function(BuildContext context, T value) builder;

  Consumer({Key key, @required this.builder, this.child})
      : assert(builder != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return builder(
      context,
      ChangeNotifierProvider.of(context),
    );
  }
}

class NavBar extends StatelessWidget {
  final String title;
  final Color color; //背景颜色

  NavBar({Key key, this.color, this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(minHeight: 52, minWidth: double.infinity),
      decoration: BoxDecoration(color: color, boxShadow: [
        //阴影
        BoxShadow(color: Colors.black26, offset: Offset(0, 3), blurRadius: 3)
      ]),
      child: Text(
        title,
        style: TextStyle(
            fontWeight: FontWeight.bold,
            //根据背景色亮度来确定Title颜色
            color:
                color.computeLuminance() < 0.5 ? Colors.white : Colors.black),
      ),
      alignment: Alignment.center,
    );
  }
}

class ThemeTestRoute extends StatefulWidget {
  const ThemeTestRoute({Key key}) : super(key: key);

  @override
  _ThemeTestRouteState createState() => _ThemeTestRouteState();
}

class _ThemeTestRouteState extends State<ThemeTestRoute> {
  Color _themColor = Colors.teal; //当前路由主题色

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    return Theme(
      data: ThemeData(
          primarySwatch: _themColor, //用于导航栏、FloatingActionButton的背景色等
          iconTheme: IconThemeData(color: _themColor) //用于Icon颜色
          ),
      child: Scaffold(
        appBar: AppBar(
          title: Text("主题测试"),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //第一行Icon使用主题中的iconTheme
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.favorite),
                Icon(Icons.airport_shuttle),
                Text(" 颜色跟随主题"),
              ],
            ),
            //为第二行Icon自定义颜色（固定为黑色)
            Theme(
              data: themeData.copyWith(
                  iconTheme: themeData.iconTheme.copyWith(color: Colors.black)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.favorite),
                  Icon(Icons.airport_shuttle),
                  Text("  颜色固定黑色")
                ],
              ),
            )
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            setState(() {
              _themColor =
                  _themColor == Colors.teal ? Colors.blue : Colors.teal;
            });
          },
          child: Icon(Icons.palette),
        ),
      ),
    );
  }
}

class FutureBuilderAndStreamBuilderTestRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("FutureBuilder和StreamBuilder"),
      ),
      body: Center(
        child: Column(
          children: [
            FutureBuilder<String>(
              future: mockNetworkData(),
              builder: (context, snapshot) {
                // 请求已结束
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasError) {
                    // 请求失败，显示错误
                    return Text("Error: ${snapshot.error}");
                  } else {
                    // 请求成功，显示数据
                    return Text("Contents: ${snapshot.data}");
                  }
                } else {
                  // 请求未结束，显示loading
                  return CircularProgressIndicator();
                }
              },
            ),
            StreamBuilder<int>(
                stream: counter(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  }
                  switch (snapshot.connectionState) {
                    case ConnectionState.none:
                      return Text('没有Stream');
                    case ConnectionState.waiting:
                      return Text('等待数据...');
                    case ConnectionState.active:
                      return Text('active: ${snapshot.data}');
                    case ConnectionState.done:
                      return Text('Stream已关闭');
                  }
                  return null;
                }),
          ],
        ),
      ),
    );
  }
}

class DialogTestRoute extends StatelessWidget {
  const DialogTestRoute({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("对话框"),
      ),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
                onPressed: () async {
                  //弹出对话框并等待其关闭
                  bool delete = await showDeleteConfirmDialog1(context);
                  if (delete == null) {
                    print("取消删除");
                  } else {
                    print("已确认删除");
                    //... 删除文件
                  }
                },
                child: Text("对话框1")),
            ElevatedButton(
                onPressed: () {
                  changeLanguage(context);
                },
                child: Text("对话框2")),
            ElevatedButton(
                onPressed: () {
                  showListDialog(context);
                },
                child: Text("对话框3")),
            ElevatedButton(
                onPressed: () {
                  showCustomDialog<bool>(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text("提示"),
                          content: Text("您确定要删除当前文件吗?"),
                          actions: [
                            TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text("取消")),
                            TextButton(
                                onPressed: () {
                                  Navigator.pop(context, true);
                                },
                                child: Text("删除")),
                          ],
                        );
                      });
                },
                child: Text("对话框4")),
            ElevatedButton(
                onPressed: () {
                  showDeleteConfirmDialog4(context);
                },
                child: Text("对话框5")),
            ElevatedButton(
                onPressed: () async {
                  int type = await showModalBottomSheetTest(context);
                  print(type);
                },
                child: Text("对话框6")),
            Builder(
              builder: (context) => ElevatedButton(
                  onPressed: () {
                    showBottomSheetTest(context);
                  },
                  child: Text("对话框7")),
            ),
            ElevatedButton(
                onPressed: () {
                  showLoadingDialog(context);
                },
                child: Text("对话框8")),
            ElevatedButton(
                onPressed: () {
                  showDatePick1(context);
                },
                child: Text("时间选择对话框1")),
            ElevatedButton(
                onPressed: () {
                  showDatePick2(context);
                },
                child: Text("时间选择对话框2")),
          ],
        ),
      ),
    );
  }
}
