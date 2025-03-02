import 'package:dartz/dartz.dart';
import 'package:result_dart/result_dart.dart';
import 'package:sample_project/Model/character.dart';
import 'package:sample_project/Model/favorite_character.dart';
import 'package:sample_project/Model/sibling.dart';
import 'package:sample_project/Repository/character_repository.dart';
import 'package:sample_project/Util/network_util.dart';

abstract interface class CharacterServiceType {
  Future<Result<Option<CharacterInfo>, Exception>> fetchCharacterInfo(
      String nickname);
  Future<Result<ArmorySiblings, Exception>> fetchSiblings(String nickname);
  Future<Result<void, Exception>> saveFavoriteCharacter(CharacterInfo? info);
  Future<Result<List<FavoriteCharacter>, Exception>> fetchFavoriteCharacter();
  Future<Result<void, Exception>> removeFavoriteCharacter(String name);
}

class CharacterService implements CharacterServiceType {
  CharacterRepository networkCharacterRepository = NetworkCharacterRepository();
  CharacterRepository localCharacterRepository = LocalCharacterRepository();

  @override
  Future<Result<Option<CharacterInfo>, Exception>> fetchCharacterInfo(
      String nickname) async {
    if (await NetworkUtil.isConnected()) {
      return networkCharacterRepository.fetchCharacterInfo(nickname);
    } else {
      return Result.failure(Exception("인터넷 연결 오류"));
    }
  }

  @override
  Future<Result<ArmorySiblings, Exception>> fetchSiblings(
      String nickname) async {
    if (await NetworkUtil.isConnected()) {
      return networkCharacterRepository.fetchSiblings(nickname);
    } else {
      return Result.failure(Exception("인터넷 연결 오류"));
    }
  }

  @override
  Future<Result<ArmorySiblings, Exception>> fetchGuildUsers(
      String nickname) async {
    if (await NetworkUtil.isConnected()) {
      return networkCharacterRepository.fetchSiblings(nickname);
    } else {
      return Result.failure(Exception("인터넷 연결 오류"));
    }
  }

  @override
  Future<Result<void, Exception>> saveFavoriteCharacter(
      CharacterInfo? info) async {
    return await networkCharacterRepository.saveFavoriteCharacter(info);
  }

  @override
  Future<Result<List<FavoriteCharacter>, Exception>>
      fetchFavoriteCharacter() async {
    return await networkCharacterRepository.fetchFavoriteCharacter();
  }

  @override
  Future<Result<void, Exception>> removeFavoriteCharacter(String name) async {
    return await networkCharacterRepository.removeFavoriteCharacter(name);
  }
}
