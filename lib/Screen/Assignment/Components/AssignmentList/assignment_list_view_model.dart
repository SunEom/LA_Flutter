import 'package:flutter/material.dart';
import 'package:result_dart/result_dart.dart';
import 'package:sample_project/DI/di_controller.dart';
import 'package:sample_project/Model/assignment.dart';
import 'package:sample_project/Model/assignment_character.dart';

class AssignmentListViewModel extends ChangeNotifier {
  AssignmentCharacter character;

  List<Assignment> _assignments = [];
  List<Assignment> get assignments => _assignments;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  AssignmentListViewModel(this.character) {
    onLoad();
  }

  void onLoad() async {
    _isLoading = true;
    notifyListeners();

    await _fetchCharacterInfo();
    await fetchAsssignmentList();
    await _retrieveAssignmentList();

    _isLoading = false;
    notifyListeners();
  }

  Future<void> _fetchCharacterInfo() async {
    Result<AssignmentCharacter, Exception> fetchCharacterInfo =
        await DIController.services.assignmentService
            .fetchCharacterInfo(character.characterName);

    fetchCharacterInfo.fold((c) {
      this.character = c;
      notifyListeners();
    }, (e) {});
  }

  //현재 캐릭터가 갈 수 있는 숙제 목록 조회
  Future<void> fetchAsssignmentList() async {
    Result<List<Assignment>, Exception> fetchAssignmentList = await DIController
        .services.assignmentService
        .fetchAllAssignmentList(character);

    fetchAssignmentList.fold((list) {
      this._assignments = list;
      notifyListeners();
    }, (e) {});
  }

  // 현재 캐릭터에 등록된 숙제 목록 조회
  Future<void> _retrieveAssignmentList() async {
    Result<List<Assignment>, Exception> fetchAssignments = await DIController
        .services.assignmentService
        .fetchCharacterAssignments(character);

    fetchAssignments.fold((assignments) {
      print(assignments);
      character.assignments = assignments;
      notifyListeners();
    }, (e) {});
  }

  void onClickCheckBox(bool newValue, Assignment assignment) async {
    if (newValue == true) {
      await DIController.services.assignmentService
          .addAssignmentToCharacter(character, assignment);
    } else {
      await DIController.services.assignmentService
          .removeAssignmentToCharacter(character, assignment);
    }

    // 등록된 숙제 정보 갱신
    await _retrieveAssignmentList();
  }

  bool isContainCurrentAssignmentList(Assignment assignment) {
    for (Assignment a in character.assignments) {
      if (a.id == assignment.id) {
        return true;
      }
    }
    return false;
  }
}
