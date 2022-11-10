//颜色
import 'package:flutter/material.dart';

class ColorUtil {
  static const int primaryIntValue = 0xFF24292E;

  static const MaterialColor primarySwatch = MaterialColor(
    primaryIntValue,
    <int, Color>{
      50: Color(primaryIntValue),
      100: Color(primaryIntValue),
      200: Color(primaryIntValue),
      300: Color(primaryIntValue),
      400: Color(primaryIntValue),
      500: Color(primaryIntValue),
      600: Color(primaryIntValue),
      700: Color(primaryIntValue),
      800: Color(primaryIntValue),
      900: Color(primaryIntValue),
    },
  );

  static const String primaryValueString = "#24292E";
  static const String primaryLightValueString = "#42464b";
  static const String primaryDarkValueString = "#121917";
  static const String miWhiteString = "#ececec";
  static const String actionBlueString = "#267aff";
  static const String webDraculaBackgroundColorString = "#282a36";

  static const Color primaryValue = Color(0xFF24292E);
  static const Color primaryLightValue = Color(0xFF42464b);
  static const Color primaryDarkValue = Color(0xFF121917);

  static const Color cardWhite = Color(0xFFFFFFFF);
  static const Color textWhite = Color(0xFFFFFFFF);
  static const Color miWhite = Color(0xffececec);
  static const Color white = Color(0xFFFFFFFF);
  static const Color actionBlue = Color(0xff267aff);
  static const Color subTextColor = Color(0xff959595);
  static const Color subLightTextColor = Color(0xffc4c4c4);

  static const Color mainBackgroundColor = miWhite;

  static const Color mainTextColor = primaryDarkValue;
  static const Color textColorWhite = white;
}

class IconUtil {
  static const String FONT_FAMILY = 'wxcIconFont';

  static const IconData HOME =
      IconData(0xe624, fontFamily: IconUtil.FONT_FAMILY);
  static const IconData MORE =
      IconData(0xe674, fontFamily: IconUtil.FONT_FAMILY);
  static const IconData SEARCH =
      IconData(0xe61c, fontFamily: IconUtil.FONT_FAMILY);

  static const IconData MAIN_DT =
      IconData(0xe684, fontFamily: IconUtil.FONT_FAMILY);
  static const IconData MAIN_QS =
      IconData(0xe818, fontFamily: IconUtil.FONT_FAMILY);
  static const IconData MAIN_MY =
      IconData(0xe6d0, fontFamily: IconUtil.FONT_FAMILY);
  static const IconData MAIN_SEARCH =
      IconData(0xe61c, fontFamily: IconUtil.FONT_FAMILY);

  static const IconData LOGIN_USER =
      IconData(0xe666, fontFamily: IconUtil.FONT_FAMILY);
  static const IconData LOGIN_PW =
      IconData(0xe60e, fontFamily: IconUtil.FONT_FAMILY);

  static const IconData REPOS_ITEM_USER =
      IconData(0xe63e, fontFamily: IconUtil.FONT_FAMILY);
  static const IconData REPOS_ITEM_STAR =
      IconData(0xe643, fontFamily: IconUtil.FONT_FAMILY);
  static const IconData REPOS_ITEM_FORK =
      IconData(0xe67e, fontFamily: IconUtil.FONT_FAMILY);
  static const IconData REPOS_ITEM_ISSUE =
      IconData(0xe661, fontFamily: IconUtil.FONT_FAMILY);

  static const IconData REPOS_ITEM_STARED =
      IconData(0xe698, fontFamily: IconUtil.FONT_FAMILY);
  static const IconData REPOS_ITEM_WATCH =
      IconData(0xe681, fontFamily: IconUtil.FONT_FAMILY);
  static const IconData REPOS_ITEM_WATCHED =
      IconData(0xe629, fontFamily: IconUtil.FONT_FAMILY);
  static const IconData REPOS_ITEM_DIR = Icons.folder;
  static const IconData REPOS_ITEM_FILE =
      IconData(0xea77, fontFamily: IconUtil.FONT_FAMILY);
  static const IconData REPOS_ITEM_NEXT =
      IconData(0xe610, fontFamily: IconUtil.FONT_FAMILY);

  static const IconData USER_ITEM_COMPANY =
      IconData(0xe63e, fontFamily: IconUtil.FONT_FAMILY);
  static const IconData USER_ITEM_LOCATION =
      IconData(0xe7e6, fontFamily: IconUtil.FONT_FAMILY);
  static const IconData USER_ITEM_LINK =
      IconData(0xe670, fontFamily: IconUtil.FONT_FAMILY);
  static const IconData USER_NOTIFY =
      IconData(0xe600, fontFamily: IconUtil.FONT_FAMILY);

  static const IconData ISSUE_ITEM_ISSUE =
      IconData(0xe661, fontFamily: IconUtil.FONT_FAMILY);
  static const IconData ISSUE_ITEM_COMMENT =
      IconData(0xe6ba, fontFamily: IconUtil.FONT_FAMILY);
  static const IconData ISSUE_ITEM_ADD =
      IconData(0xe662, fontFamily: IconUtil.FONT_FAMILY);
}
