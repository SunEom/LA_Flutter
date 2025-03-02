import 'package:result_dart/result_dart.dart';
import 'package:sample_project/Model/sibling.dart';
import 'package:sample_project/Repository/assignment_repository.dart';

abstract interface class AssignmentServiceType {
  Future<Result<List<Sibling>, Exception>> fetchAssignmentCharacters();
  Future<Result<void, Exception>> addCharacter(Sibling sibling);
  Future<Result<void, Exception>> removeCharacter(Sibling sibling);
}

class AssignmentService implements AssignmentServiceType {
  AssignmentRepository assignmentRepository = NetworkAssignmentRepository();

  @override
  Future<Result<List<Sibling>, Exception>> fetchAssignmentCharacters() async {
    return assignmentRepository.fetchAssignmentCharacters();
  }

  @override
  Future<Result<void, Exception>> addCharacter(Sibling sibling) async {
    return assignmentRepository.addCharacter(sibling);
  }

  @override
  Future<Result<void, Exception>> removeCharacter(Sibling sibling) async {
    return assignmentRepository.removeCharacter(sibling);
  }
}
