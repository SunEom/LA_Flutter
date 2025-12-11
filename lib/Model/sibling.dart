import 'package:sample_project/Model/assignment.dart';
import 'package:sample_project/Model/assignment_character.dart';

class ArmorySiblings {
  final List<Sibling> sibling;

  Map<String, List<Sibling>> get siblingPerServer {
    Map<String, List<Sibling>> temp = Map<String, List<Sibling>>();
    sibling.forEach((s) {
      if (temp[s.serverName] == null) {
        temp[s.serverName] = [s];
      } else {
        temp[s.serverName]!.add(s);
      }
    });
    return temp;
  }

  List<String> get serverList {
    List<String> li = siblingPerServer.keys.toList();
    li.sort((s1, s2) =>
        siblingPerServer[s2]!.length.compareTo(siblingPerServer[s1]!.length));
    return li;
  }

  const ArmorySiblings({required this.sibling});

  factory ArmorySiblings.fromJSON(List<dynamic>? li) {
    if (li == null || li!.isEmpty) {
      return ArmorySiblings(sibling: []);
    }

    List<Sibling> siblingList = li.map((s) => Sibling.fromJSON(s)).toList();
    siblingList.sort((s1, s2) =>
        double.parse(s2.itemAvgLevel.replaceAll(",", ""))
            .compareTo(double.parse(s1.itemAvgLevel.replaceAll(",", ""))));
    return ArmorySiblings(sibling: siblingList);
  }
}

class Sibling {
  final String serverName;
  final String characterName;
  final int characterLevel;
  final String characterClassName;
  final String itemAvgLevel;
  final String itemMaxLevel;

  const Sibling(
      {required this.serverName,
      required this.characterName,
      required this.characterLevel,
      required this.characterClassName,
      required this.itemAvgLevel,
      required this.itemMaxLevel});

  factory Sibling.fromJSON(Map<String, dynamic> json) {
    return Sibling(
        serverName: json["ServerName"],
        characterName: json["CharacterName"],
        characterLevel: json["CharacterLevel"],
        characterClassName: json['CharacterClassName'],
        itemAvgLevel: json["ItemAvgLevel"],
        itemMaxLevel: json["ItemMaxLevel"] ?? '');
  }

  AssignmentCharacter toAssignmentCharacter(
      {List<Assignment> assignments = const []}) {
    return AssignmentCharacter(
        serverName: serverName,
        characterName: characterName,
        characterLevel: characterLevel,
        characterClassName: characterClassName,
        itemAvgLevel: itemAvgLevel,
        itemMaxLevel: itemMaxLevel,
        assignments: assignments);
  }
}
