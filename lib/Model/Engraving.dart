import 'package:sample_project/Util/Util.dart';

class ArmoryEngraving {
  final List<Effect> effects;

  ArmoryEngraving({required this.effects});

  factory ArmoryEngraving.fromJson(Map<String, dynamic> json) {
    return ArmoryEngraving(
        effects: (json["Effects"] as List)
            .map((jsonItem) => Effect.fromJson(jsonItem))
            .toList());
  }
}

class Effect {
  final String icon;
  final String name;
  List<String> get items {
    return Utils.getEngravingOptions(name);
  }

  Effect({required this.icon, required this.name});

  factory Effect.fromJson(Map<String, dynamic> json) {
    return Effect(icon: json["Icon"], name: json["Name"]);
  }

  Map<String, dynamic> toJson() {
    return {'icon': icon, 'name': name};
  }
}
