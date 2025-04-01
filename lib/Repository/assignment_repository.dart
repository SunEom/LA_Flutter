import 'package:result_dart/result_dart.dart';
import 'package:sample_project/Constant/constant.dart';
import 'package:sample_project/Model/assignment.dart';
import 'package:sample_project/Model/assignment_character.dart';
import 'package:sample_project/Model/character.dart';
import 'package:sample_project/Model/user_data.dart';
import 'package:sample_project/Repository/character_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class AssignmentRepository {
  // 등록한 숙제 캐릭터 정보 가져오기
  Future<Result<List<AssignmentCharacter>, Exception>>
      fetchAssignmentCharacters();

  // 숙제 캐릭터 등록
  Future<Result<void, Exception>> addCharacter(AssignmentCharacter character);

  // 숙제 캐릭터에서 삭제
  Future<Result<void, Exception>> removeCharacter(
      AssignmentCharacter character);

  // 해당 닉네임의 캐릭터 정보를 가져온다.
  Future<Result<AssignmentCharacter, Exception>> fetchCharacterInfo(
      String nickname);

  // 등록한 숙제 캐릭터 및 숙제 정보 가져오기
  Future<Result<List<AssignmentCharacter>, Exception>>
      fetchAssignmentCharactersWithAssignment();

  // 해당 캐릭터에 _등록된_ 모든 숙제 목록을 가져온다.
  Future<Result<List<Assignment>, Exception>> fetchCharacterAssignments(
      AssignmentCharacter character);

  // 해당 캐릭터가 _할 수 있는_ 모든 숙제 목록을 가져온다.
  Future<Result<List<Assignment>, Exception>> fetchAllAssignmentList(
      AssignmentCharacter character);

  // 해당 캐릭터의 숙제 등록
  Future<Result<void, Exception>> addAssignmentToCharacter(
      AssignmentCharacter character, Assignment assignment);

  // 해당 캐릭터의 숙제 삭제
  Future<Result<void, Exception>> removeAssignmentToCharacter(
      AssignmentCharacter character, Assignment assignment);

  // 숙제 상태 업데이트
  Future<Result<void, Exception>> updateAssignmentCompleteStatus(
      AssignmentCharacter character, Assignment assignment, bool status);

  // 숙제 상태 초기화 (모두 false)
  Future<Result<void, Exception>> resetAssignmentCompleteStatus(
      AssignmentCharacter character);

  // 숙제 캐릭터 정보 업데이트
  Future<Result<void, Exception>> updateAssignmentCharacterInfo(
      List<AssignmentCharacter>? characters);
}

class NetworkAssignmentRepository extends AssignmentRepository {
  final supabase = Supabase.instance.client;
  final assignmentTable = K.appConfig.supabaseAssignmentTable;
  final assignmentCharacterTable = K.appConfig.supabaseAssignmentCharacterTable;
  final assignmentItemTable = K.appConfig.supabaseAssignmentItemTable;

  @override
  Future<Result<List<AssignmentCharacter>, Exception>>
      fetchAssignmentCharacters() async {
    try {
      final user = await UserData.instance;

      final result = await supabase
          .from(assignmentCharacterTable)
          .select('*')
          .eq('uuid', user.uuid)
          .order("created_at");

      final siblings =
          result.map((e) => AssignmentCharacter.fromJson(e)).toList();

      return Success(siblings);
    } catch (e) {
      return Failure(Exception(e));
    }
  }

  @override
  Future<Result<void, Exception>> addCharacter(
      AssignmentCharacter character) async {
    try {
      final user = await UserData.instance;

      final characterList = await supabase
          .from('assignment_character')
          .select('*')
          .eq('uuid', user.uuid)
          .eq('CharacterName', character.characterName);

      // 해당 캐릭터가 이미 존재하는지 확인
      if (characterList.isNotEmpty) {
        return Failure(Exception('이미 존재하는 캐릭터입니다.'));
      }

      //최대 15개의 캐릭터만 추가 가능
      if (characterList.length >= 15) {
        return Failure(Exception('최대 15개의 캐릭터만 추가 가능합니다.'));
      }

      // 캐릭터 추가
      await supabase.from(assignmentCharacterTable).insert({
        'uuid': user.uuid,
        'CharacterName': character.characterName,
        'ServerName': character.serverName,
        'CharacterLevel': character.characterLevel,
        'ItemAvgLevel': character.itemAvgLevel,
        'CharacterClassName': character.characterClassName,
        'ItemMaxLevel': character.itemMaxLevel,
      });

      return Success(());
    } catch (e) {
      return Failure(Exception(e));
    }
  }

  @override
  Future<Result<void, Exception>> removeCharacter(
      AssignmentCharacter character) async {
    try {
      final user = await UserData.instance;

      // 해당 캐릭터에 대한 숙제목록 삭제
      await supabase
          .from(assignmentItemTable)
          .delete()
          .eq('uuid', user.uuid)
          .eq('CharacterName', character.characterName);

      // 해당 캐릭터 삭제
      await supabase
          .from(assignmentCharacterTable)
          .delete()
          .eq('uuid', user.uuid)
          .eq('CharacterName', character.characterName);

      return Success(());
    } catch (e) {
      return Failure(Exception(e));
    }
  }

  @override
  Future<Result<AssignmentCharacter, Exception>> fetchCharacterInfo(
      String nickname) async {
    try {
      final user = await UserData.instance;

      final result = await supabase
          .from(assignmentCharacterTable)
          .select("*")
          .eq('uuid', user.uuid)
          .eq("CharacterName", nickname);

      return Success(AssignmentCharacter.fromJson(result.first));
    } catch (e) {
      return Failure(Exception(e));
    }
  }

  @override
  Future<Result<List<AssignmentCharacter>, Exception>>
      fetchAssignmentCharactersWithAssignment() async {
    try {
      final user = await UserData.instance;

      // 숙제 캐릭터 목록 조회
      final characters = await supabase
          .from(assignmentCharacterTable)
          .select('*')
          .eq('uuid', user.uuid)
          .order("created_at", ascending: true);

      List<AssignmentCharacter> assignmentCharacters =
          characters.map((e) => AssignmentCharacter.fromJson(e)).toList();

      // 숙제 아이템 목록 조회
      final assignments = await supabase
          .from(assignmentItemTable)
          .select('*, ' +
              assignmentTable +
              '(id, Title, Gold, Level, Stage, Difficulty)')
          .eq('uuid', user.uuid)
          .order(assignmentTable + "(Level)", ascending: false)
          .order(assignmentTable + "(id)", ascending: false);

      //숙제 아이템 조인
      assignments.forEach((assignmentData) {
        String characterName = assignmentData['CharacterName'];
        Map<String, dynamic> _assignmentData = assignmentData['assignment'];
        _assignmentData['CompleteYn'] =
            assignmentData['CompleteYn']; // 숙제 완료 여부 추가
        Assignment assignment = Assignment.fromJson(_assignmentData);

        assignmentCharacters
            .firstWhere((character) => character.characterName == characterName)
            .assignments
            .add(assignment);
      });

      return Success(assignmentCharacters);
    } catch (e) {
      return Failure(Exception(e));
    }
  }

  @override
  Future<Result<List<Assignment>, Exception>> fetchAllAssignmentList(
      AssignmentCharacter character) async {
    try {
      final fetchData = await supabase
          .from(assignmentTable)
          .select("*")
          .lte(
              "Level",
              int.parse(
                  character.itemMaxLevel.split(".")[0].replaceAll(",", "")))
          .order("Level", ascending: false)
          .order("id", ascending: false);

      List<Assignment> assingmentList =
          fetchData.map((e) => Assignment.fromJson(e)).toList();

      return Success(assingmentList);
    } catch (e) {
      return Failure(Exception(e));
    }
  }

  @override
  Future<Result<void, Exception>> addAssignmentToCharacter(
      AssignmentCharacter character, Assignment assignment) async {
    try {
      final user = await UserData.instance;

      // 중복 확인 이미 존재하는 경우 추가하지 않음.
      final dupCheck = await supabase
          .from(assignmentItemTable)
          .select("*")
          .eq('uuid', user.uuid)
          .eq("CharacterName", character.characterName)
          .eq("AssignmentId", assignment.id);

      if (dupCheck.isNotEmpty) {
        return Failure(Exception("이미 추가되어있는 레이드입니다."));
      }

      // 숙제 추가
      await supabase.from(assignmentItemTable).insert({
        "uuid": user.uuid,
        "CharacterName": character.characterName,
        "AssignmentId": assignment.id,
        "CompleteYn": "0"
      });

      return const Success(());
    } catch (e) {
      return Failure(Exception(e));
    }
  }

  @override
  Future<Result<void, Exception>> removeAssignmentToCharacter(
      AssignmentCharacter character, Assignment assignment) async {
    try {
      final user = await UserData.instance;

      // 숙제 삭제
      await supabase
          .from(assignmentItemTable)
          .delete()
          .eq("uuid", user.uuid)
          .eq("CharacterName", character.characterName)
          .eq("AssignmentId", assignment.id);

      return const Success(());
    } catch (e) {
      return Failure(Exception(e));
    }
  }

  @override
  Future<Result<List<Assignment>, Exception>> fetchCharacterAssignments(
      AssignmentCharacter character) async {
    try {
      final user = await UserData.instance;

      final assignments = await supabase
          .from(assignmentItemTable)
          .select('*, ' +
              assignmentTable +
              '(id, Title, Gold, Level, Stage, Difficulty)')
          .eq('uuid', user.uuid)
          .eq("CharacterName", character.characterName)
          .order(assignmentTable + "(Level)", ascending: false)
          .order(assignmentTable + "(id)", ascending: false);

      List<Assignment> assignmentList = [];
      assignments.forEach((assignmentData) {
        Map<String, dynamic> _assignmentData = assignmentData['assignment'];
        _assignmentData['CompleteYn'] =
            assignmentData['CompleteYn']; // 숙제 완료 여부 추가
        Assignment assignment = Assignment.fromJson(_assignmentData);
        assignmentList.add(assignment);
      });

      return Success(assignmentList);
    } catch (e) {
      return Failure(Exception(e));
    }
  }

  @override
  Future<Result<void, Exception>> updateAssignmentCompleteStatus(
      AssignmentCharacter character, Assignment assignment, bool status) async {
    try {
      final user = await UserData.instance;

      await supabase
          .from(assignmentItemTable)
          .update({"CompleteYn": status ? 1 : 0})
          .eq("uuid", user.uuid)
          .eq("CharacterName", character.characterName)
          .eq("AssignmentId", assignment.id);

      return Success(());
    } catch (e) {
      return Failure(Exception(e));
    }
  }

  @override
  Future<Result<void, Exception>> resetAssignmentCompleteStatus(
      AssignmentCharacter character) async {
    try {
      final user = await UserData.instance;

      await supabase
          .from(assignmentItemTable)
          .update({"CompleteYn": 0})
          .eq("uuid", user.uuid)
          .eq("CharacterName", character.characterName);

      return Success(());
    } catch (e) {
      return Failure(Exception(e));
    }
  }

  @override
  Future<Result<void, Exception>> updateAssignmentCharacterInfo(
      List<AssignmentCharacter>? characters) async {
    try {
      final user = await UserData.instance;
      final characterRepo = NetworkCharacterRepository();

      List<AssignmentCharacter>? assignmentCharacters = characters;

      if (characters == null) {
        var result = await supabase
            .from(assignmentCharacterTable)
            .select("*")
            .eq('uuid', user.uuid);

        assignmentCharacters =
            result.map((e) => AssignmentCharacter.fromJson(e)).toList();
      }

      assignmentCharacters ??= [];
      for (AssignmentCharacter c in assignmentCharacters) {
        var r = await characterRepo.fetchCharacterInfo(c.characterName);

        r.fold((data) async {
          CharacterInfo? info = data.toNullable();
          if (info != null) {
            await supabase.from(assignmentCharacterTable).update({
              'ServerName': info.armoryProfile.serverName,
              "CharacterLevel": info.armoryProfile.characterLevel,
              "CharacterClassName": info.armoryProfile.characterClassName,
              "ItemAvgLevel": info.armoryProfile.itemAvgLevel,
              "ItemMaxLevel": info.armoryProfile.itemMaxLevel
            }).eq('CharacterName', info.armoryProfile.characterName);
          }
        }, (e) {});
      }

      return Success(());
    } catch (e) {
      return Failure(Exception(e));
    }
  }
}
