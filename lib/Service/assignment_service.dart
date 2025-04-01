import 'package:result_dart/result_dart.dart';
import 'package:sample_project/Model/assignment.dart';
import 'package:sample_project/Model/assignment_character.dart';
import 'package:sample_project/Repository/assignment_repository.dart';

abstract interface class AssignmentServiceType {
  Future<Result<List<AssignmentCharacter>, Exception>>
      fetchAssignmentCharacters();
  Future<Result<void, Exception>> addCharacter(AssignmentCharacter character);
  Future<Result<void, Exception>> removeCharacter(
      AssignmentCharacter character);
  Future<Result<List<AssignmentCharacter>, Exception>>
      fetchAssignmentCharactersWithAssignment();

  Future<Result<List<Assignment>, Exception>> fetchAllAssignmentList(
      AssignmentCharacter character);

  Future<Result<void, Exception>> addAssignmentToCharacter(
      AssignmentCharacter character, Assignment assignment);

  Future<Result<void, Exception>> removeAssignmentToCharacter(
      AssignmentCharacter character, Assignment assignment);

  Future<Result<AssignmentCharacter, Exception>> fetchCharacterInfo(
      String nickname);

  Future<Result<List<Assignment>, Exception>> fetchCharacterAssignments(
      AssignmentCharacter character);

  Future<Result<void, Exception>> updateAssignmentCompleteStatus(
      AssignmentCharacter character, Assignment assignment, bool status);

  Future<Result<void, Exception>> resetAssignmentCompleteStatus(
      AssignmentCharacter character);

  Future<Result<void, Exception>> updateAssignmentCharacterInfo(
      {List<AssignmentCharacter>? characters});
}

class AssignmentService implements AssignmentServiceType {
  AssignmentRepository assignmentRepository = NetworkAssignmentRepository();

  @override
  Future<Result<List<AssignmentCharacter>, Exception>>
      fetchAssignmentCharacters() async {
    return assignmentRepository.fetchAssignmentCharacters();
  }

  @override
  Future<Result<void, Exception>> addCharacter(
      AssignmentCharacter character) async {
    return assignmentRepository.addCharacter(character);
  }

  @override
  Future<Result<void, Exception>> removeCharacter(
      AssignmentCharacter character) async {
    return assignmentRepository.removeCharacter(character);
  }

  @override
  Future<Result<List<AssignmentCharacter>, Exception>>
      fetchAssignmentCharactersWithAssignment() async {
    return assignmentRepository.fetchAssignmentCharactersWithAssignment();
  }

  @override
  Future<Result<List<Assignment>, Exception>> fetchAllAssignmentList(
      AssignmentCharacter character) async {
    return assignmentRepository.fetchAllAssignmentList(character);
  }

  @override
  Future<Result<void, Exception>> addAssignmentToCharacter(
      AssignmentCharacter character, Assignment assignment) {
    return assignmentRepository.addAssignmentToCharacter(character, assignment);
  }

  @override
  Future<Result<void, Exception>> removeAssignmentToCharacter(
      AssignmentCharacter character, Assignment assignment) {
    return assignmentRepository.removeAssignmentToCharacter(
        character, assignment);
  }

  @override
  Future<Result<AssignmentCharacter, Exception>> fetchCharacterInfo(
      String nickname) {
    return assignmentRepository.fetchCharacterInfo(nickname);
  }

  @override
  Future<Result<List<Assignment>, Exception>> fetchCharacterAssignments(
      AssignmentCharacter character) {
    return assignmentRepository.fetchCharacterAssignments(character);
  }

  @override
  Future<Result<void, Exception>> updateAssignmentCompleteStatus(
      AssignmentCharacter character, Assignment assignment, bool status) {
    return assignmentRepository.updateAssignmentCompleteStatus(
        character, assignment, status);
  }

  @override
  Future<Result<void, Exception>> resetAssignmentCompleteStatus(
      AssignmentCharacter character) {
    return assignmentRepository.resetAssignmentCompleteStatus(character);
  }

  @override
  Future<Result<void, Exception>> updateAssignmentCharacterInfo(
      {List<AssignmentCharacter>? characters = null}) {
    return assignmentRepository.updateAssignmentCharacterInfo(characters);
  }
}
