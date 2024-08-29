import 'package:sample_project/Util/reg_util.dart';

class ArmoryEngraving {
  final List<Effect>? effects;
  final List<ArkPassiveEffect>? arkPassiveEffects;

  ArmoryEngraving({this.effects, this.arkPassiveEffects});

  factory ArmoryEngraving.fromJson(Map<String, dynamic> json) {
    return ArmoryEngraving(
        effects: json["Effects"] == null
            ? null
            : (json["Effects"] as List)
                .map((jsonItem) => Effect.fromJson(jsonItem))
                .toList(),
        arkPassiveEffects: json["ArkPassiveEffects"] == null
            ? null
            : (json["ArkPassiveEffects"] as List)
                .map((jsonItem) => ArkPassiveEffect.fromJson(jsonItem))
                .toList());
  }
}

class Effect {
  final String icon;
  final String name;

  String get nameWithoutLevel {
    return name.split("Lv.").first.trim();
  }

  List<String> get items {
    return RegUtil.getEngravingOptions(name);
  }

  Effect({required this.icon, required this.name});

  factory Effect.fromJson(Map<String, dynamic> json) {
    return Effect(icon: json["Icon"], name: json["Name"]);
  }

  Map<String, dynamic> toJson() {
    return {'icon': icon, 'name': name};
  }
}

class ArkPassiveEffect {
  final int? abilityStoneLevel;
  final String grade;
  final int level;
  final String name;

  ArkPassiveEffect(
      {this.abilityStoneLevel,
      required this.grade,
      required this.level,
      required this.name});

  factory ArkPassiveEffect.fromJson(Map<String, dynamic> json) {
    return ArkPassiveEffect(
        abilityStoneLevel: json["AbilityStoneLevel"],
        grade: json["Grade"],
        level: json["Level"],
        name: json["Name"]);
  }

  Map<String, dynamic> toJson() {
    return {
      'AbilityStoneLevel': abilityStoneLevel,
      "Grade": grade,
      "Level": level,
      'Name': name
    };
  }
}
