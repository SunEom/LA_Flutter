import 'package:flutter/material.dart';

class K {
  static AppData appData = AppData();
  static AppColor appColor = AppColor();
  static AppFont appFont = AppFont();
  static LostArkAPI lostArkAPI = LostArkAPI();
}

class AppData {
  String AppName = "Something";
}

class AppColor {
  Color mainBackgroundColor = Color.fromRGBO(21, 24, 29, 1);
  Color black = Colors.black;
  Color white = Colors.white;
  Color blue = Colors.blue;
  Color red = Colors.red;
  Color advancedUpgradeColor = Color.fromRGBO(168, 234, 108, 1);
  Color elixirColor = Color.fromRGBO(216, 178, 2, 1);
  Color transcendenceColor = Color.fromRGBO(255, 155, 50, 1);
  Color braceletOptionColor = Color.fromRGBO(169, 208, 245, 1);
  Color gray = Colors.white12;
  Color lightGray = Colors.white60;

  Color getGradeColor(String grade) {
    switch (grade) {
      case "희귀":
        return Color.fromRGBO(44, 123, 251, 1);

      case "영웅":
        return Color.fromRGBO(247, 51, 255, 1);

      case "전설":
        return Color.fromRGBO(206, 152, 0, 1);

      case "유물":
        return Color.fromRGBO(250, 93, 0, 1);

      case "고대":
        return Color.fromRGBO(227, 199, 161, 1);

      default:
        return Colors.white60;
    }
  }
}

class AppFont {
  FontWeight get bold => FontWeight.w500;
  FontWeight get heavy => FontWeight.w700;
  FontWeight get superHeavy => FontWeight.w900;
}

class LostArkAPI {
  String base = "https://developer-lostark.game.onstove.com/";
  String transcendenceImage =
      "https://cdn-lostark.game.onstove.com/2018/obt/assets/images/common/game/ico_tooltip_transcendence.png";
}
