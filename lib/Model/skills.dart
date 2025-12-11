import 'package:flutter/material.dart';
import 'package:sample_project/Constant/Constant.dart';

class ArmorySkills {
  final List<Skill> skills;

  ArmorySkills({required this.skills});

  factory ArmorySkills.fromJSON(Map<String, dynamic> json) {
    int sortSkillList(Skill s1, Skill s2) {
      if (s1.level != s2.level) {
        return s1.level > s2.level ? 0 : 1;
      } else if (s1.tripods.isEmpty && s2.tripods.isNotEmpty) {
        return 1;
      } else if (s1.tripods.isNotEmpty && s2.tripods.isEmpty) {
        return 0;
      } else if (s1.rune == null && s2.rune != null) {
        return 1;
      } else if (s1.rune != null && s2.rune == null) {
        return 0;
      } else {
        return 0;
      }
    }

    List<Skill> skillList =
        (json["ArmorySkills"] as List).map((e) => Skill.fromJSON(e)).toList();

    skillList.sort(sortSkillList);

    return ArmorySkills(skills: skillList);
  }

  Map<String, dynamic> toJson() {
    return {"skills": skills};
  }
}

class Skill {
  final String name;
  final String icon;
  final int level;
  final List<Tripod> tripods;
  final Rune? rune;

  List<Tripod> get usedTripod {
    List<Tripod> list = tripods.where((t) => t.isSelected).toList();
    list.sort((t1, t2) => t1.tier.compareTo(t2.tier));
    return list;
  }

  Skill(
      {required this.name,
      required this.icon,
      required this.level,
      required this.tripods,
      this.rune});

  factory Skill.fromJSON(Map<String, dynamic> json) {
    return Skill(
        name: json["Name"],
        icon: json["Icon"],
        level: json["Level"],
        tripods:
            (json["Tripods"] as List).map((t) => Tripod.fromJSON(t)).toList(),
        rune: json["Rune"] == null ? null : Rune.fromJSON(json["Rune"]));
  }

  Map<String, dynamic> toJson() {
    return {"name": name, "icon": icon, "level": level};
  }
}

class Tripod {
  final int tier;
  final int slot;
  final String name;
  final String icon;
  final int? level;
  final bool isSelected;

  Tripod(
      {required this.tier,
      required this.slot,
      required this.name,
      required this.icon,
      required this.level,
      required this.isSelected});

  factory Tripod.fromJSON(Map<String, dynamic> json) {
    return Tripod(
        tier: json["Tier"],
        slot: json["Slot"],
        name: json["Name"],
        icon: json["Icon"],
        level: json["Level"] ?? 0,
        isSelected: json["IsSelected"]);
  }

  Map<String, dynamic> toJson() {
    return {
      "Tier": tier,
      "Slot": slot,
      "name": name,
      "icon": icon,
      "level": level,
      "IsSelected": isSelected
    };
  }
}

class Rune {
  final String name;
  final String icon;
  final String grade;

  const Rune({required this.name, required this.icon, required this.grade});

  factory Rune.fromJSON(Map<String, dynamic> json) {
    return Rune(name: json["Name"], icon: json["Icon"], grade: json["Grade"]);
  }

  Map<String, dynamic> toJson() {
    return {"name": name, "icon": icon, "grade": grade};
  }
}
