import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/widget6.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        localizationsDelegates: [
          //本地化的代理类
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          //注册自己的Delegate
          DemoLocalizationsDelegate()
        ],
        supportedLocales: [
          const Locale('en', 'US'), //美国英语
          const Locale('zh', 'CN'), //中文简体
        ],
        //监听系统语言切换
        localeListResolutionCallback:
            (List<Locale> locales, Iterable<Locale> supportedLocales) {
          //使用的语言在支持列表，则使用，否则给一个默认语言
          if (locales != null && locales.isNotEmpty) {
            for (var value in locales) {
              if (supportedLocales.contains(value)) {
                return value;
              }
            }
          }
          return supportedLocales.first;
        },
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        routes: {
          "/": (context) => HomePage(),
          "single_scroll": (context) => SingleScrollPage(),
          "my_image_test": (context) => MyImageTestPage(),
        });
  }
}

//Locale资源类
class DemoLocalizations {
  DemoLocalizations(this.isZh);

  //是否是中文
  bool isZh = false;

  //为了使用方便，我们定义一个静态方法
  static DemoLocalizations of(BuildContext context) {
    return Localizations.of<DemoLocalizations>(context, DemoLocalizations);
  }

  //Locale相关值，title为应用标题
  String get title {
    return isZh ? "Flutter应用" : "Flutter APP";
  }
//... 其它的值
}

//Locale代理类
class DemoLocalizationsDelegate
    extends LocalizationsDelegate<DemoLocalizations> {
  //是否支持某个Local
  @override
  bool isSupported(Locale locale) {
    return ['en', 'zh'].contains(locale.languageCode);
  }

  // Flutter会调用此类加载相应的Locale资源类
  @override
  Future<DemoLocalizations> load(Locale locale) {
    print("$locale");
    return SynchronousFuture<DemoLocalizations>(
        DemoLocalizations(locale.languageCode == "zh"));
  }

  //当Localizations组件重新build时，是否调用load方法重新加载Locale资源
  @override
  bool shouldReload(covariant LocalizationsDelegate<DemoLocalizations> old) {
    return false;
  }
}
