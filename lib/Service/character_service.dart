import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

import 'package:sample_project/Constant/Constant.dart';
import 'package:sample_project/Model/Character.dart';
import 'package:sample_project/Model/FavoriteCharacter.dart';
import 'package:sample_project/Model/Sibling.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract interface class CharacterServiceType {
  Future<CharacterInfo?> fetchCharacterInfo(String nickname);
  Future<ArmorySiblings?> fetchSiblings(String nickname);
  Future<bool> saveFavoriteCharacter(CharacterInfo? info);
  Future<FavoriteCharacter?> fetchFavoriteCharacter();
  Future<void> removeFavoriteCharacter();
}

class CharacterService implements CharacterServiceType {
  @override
  Future<CharacterInfo?> fetchCharacterInfo(String nickname) async {
    var url = Uri.parse('${K.lostArkAPI.base}armories/characters/${nickname}');
    var client = http.Client();

    try {
      var response = await client.get(
        url,
        headers: {'Authorization': 'Bearer ${dotenv.env["API_KEY"]}'},
      );

      if (response.statusCode == 200 && response.body != "null") {
        // 성공적으로 데이터를 받음
        var characterInfo = CharacterInfo.fromJson(json.decode(response.body));
        return characterInfo;
      } else {
        // 에러 처리
        return null;
      }
    } finally {
      client.close();
    }
  }

  @override
  Future<ArmorySiblings?> fetchSiblings(String nickname) async {
    var url = Uri.parse('${K.lostArkAPI.base}characters/${nickname}/siblings');
    var client = http.Client();

    try {
      var response = await client.get(
        url,
        headers: {'Authorization': 'Bearer ${dotenv.env["API_KEY"]}'},
      );

      if (response.statusCode == 200 && response.body != "null") {
        // 성공적으로 데이터를 받음
        var siblings = ArmorySiblings.fromJSON(json.decode(response.body));
        return siblings;
      } else {
        // 에러 처리
        return null;
      }
    } finally {
      client.close();
    }
  }

  @override
  Future<bool> saveFavoriteCharacter(CharacterInfo? info) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();

    if (info == null) {
      return false;
    } else {
      FavoriteCharacter characterInfo = FavoriteCharacter(
          name: info.armoryProfile.characterName,
          itemAvgLevel: info.armoryProfile.itemAvgLevel,
          serverName: info.armoryProfile.serverName,
          className: info.armoryProfile.characterClassName);

      String jsonString = jsonEncode(characterInfo.toJson());
      await pref.setString('favCharacter', jsonString);
      return true;
    }
  }

  @override
  Future<FavoriteCharacter?> fetchFavoriteCharacter() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();

    String? jsonString = pref.getString('favCharacter');
    if (jsonString != null) {
      Map<String, dynamic> json = jsonDecode(jsonString);
      return FavoriteCharacter.fromJSON(json);
    }
    return null;
  }

  @override
  Future<void> removeFavoriteCharacter() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();

    await pref.remove("favCharacter");
  }
}
