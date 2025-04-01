import 'package:sample_project/Model/assignment.dart';

class AssignmentCharacter {
  String serverName;
  String characterName;
  int characterLevel;
  String characterClassName;
  String itemAvgLevel;
  String itemMaxLevel;

  List<Assignment> assignments;

  AssignmentCharacter({
    required this.serverName,
    required this.characterName,
    required this.characterLevel,
    required this.characterClassName,
    required this.itemAvgLevel,
    required this.itemMaxLevel,
    required this.assignments,
  });

  factory AssignmentCharacter.fromJson(Map<String, dynamic> json) {
    return AssignmentCharacter(
        serverName: json['ServerName'],
        characterName: json['CharacterName'],
        characterLevel: json['CharacterLevel'],
        characterClassName: json['CharacterClassName'],
        itemAvgLevel: json['ItemAvgLevel'],
        itemMaxLevel: json['ItemMaxLevel'],
        assignments:
            json['Assignments']?.map((e) => Assignment.fromJson(e)).toList() ??
                []);
  }
}
