import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:result_dart/result_dart.dart';
import 'package:sample_project/Constant/constant.dart';
import 'package:sample_project/Model/character.dart';
import 'package:sample_project/Model/favorite_character.dart';
import 'package:sample_project/Model/sibling.dart';
import 'package:http/http.dart' as http;
import 'package:sample_project/Model/user_data.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class CharacterRepository {
  Future<Result<Option<CharacterInfo>, Exception>> fetchCharacterInfo(
      String nickname);
  Future<Result<ArmorySiblings, Exception>> fetchSiblings(String nickname);
  Future<Result<void, Exception>> saveFavoriteCharacter(CharacterInfo? info);
  Future<Result<List<FavoriteCharacter>, Exception>> fetchFavoriteCharacter();
  Future<Result<void, Exception>> removeFavoriteCharacter(String name);
}

class NetworkCharacterRepository implements CharacterRepository {
  final SupabaseClient supabase = Supabase.instance.client;

  @override
  Future<Result<Option<CharacterInfo>, Exception>> fetchCharacterInfo(
      String nickname) async {
    var url = Uri.parse('${K.lostArkAPI.base}armories/characters/$nickname');
    var client = http.Client();

    try {
      var response = await client.get(
        url,
        headers: {'Authorization': 'Bearer ${dotenv.env["API_KEY"]}'},
      );

      if (response.statusCode == 200) {
        if (response.body == "null") {
          // 성공적으로 데이터를 받았으나 해당 유저의 정보가 없는 경우
          return const Result.success(None());
        }
        // 성공적으로 데이터를 받음
        var characterInfo = CharacterInfo.fromJson(json.decode(response.body));
        return Result.success(Some(characterInfo));
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
  Future<Result<void, Exception>> saveFavoriteCharacter(
      CharacterInfo? info) async {
    var userData = await UserData.instance;

    // 이미 존재하는 캐릭터인지 확인
    var result = await supabase
        .from(K.appConfig.supabaseFavoriteCharacterTable)
        .select('*')
        .eq('uuid', userData.uuid);

    if (result.length > 5) {
      return Result.failure(Exception("최대 5개의 캐릭터만 저장할 수 있습니다."));
    }

    // 존재하는 경우 스킵
    if (result.any(
        (element) => element['name'] == info?.armoryProfile.characterName)) {
      return const Result.success(());
    } else {
      // 존재하지 않는 경우 생성
      if (info != null) {
        // 캐릭터 정보가 있는 경우 생성
        await supabase.from(K.appConfig.supabaseFavoriteCharacterTable).insert({
          'name': info.armoryProfile.characterName,
          'serverName': info.armoryProfile.serverName,
          'className': info.armoryProfile.characterClassName,
          'itemAvgLevel': info.armoryProfile.itemAvgLevel,
          'uuid': userData.uuid,
        });
      }

      return const Result.success(());
    }
  }

  @override
  Future<Result<List<FavoriteCharacter>, Exception>>
      fetchFavoriteCharacter() async {
    var userData = await UserData.instance;

    var result = await supabase
        .from(K.appConfig.supabaseFavoriteCharacterTable)
        .select('*')
        .eq('uuid', userData.uuid)
        .order('created_at', ascending: true);

    if (result.isNotEmpty) {
      return Result.success(
          result.map((e) => FavoriteCharacter.fromJSON(e)).toList());
    } else {
      return const Result.success([]);
    }
  }

  @override
  Future<Result<void, Exception>> removeFavoriteCharacter(String name) async {
    var userData = await UserData.instance;

    await supabase
        .from(K.appConfig.supabaseFavoriteCharacterTable)
        .delete()
        .eq('name', name)
        .eq('uuid', userData.uuid);

    return const Result.success(());
  }
}

class LocalCharacterRepository implements CharacterRepository {
  @override
  Future<Result<Option<CharacterInfo>, Exception>> fetchCharacterInfo(
      String nickname) {
    // TODO: implement fetchCharacterInfo
    throw UnimplementedError();
  }

  @override
  Future<Result<ArmorySiblings, Exception>> fetchSiblings(String nickname) {
    // TODO: implement fetchSiblings
    throw UnimplementedError();
  }

  @override
  Future<Result<List<FavoriteCharacter>, Exception>>
      fetchFavoriteCharacter() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();

    String? jsonString = pref.getString('favCharacter');
    if (jsonString != null) {
      Map<String, dynamic> json = jsonDecode(jsonString);

      return Result.success([FavoriteCharacter.fromJSON(json)]);
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
      return const Result.success(());
    }
  }

  @override
  Future<Result<void, Exception>> removeFavoriteCharacter(String name) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();

    await pref.remove("favCharacter");
    return Result.success(());
  }
}
