import 'package:result_dart/result_dart.dart';
import 'package:sample_project/Model/sibling.dart';
import 'package:sample_project/Model/user_data.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class AssignmentRepository {
  Future<Result<List<Sibling>, Exception>> fetchAssignmentCharacters();
  Future<Result<void, Exception>> addCharacter(Sibling sibling);
  Future<Result<void, Exception>> removeCharacter(Sibling sibling);
}

class NetworkAssignmentRepository extends AssignmentRepository {
  final supabase = Supabase.instance.client;

  @override
  Future<Result<List<Sibling>, Exception>> fetchAssignmentCharacters() async {
    try {
      final user = await UserData.instance;

      final result = await supabase
          .from('assignment_character')
          .select('*')
          .eq('uuid', user.uuid);

      final siblings = result.map((e) => Sibling.fromJSON(e)).toList();

      return Success(siblings);
    } catch (e) {
      return Failure(Exception(e));
    }
  }

  @override
  Future<Result<void, Exception>> addCharacter(Sibling sibling) async {
    try {
      final user = await UserData.instance;

      final character = await supabase
          .from('assignment_character')
          .select('*')
          .eq('uuid', user.uuid)
          .eq('CharacterName', sibling.characterName);

      // 해당 캐릭터가 이미 존재하는지 확인
      if (character.isNotEmpty) {
        return Failure(Exception('이미 존재하는 캐릭터입니다.'));
      }

      //최대 15개의 캐릭터만 추가 가능
      if (character.length >= 15) {
        return Failure(Exception('최대 15개의 캐릭터만 추가 가능합니다.'));
      }

      // 캐릭터 추가
      await supabase.from('assignment_character').insert({
        'uuid': user.uuid,
        'CharacterName': sibling.characterName,
        'ServerName': sibling.serverName,
        'CharacterLevel': sibling.characterLevel,
        'ItemAvgLevel': sibling.itemAvgLevel,
        'CharacterClassName': sibling.characterClassName,
        'ItemMaxLevel': sibling.itemMaxLevel,
      });

      return Success(());
    } catch (e) {
      return Failure(Exception(e));
    }
  }

  @override
  Future<Result<void, Exception>> removeCharacter(Sibling sibling) async {
    try {
      final user = await UserData.instance;

      // 해당 캐릭터 삭제
      final result = await supabase
          .from('assignment_character')
          .delete()
          .eq('uuid', user.uuid)
          .eq('CharacterName', sibling.characterName);

      return Success(());
    } catch (e) {
      return Failure(Exception(e));
    }
  }
}
