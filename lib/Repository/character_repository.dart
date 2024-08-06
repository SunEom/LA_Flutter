import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:result_dart/result_dart.dart';
import 'package:sample_project/Constant/Constant.dart';
import 'package:sample_project/Model/Character.dart';
import 'package:sample_project/Model/FavoriteCharacter.dart';
import 'package:sample_project/Model/Sibling.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

abstract interface class CharacterRepository {
  Future<Result<CharacterInfo, Exception>> fetchCharacterInfo(String nickname);
  Future<Result<ArmorySiblings, Exception>> fetchSiblings(String nickname);
  Future<Result<void, Exception>> saveFavoriteCharacter(CharacterInfo? info);
  Future<Result<FavoriteCharacter, Exception>> fetchFavoriteCharacter();
  Future<Result<void, Exception>> removeFavoriteCharacter();
}

class NetworkCharacterRepository implements CharacterRepository {
  @override
  Future<Result<CharacterInfo, Exception>> fetchCharacterInfo(
      String nickname) async {
    var url = Uri.parse('${K.lostArkAPI.base}armories/characters/$nickname');
    var client = http.Client();

    try {
      var response = await client.get(
        url,
        headers: {'Authorization': 'Bearer ${dotenv.env["API_KEY"]}'},
      );

      if (response.statusCode == 200 && response.body != "null") {
        // 성공적으로 데이터를 받음
        var characterInfo = CharacterInfo.fromJson(json.decode(response.body));
        return Result.success(characterInfo);
      } else {
        // 에러 처리
        return Result.failure(Exception("HTTP 응답 오류"));
      }
    } finally {
      client.close();
    }
  }

  @override
  Future<Result<ArmorySiblings, Exception>> fetchSiblings(
      String nickname) async {
    var url = Uri.parse('${K.lostArkAPI.base}characters/$nickname/siblings');
    var client = http.Client();

    try {
      var response = await client.get(
        url,
        headers: {'Authorization': 'Bearer ${dotenv.env["API_KEY"]}'},
      );

      if (response.statusCode == 200 && response.body != "null") {
        // 성공적으로 데이터를 받음
        var siblings = ArmorySiblings.fromJSON(json.decode(response.body));
        return Result.success(siblings);
      } else {
        // 에러 처리
        return Result.failure(Exception("HTTP 응답 오류"));
      }
    } finally {
      client.close();
    }
  }

  @override
  Future<Result<void, Exception>> saveFavoriteCharacter(CharacterInfo? info) {
    // TODO: implement saveFavoriteCharacter
    throw UnimplementedError();
  }

  @override
  Future<Result<FavoriteCharacter, Exception>> fetchFavoriteCharacter() {
    // TODO: implement fetchFavoriteCharacter
    throw UnimplementedError();
  }

  @override
  Future<Result<void, Exception>> removeFavoriteCharacter() {
    // TODO: implement removeFavoriteCharacter
    throw UnimplementedError();
  }
}

class LocalCharacterRepository implements CharacterRepository {
  @override
  Future<Result<CharacterInfo, Exception>> fetchCharacterInfo(String nickname) {
    // TODO: implement fetchCharacterInfo
    throw UnimplementedError();
  }

  @override
  Future<Result<ArmorySiblings, Exception>> fetchSiblings(String nickname) {
    // TODO: implement fetchSiblings
    throw UnimplementedError();
  }

  @override
  Future<Result<FavoriteCharacter, Exception>> fetchFavoriteCharacter() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();

    String? jsonString = pref.getString('favCharacter');
    if (jsonString != null) {
      Map<String, dynamic> json = jsonDecode(jsonString);

      return Result.success(FavoriteCharacter.fromJSON(json));
    }
    return Result.failure(Exception("Not Found Favorite User"));
  }

  @override
  Future<Result<void, Exception>> saveFavoriteCharacter(
      CharacterInfo? info) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();

    if (info == null) {
      return Result.failure(Exception("Invalid Input"));
    } else {
      FavoriteCharacter characterInfo = FavoriteCharacter(
          name: info.armoryProfile.characterName,
          itemAvgLevel: info.armoryProfile.itemAvgLevel,
          serverName: info.armoryProfile.serverName,
          className: info.armoryProfile.characterClassName);

      String jsonString = jsonEncode(characterInfo.toJson());
      await pref.setString('favCharacter', jsonString);
      return Result.success(());
    }
  }

  @override
  Future<Result<void, Exception>> removeFavoriteCharacter() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();

    await pref.remove("favCharacter");
    return Result.success(());
  }
}
