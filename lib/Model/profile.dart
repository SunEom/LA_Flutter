class ArmoryProfile {
  final String? characterImage;
  final int expeditionLevel;
  final int? townLevel;
  final String townName;
  final String? title;
  final String? guildMemberGrade;
  final String? guildName;
  final int usingSkillPoint;
  final int totalSkillPoint;
  final String characterName;
  final int characterLevel;
  final String characterClassName;
  final String itemAvgLevel;
  final String? itemMaxLevel;
  final String serverName;
  final List<Stats> stats;

  List<Stats> get mainStats {
    return stats
        .where((s) => [
              StatsType.speed,
              StatsType.critical,
              StatsType.specialization,
              StatsType.mastery,
              StatsType.subdue,
              StatsType.endurance
            ].contains(s.type))
        .toList();
  }

  List<Stats> get subStats {
    return stats
        .where((s) =>
            [StatsType.attackPower, StatsType.maxHealth].contains(s.type))
        .toList();
  }

  ArmoryProfile({
    this.characterImage,
    required this.expeditionLevel,
    this.townLevel,
    required this.townName,
    this.title,
    this.guildMemberGrade,
    this.guildName,
    required this.usingSkillPoint,
    required this.totalSkillPoint,
    required this.characterName,
    required this.characterLevel,
    required this.characterClassName,
    required this.itemAvgLevel,
    required this.itemMaxLevel,
    required this.serverName,
    required this.stats,
  });

  factory ArmoryProfile.fromJson(Map<String, dynamic> json) {
    //스텟을 수치에 따라 정렬
    List<Stats> statList = (json["Stats"] as List)
        .map((jsonItem) => Stats.fromJson(jsonItem))
        .toList();
    statList.sort((a, b) {
      if (a.orderPriority != b.orderPriority) {
        // 치특신인숙제 -> 공격력 -> 최대생
        return a.orderPriority.compareTo(b.orderPriority);
      } else {
        return int.parse(b.value).compareTo(int.parse(a.value));
      }
    });

    return ArmoryProfile(
      characterImage: json['CharacterImage'],
      expeditionLevel: json['ExpeditionLevel'],
      townLevel: json['TownLevel'],
      townName: json['TownName'],
      title: json['Title'],
      guildMemberGrade: json['GuildMemberGrade'],
      guildName: json['GuildName'],
      usingSkillPoint: json['UsingSkillPoint'],
      totalSkillPoint: json['TotalSkillPoint'],
      characterName: json['CharacterName'],
      characterLevel: json['CharacterLevel'],
      characterClassName: json['CharacterClassName'],
      itemAvgLevel: json['ItemAvgLevel'],
      itemMaxLevel: '',
      serverName: json['ServerName'],
      stats: statList,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'CharacterImage': characterImage,
      'ExpeditionLevel': expeditionLevel,
      'TownLevel': townLevel,
      'TownName': townName,
      'Title': title,
      'GuildMemberGrade': guildMemberGrade,
      'GuildName': guildName,
      'UsingSkillPoint': usingSkillPoint,
      'TotalSkillPoint': totalSkillPoint,
      'CharacterName': characterName,
      'CharacterLevel': characterLevel,
      'CharacterClassName': characterClassName,
      'ItemAvgLevel': itemAvgLevel,
      'ItemMaxLevel': itemMaxLevel,
      'ServerName': serverName,
      'Stats': stats
    };
  }
}

class Stats {
  final String typeString;
  final String value;
  StatsType get type {
    return StatsType.fromDisplayName(typeString);
  }

  int get orderPriority {
    if (type == StatsType.maxHealth) {
      return 3;
    } else if (type == StatsType.attackPower) {
      return 2;
    } else {
      return 1;
    }
  }

  Stats({required this.typeString, required this.value});

  factory Stats.fromJson(Map<String, dynamic> json) {
    return Stats(typeString: json["Type"], value: json["Value"]);
  }

  Map<String, dynamic> toJson() {
    return {"type": type, "value": value};
  }
}

enum StatsType {
  critical,
  speed,
  specialization,
  subdue,
  mastery,
  endurance,
  maxHealth,
  attackPower;

  String get displayName {
    switch (this) {
      case StatsType.critical:
        return "치명";

      case StatsType.speed:
        return "신속";

      case StatsType.specialization:
        return "특화";

      case StatsType.subdue:
        return "제압";

      case StatsType.mastery:
        return "숙련";

      case StatsType.endurance:
        return "인내";

      case StatsType.maxHealth:
        return "최대 생명력";

      case StatsType.attackPower:
        return "공격력";
    }
  }

  static StatsType fromDisplayName(String displayName) {
    switch (displayName) {
      case "치명":
        return StatsType.critical;
      case "신속":
        return StatsType.speed;
      case "특화":
        return StatsType.specialization;
      case "제압":
        return StatsType.subdue;
      case "숙련":
        return StatsType.mastery;
      case "인내":
        return StatsType.endurance;
      case "최대 생명력":
        return StatsType.maxHealth;
      case "공격력":
        return StatsType.attackPower;
      default:
        throw ArgumentError("Invalid display name: $displayName");
    }
  }
}

class ArkPassive {
  final bool isArkpassive;
  final List<ArkPassiveItem> points;
  const ArkPassive({required this.isArkpassive, required this.points});

  factory ArkPassive.fromJSON(Map<String, dynamic> json) {
    List<ArkPassiveItem> points = (json["Points"] as List)
        .map((e) => ArkPassiveItem.fromJSON(e))
        .toList();
    return ArkPassive(isArkpassive: json["IsArkPassive"], points: points);
  }
}

class ArkPassiveItem {
  final String name;
  final int value;

  const ArkPassiveItem({required this.name, required this.value});

  factory ArkPassiveItem.fromJSON(Map<String, dynamic> json) {
    return ArkPassiveItem(name: json["Name"], value: json["Value"]);
  }
}
