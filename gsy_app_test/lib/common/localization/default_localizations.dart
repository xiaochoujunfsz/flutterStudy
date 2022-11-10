//自定义多语言实现
import 'package:flutter/material.dart';
import 'package:gsy_app_test/common/localization/string_base.dart';
import 'package:gsy_app_test/common/localization/string_en.dart';
import 'package:gsy_app_test/common/localization/string_zh.dart';

class BaseLocalizations {
  final Locale locale;

  BaseLocalizations(this.locale);

  //根据不同 locale.languageCode 加载不同语言对应
  static Map<String, StringBase> _localizedValues = {
    "en": StringEn(),
    "zh": StringZh(),
  };

  StringBase? get currentLocalized {
    if (_localizedValues.containsKey(locale.languageCode)) {
      return _localizedValues[locale.languageCode];
    }
    return _localizedValues["en"];
  }

  //通过 Localizations 加载当前的 DefaultLocalizations获取对应的StringBase
  static BaseLocalizations? of(BuildContext context) {
    return Localizations.of(context, BaseLocalizations);
  }

  static StringBase? i18n(BuildContext context) {
    return (Localizations.of(context, BaseLocalizations)
            as BaseLocalizations)
        .currentLocalized;
  }
}
