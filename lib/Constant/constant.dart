import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class K {
  static AppData appData = AppData();
  static AppColor appColor = AppColor();
  static AppFont appFont = AppFont();
  static LostArkAPI lostArkAPI = LostArkAPI();
  static AppImage appImage = AppImage();
  static AppConfig appConfig = AppConfig();
}

class AppData {
  String AppName = "Arkpedia";
}

class AppConfig {
  String supabaseFavoriteCharacterTable = dotenv.env['SB_FAV_CHARACTER_TABLE']!;
}

class AppColor {
  Color mainBackgroundColor = const Color.fromRGBO(21, 24, 29, 1);
  Color black = Colors.black;
  Color white = Colors.white;
  Color blue = Colors.blue;
  Color darkBlue = Colors.blue.shade800;
  Color red = Colors.red;
  Color green = Colors.green;
  Color yellow = const Color.fromARGB(226, 255, 235, 59);
  Color advancedUpgradeColor = const Color.fromRGBO(168, 234, 108, 1);
  Color elixirColor = const Color.fromRGBO(216, 178, 2, 1);
  Color transcendenceColor = const Color.fromRGBO(255, 155, 50, 1);
  Color braceletOptionColor = const Color.fromRGBO(169, 208, 245, 1);
  Color gray = Colors.white12;
  Color lightGray = Colors.white60;

  Color getGradeColor(String grade) {
    switch (grade) {
      case "고급":
        return const Color.fromRGBO(44, 123, 251, 1);

      case "희귀":
        return const Color.fromRGBO(0, 176, 250, 1);

      case "영웅":
        return const Color.fromRGBO(206, 67, 252, 1);

      case "전설":
        return const Color.fromRGBO(249, 146, 0, 1);

      case "유물":
        return const Color.fromRGBO(250, 93, 0, 1);

      case "고대":
        return const Color.fromRGBO(227, 199, 161, 1);

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

  String arkPassiveIcon =
      "https://cdn-lostark.game.onstove.com/2018/obt/assets/images/common/game/ico_arkpassive.png";

  final SupabaseClient supabase = Supabase.instance.client;
  static final Map<String, String> _classImageCache = {};

  // 기본 이미지 URL을 상수로 정의

  Future<String> getClassImage(String className) async {
    // 캐시 확인
    if (_classImageCache.containsKey(className)) {
      return _classImageCache[className]!;
    }

    try {
      final response = await supabase
          .from('class_image')
          .select('url')
          .eq('class', className)
          .limit(1);

      if (response.isEmpty) {
        // 기본 이미지 캐시 확인
        if (_classImageCache.containsKey('기본')) {
          return _classImageCache['기본']!;
        }
        final defaultUrl = await supabase
            .from('class_image')
            .select('url')
            .eq('class', '기본')
            .single();

        final imageUrl = defaultUrl['url'] as String;
        _classImageCache['기본'] = imageUrl;
        return imageUrl;
      } else {
        final imageUrl = response.first['url'] as String;
        _classImageCache[className] = imageUrl;
        return imageUrl;
      }
    } catch (e) {
      return '';
    }
  }

  // 캐시 초기화 메서드
  void clearClassImageCache() {
    _classImageCache.clear();
  }
}
