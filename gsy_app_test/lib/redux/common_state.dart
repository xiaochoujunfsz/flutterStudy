import 'package:flutter/material.dart';
import 'package:gsy_app_test/model/User.dart';

//全局Redux state
class CommonState {
  //用户信息
  User? userInfo;

  //主题数据
  ThemeData? themeData;

  //语言
  Locale? locale;

  //当前手机平台默认语言
  Locale? platformLocale;

  //是否登录
  bool? login;

  //是否变灰色
  bool grey;

  //构造方法
  CommonState(
      {this.userInfo,
      this.themeData,
      this.locale,
      this.login,
      this.grey = false});
}

//创建Reducer
CommonState appReducer(CommonState state,action) {
  return CommonState(

  );
}
