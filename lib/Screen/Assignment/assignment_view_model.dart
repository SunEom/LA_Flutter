import 'package:flutter/material.dart';
import 'package:result_dart/result_dart.dart';
import 'package:sample_project/DI/di_controller.dart';
import 'package:sample_project/Model/assignment.dart';
import 'package:sample_project/Model/assignment_character.dart';
import 'package:sample_project/Util/number_util.dart';

class AssignmentViewModel extends ChangeNotifier {
  List<AssignmentCharacter> assignmentCharacters = [];

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  int get weeklyTotalGold => _getWeeklyTotalGold();
  int get weeklyEarnedGold => _getWeeklyEarnedGold();
  double get weeklyProgress =>
      weeklyTotalGold == 0 ? 0 : weeklyEarnedGold / weeklyTotalGold;

  AssignmentViewModel() {
    onLoad();
  }

  void onLoad() async {
    _isLoading = true;
    notifyListeners();

    await _fetchAssignmentCharacters();

    _isLoading = false;
    notifyListeners();
  }

  Future<void> _fetchAssignmentCharacters() async {
    final result = await DIController.services.assignmentService
        .fetchAssignmentCharactersWithAssignment();

    result.fold((characters) {
      assignmentCharacters = characters;

      notifyListeners();
    }, (failure) {});
  }

  void refreshData() {
    _fetchAssignmentCharacters();
  }

  String getEarnGold(AssignmentCharacter character) {
    int result = 0;
    for (Assignment a in character.assignments) {
      if (a.isCompleted) {
        result += NumberUtil.toInt(a.gold);
      }
    }

    return NumberUtil.getCommaNumber(result);
  }

  String getTotalGold(List<Assignment> assignments) {
    int result = 0;
    for (Assignment a in assignments) {
      result += NumberUtil.toInt(a.gold);
    }

    return NumberUtil.getCommaNumber(result);
  }

  void onClickCheckBox(
      AssignmentCharacter character, Assignment assignment, bool status) async {
    await DIController.services.assignmentService
        .updateAssignmentCompleteStatus(character, assignment, status);
    _fetchAssignmentCharacters();
  }

  void onClickResetCharacterAssignmentButton(
      AssignmentCharacter character) async {
    await DIController.services.assignmentService
        .resetAssignmentCompleteStatus(character);

    _fetchAssignmentCharacters();
  }

  void onClickRemoveAssignmentCharacterButton(
      AssignmentCharacter character) async {
    await DIController.services.assignmentService.removeCharacter(character);

    _fetchAssignmentCharacters();
  }

  void onClickResetAllAssignmentButton() async {
    for (AssignmentCharacter character in assignmentCharacters) {
      await DIController.services.assignmentService
          .resetAssignmentCompleteStatus(character);
    }

    _fetchAssignmentCharacters();
  }

  int _getWeeklyTotalGold() {
    int value = 0;

    for (AssignmentCharacter character in assignmentCharacters) {
      character.assignments.forEach((a) => {value += int.parse(a.gold)});
    }

    return value;
  }

  int _getWeeklyEarnedGold() {
    int value = 0;

    for (AssignmentCharacter character in assignmentCharacters) {
      character.assignments
          .forEach((a) => {if (a.isCompleted) value += int.parse(a.gold)});
    }

    return value;
  }
}
