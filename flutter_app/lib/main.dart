import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/demo.dart';
import 'package:flutter_app/widget.dart';

var isLogin = false;

void main() {
  FlutterError.onError = (FlutterErrorDetails details) {
    print("自定义错误：：$details");
  };
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final String jsonPath = "assets/config.json";

  @override
  Widget build(BuildContext context) {
    rootBundle.loadString(jsonPath).then((value) => {print(value)});
    DefaultAssetBundle.of(context)
        .loadString(jsonPath)
        .then((value) => {print(value)});
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        "new_page": (context) => NewRoute(),
        "echo_page": (context) => EchoRoute(),
        "need_login_page2": (context) => NeedLoginPage2(),
        "need_login_page1": (context) => NeedLoginPage1(),
        "switch_checkbox_test": (context) => SomeWidgetTestPage(),
        "form_test": (context) => FormTestRoute(),
        "row_test": (context) => RowTest(),
        "flow_layout_test": (context) => FlowLayoutTest(),
        "scaffold_test": (context) => ScaffoldRoute(),
        "custom_scrollview_test": (context) => CustomScrollViewTestRoute(),
        "scroll_controller_test": (context) => ScrollControllerTestRoute(),
        "scroll_notification_test": (context) => ScrollNotificationTestRoute(),
        "/": (context) => MyHomePage(title: 'Flutter Demo Home Page')
      },
      // onGenerateRoute: (RouteSettings settings) {
      //   String routeName = settings.name;
      //   print("onGenerateRoute:$routeName --- $isLogin");
      //   if (isLogin) {
      //     switch (routeName) {
      //       case "need_login_page1":
      //         return MaterialPageRoute(builder: (context) {
      //           return NeedLoginPage1();
      //         });
      //       case "need_login_page2":
      //         return MaterialPageRoute(builder: (context) {
      //           return NeedLoginPage2();
      //         });
      //       default:
      //         return MaterialPageRoute(builder: (context) {
      //           return MyHomePage(title: 'aaaaaaaaaaa');
      //         });
      //     }
      //   } else {
      //     return MaterialPageRoute(builder: (context) {
      //       return MyHomePage(title: 'Flutter Demo Home Page');
      //     });
      //   }
      // },
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
            TapboxBParent(),
            TextButton(
                onPressed: () async {
                  var result = await Navigator.push(context,
                      MaterialPageRoute(builder: (context) {
                    return TipRoute(text: "我是提示JJJJJ");
                  }));
                  print("路由返回值：$result");
                },
                child: Text("打开提示页", style: TextStyle(color: Colors.blue)))
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class NewRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("New route"),
      ),
      body: Center(
        child: Text("This is new route"),
      ),
    );
  }
}

class TipRoute extends StatelessWidget {
  TipRoute({Key key, @required this.text}) : super(key: key);
  final String text;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("提示"),
      ),
      body: Padding(
        padding: EdgeInsets.all(18),
        child: Center(
          child: Column(
            children: [
              Text(text),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context, "我是返回值");
                },
                child: Text("返回"),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return NewRoute();
                  }));
                },
                child: Text("新页面"),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, "echo_page",
                      arguments: "hi world");
                },
                child: Text("命名路由"),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, "need_login_page1",
                      arguments: "hello world");
                },
                child: Text("需要登录1"),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, "need_login_page2",
                      arguments: "pey world");
                },
                child: Text("需要登录2"),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, "switch_checkbox_test");
                },
                child: Text("开关测试"),
              ),
              IconButton(
                icon: Icon(Icons.login),
                onPressed: () {
                  Navigator.pushNamed(context, "form_test");
                },
              ),
              ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, "row_test");
                  },
                  child: Text("线性布局-ROW")),
              ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, "flow_layout_test");
                  },
                  child: Text("流式布局")),
              ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, "scaffold_test");
                  },
                  child: Text("Scaffold组件")),
              ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, "custom_scrollview_test");
                  },
                  child: Text("CustomScrollView组件")),
              ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, "scroll_controller_test");
                  },
                  child: Text("ScrollControllerView组件"))
            ],
          ),
        ),
      ),
    );
  }
}

class EchoRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var args = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text("命名路由传参"),
      ),
      body: Center(
        child: Text(args),
      ),
    );
  }
}

class NeedLoginPage1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("需要登录1"),
      ),
      body: Center(
          child: Column(
        children: [
          Text("你进来了，证明你已经登录了"),
          Image.asset("images/2.png"),
          DecoratedBox(
            decoration: BoxDecoration(
                image: DecorationImage(image: AssetImage("images/2.png"))),
            child: Text("呜啦啦啦"),
          ),
          LinearProgressIndicator(
            backgroundColor: Colors.grey[200],
            valueColor: AlwaysStoppedAnimation(Colors.blue),
          ),
          SizedBox(
            height: 13,
            child: LinearProgressIndicator(
              backgroundColor: Colors.grey[200],
              valueColor: AlwaysStoppedAnimation(Colors.blue),
              value: .5,
            ),
          ),
          CircularProgressIndicator(
            backgroundColor: Colors.grey[200],
            valueColor: AlwaysStoppedAnimation(Colors.blue),
          ),
          SizedBox(
            width: 100,
            height: 100,
            child: CircularProgressIndicator(
              backgroundColor: Colors.grey[200],
              valueColor: AlwaysStoppedAnimation(Colors.blue),
              value: .5,
              strokeWidth: 6.0,
            ),
          ),
          ProgressRoute()
        ],
      )),
    );
  }
}

class NeedLoginPage2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("需要登录2"),
      ),
      body: Center(
          child: Column(
        children: [
          Text("你进来了，证明你已经登录了"),
          Image.asset("images/1.png"),
          ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, "scroll_notification_test");
              },
              child: Text("ScrollNotificationView组件"))
        ],
      )),
    );
  }
}

class NoLoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("未登录")),
      body: Center(
        child: Text("没登录还想看，滚去登录"),
      ),
    );
  }
}

class SomeWidgetTestPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("开关"),
        ),
        body: Center(
          child: SwitchAndCheckBoxTestRoute(),
        ));
  }
}
