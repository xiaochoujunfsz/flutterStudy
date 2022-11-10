import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gsy_app_test/common/localization/default_localizations.dart';

//多语言代理
class BaseLocalizationsDelegate
    extends LocalizationsDelegate<BaseLocalizations> {
  BaseLocalizationsDelegate();

  //全局静态代理
  static LocalizationsDelegate<BaseLocalizations> delegate =
      BaseLocalizationsDelegate();

  //是否支持当前Locale
  @override
  bool isSupported(Locale locale) {
    return true;
  }

  //加载资源，返回资源实例
  @override
  Future<BaseLocalizations> load(Locale locale) {
    return SynchronousFuture<BaseLocalizations>(BaseLocalizations(locale));
  }

  //判断是否需要重载
  @override
  bool shouldReload(covariant LocalizationsDelegate<BaseLocalizations> old) {
    return false;
  }
}
