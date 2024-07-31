class ArmoryGem {
  final List<Gem>? gems;

  ArmoryGem({this.gems});

  factory ArmoryGem.fromJSON(Map<String, dynamic> json) {
    //보석 미착용
    if (json["ArmoryGem"]["Gems"] == null) {
      return ArmoryGem(gems: null);
    }

    int sortSkillList(Gem s1, Gem s2) {
      if (s1.orderPriority != s2.orderPriority) {
        return s1.orderPriority.compareTo(s2.orderPriority);
      } else if (s1.level != s2.level) {
        return s1.level > s2.level ? 0 : 1;
      } else {
        return 0;
      }
    }

    List<Gem> gemList = (json["ArmoryGem"]["Gems"] as List)
        .map((e) => Gem.fromJSON(e))
        .toList();

    gemList.sort(sortSkillList);

    return ArmoryGem(gems: gemList);
  }

  Map<String, dynamic> toJson() {
    return {"gems": gems};
  }
}

class Gem {
  final String name;
  final String icon;
  final int level;
  final String tooltip;

  String get type {
    RegExp regExp = RegExp(r"(\S+)의 보석");

    RegExpMatch? match = regExp.firstMatch(name);

    if (match != null) {
      String result = match.group(1)!; // 첫 번째 캡처 그룹 (단어)
      return result;
    } else {
      return "";
    }
  }

  int get orderPriority {
    switch (type) {
      case "겁화" || "멸화":
        return 0;

      case "작열" || "홍염":
        return 1;

      default:
        return 2;
    }
  }

  Gem(
      {required this.name,
      required this.icon,
      required this.level,
      required this.tooltip});

  factory Gem.fromJSON(Map<String, dynamic> json) {
    return Gem(
        name: json["Name"],
        icon: json["Icon"],
        level: json["Level"],
        tooltip: json["Tooltip"]);
  }

  Map<String, dynamic> toJson() {
    return {"name": name, "icon": icon, "level": level, "toolTip": tooltip};
  }
}
