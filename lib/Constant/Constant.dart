import 'dart:ffi';

import 'package:flutter/material.dart';

class K {
  static AppData appData = AppData();
  static AppColor appColor = AppColor();
  static AppFont appFont = AppFont();
  static LostArkAPI lostArkAPI = LostArkAPI();
  static AppImage appImage = AppImage();
}

class AppData {
  String AppName = "Arkpedia";
}

class AppColor {
  Color mainBackgroundColor = Color.fromRGBO(21, 24, 29, 1);
  Color black = Colors.black;
  Color white = Colors.white;
  Color blue = Colors.blue;
  Color darkBlue = Colors.blue.shade800;
  Color red = Colors.red;
  Color green = Colors.green;
  Color yellow = Color.fromARGB(226, 255, 235, 59);
  Color advancedUpgradeColor = Color.fromRGBO(168, 234, 108, 1);
  Color elixirColor = Color.fromRGBO(216, 178, 2, 1);
  Color transcendenceColor = Color.fromRGBO(255, 155, 50, 1);
  Color braceletOptionColor = Color.fromRGBO(169, 208, 245, 1);
  Color gray = Colors.white12;
  Color lightGray = Colors.white60;

  Color getGradeColor(String grade) {
    switch (grade) {
      case "고급":
        return Color.fromRGBO(44, 123, 251, 1);

      case "희귀":
        return Color.fromRGBO(0, 176, 250, 1);

      case "영웅":
        return Color.fromRGBO(206, 67, 252, 1);

      case "전설":
        return Color.fromRGBO(249, 146, 0, 1);

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

class AppImage {
  String chaosGateIcon =
      "https://cdn-lostark.game.onstove.com/efui_iconatlas/achieve/achieve_13_11.png";
  String fieldBossIcon =
      "https://cdn-lostark.game.onstove.com/efui_iconatlas/achieve/achieve_14_142.png";

  String getClassImage(String className) {
    switch (className) {
      //슈샤이어
      case "워로드":
        return "https://cdn-lostark.game.onstove.com/2018/obt/assets/images/common/thumb/warlord_m.png";

      case "디스트로이어":
        return "https://cdn-lostark.game.onstove.com/2018/obt/assets/images/common/thumb/destroyer_m.png";

      case "버서커":
        return "https://cdn-lostark.game.onstove.com/2018/obt/assets/images/common/thumb/berserker_m.png";

      case "홀리나이트":
        return "https://cdn-lostark.game.onstove.com/2018/obt/assets/images/common/thumb/holyknight_m.png";

      case "슬레이어":
        return "https://cdn-lostark.game.onstove.com/2018/obt/assets/images/common/thumb/berserker_female.png";

      // 실린
      case "소서리스":
        return "https://cdn-lostark.game.onstove.com/2018/obt/assets/images/common/thumb/elemental_master_m.png";

      case "서머너":
        return "https://cdn-lostark.game.onstove.com/2018/obt/assets/images/common/thumb/summoner_m.png";

      case "바드":
        return "https://cdn-lostark.game.onstove.com/2018/obt/assets/images/common/thumb/bard_m.png";

      case "아르카나":
        return "https://cdn-lostark.game.onstove.com/2018/obt/assets/images/common/thumb/arcana_m.png";

      // 아르데타인

      case "데빌헌터":
        return "https://cdn-lostark.game.onstove.com/2018/obt/assets/images/common/thumb/devilhunter_m.png";

      case "스카우터":
        return "https://cdn-lostark.game.onstove.com/2018/obt/assets/images/common/thumb/scouter_m.png";

      case "호크아이":
        return "https://cdn-lostark.game.onstove.com/2018/obt/assets/images/common/thumb/hawk_eye.png";

      case "블래스터":
        return "https://cdn-lostark.game.onstove.com/2018/obt/assets/images/common/thumb/blaster_m.png";

      case "건슬링어":
        return "https://cdn-lostark.game.onstove.com/2018/obt/assets/images/common/thumb/gunslinger_m.png";

      // 애니츠

      case "창술사":
        return "https://cdn-lostark.game.onstove.com/2018/obt/assets/images/common/thumb/lancemaster_m.png";

      case "기공사":
        return "https://cdn-lostark.game.onstove.com/2018/obt/assets/images/common/thumb/soulmaster_m.png";

      case "인파이터":
        return "https://cdn-lostark.game.onstove.com/2018/obt/assets/images/common/thumb/infighter_m.png";

      case "배틀마스터":
        return "https://cdn-lostark.game.onstove.com/2018/obt/assets/images/common/thumb/battlemaster_m.png";

      case "브레이커":
        return "https://cdn-lostark.game.onstove.com/2018/obt/assets/images/common/thumb/infighter_male_m.png";

      case "스트라이커":
        return "https://cdn-lostark.game.onstove.com/2018/obt/assets/images/common/thumb/striker_m.png";

      //데런

      case "소울이터":
        return "https://cdn-lostark.game.onstove.com/2018/obt/assets/images/common/thumb/soul_eater.png";

      case "리퍼":
        return "https://cdn-lostark.game.onstove.com/2018/obt/assets/images/common/thumb/reaper_m.png";

      case "블레이드":
        return "https://cdn-lostark.game.onstove.com/2018/obt/assets/images/common/thumb/blade_m.png";

      case "데모닉":
        return "https://cdn-lostark.game.onstove.com/2018/obt/assets/images/common/thumb/demonic_m.png";

      // 스페셜리스트

      case "도화가":
        return "https://cdn-lostark.game.onstove.com/2018/obt/assets/images/common/thumb/yinyangshi_m.png";

      case "기상술사":
        return "https://cdn-lostark.game.onstove.com/2018/obt/assets/images/common/thumb/weather_artist_m.png";

      default:
        return "https://cdn-lostark.game.onstove.com/2018/obt/assets/images/common/icon/favicon-192.png?v=20221109160851";
    }
  }
}
