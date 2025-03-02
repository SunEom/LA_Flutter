import 'dart:math';

import 'package:flutter/material.dart';
import 'package:result_dart/result_dart.dart';
import 'package:sample_project/DI/di_controller.dart';
import 'package:sample_project/Model/character.dart';
import 'package:sample_project/Model/sibling.dart';

class AssignmentCharacterSearchViewModel extends ChangeNotifier {
  // 검색한 캐릭터의 정보
  CharacterInfo? _characterInfo;
  CharacterInfo? get characterInfo => _characterInfo;

  // 검색한 캐릭터의 원정대 캐릭터
  List<Sibling>? _siblings;
  List<Sibling>? get siblings => _siblings;

  // 검색하려는 캐릭터의 닉네임
  String _nickname = '';
  String get nickname => _nickname;

  // 숙제 기록중인 캐릭터
  List<Sibling>? _assignmentCharacters;
  List<Sibling>? get assignmentCharacters => _assignmentCharacters;

  AssignmentCharacterSearchViewModel() {
    _fetchAssignmentCharacters();
  }

  bool isAssignmentCharacter(Sibling sibling) {
    return _assignmentCharacters?.any(
            (element) => element.characterName == sibling.characterName) ??
        false;
  }

  // 숙제 기록중인 캐릭터 목록 가져오기
  Future<void> _fetchAssignmentCharacters() async {
    final result = await DIController.services.assignmentService
        .fetchAssignmentCharacters();

    result.fold((siblings) {
      _assignmentCharacters = siblings;
      notifyListeners();
    }, (failure) {});
  }

  // 캐릭터 아이템을 눌렀을 때 동작하는 함수
  Future<void> onTapCharacter(Sibling sibling) async {
    // 이미 숙제 기록중인 캐릭터인 경우
    if (isAssignmentCharacter(sibling)) {
      await DIController.services.assignmentService.removeCharacter(sibling);
    } else {
      await DIController.services.assignmentService.addCharacter(sibling);
    }

    await _fetchAssignmentCharacters();
    notifyListeners();
  }

  void searchCharacter() async {
    // 닉네임이 없으면 검색하지 않음
    if (nickname.isEmpty) {
      return;
    }

    final result = await DIController.services.characterService
        .fetchCharacterInfo(nickname);

    result.fold(
      (characterInfo) {
        _characterInfo = characterInfo.toNullable();

        // 원정대 캐릭터 검색
        searchSiblings();
        notifyListeners();
      },
      (failure) {},
    );
  }

  void searchSiblings() async {
    Result<ArmorySiblings, Exception> fetchSiblingsResult =
        await DIController.services.characterService.fetchSiblings(nickname);

    fetchSiblingsResult.fold(
      (armorySiblings) {
        // 검색한 캐릭터를 제외한 원정대 캐릭터 검색
        _siblings = armorySiblings.sibling
            .where((sibling) => sibling.characterName != nickname)
            .toList();

        notifyListeners();
      },
      (failure) {},
    );
  }

  void setNickname(String nickname) {
    _nickname = nickname;
  }
}
