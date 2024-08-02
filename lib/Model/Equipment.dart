import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:sample_project/Extensions/Map+Extensions.dart';
import 'package:sample_project/Util/reg_util.dart';

class ArmoryEquipment {
  final List<Equipment> equipments;

  int get totalElixirLevel {
    int total = 0;
    equipments.forEach((eq) {
      eq.tooltip.elixir.forEach((eli) {
        total += int.parse(eli[1] ?? "");
      });
    });

    return total;
  }

  int get totalTranscendence {
    int total = 0;
    equipments.forEach((eq) {
      total += int.parse(eq.tooltip.transcendence?[1] ?? "0");
    });

    return total;
  }

  ArmoryEquipment({required this.equipments});

  Equipment? getEquipment(EquipType type) {
    int idx = equipments
        .indexWhere((equipment) => equipment.type == type.displayName);
    return idx == -1 ? null : equipments[idx];
  }

  Equipment? getAccessory(AccessoryType type) {
    switch (type) {
      case AccessoryType.neckless:
        int idx = equipments
            .indexWhere((equipment) => equipment.type == type.displayName);
        return idx == -1 ? null : equipments[idx];

      case AccessoryType.earring1:
        List li = equipments
            .where((equipment) => (equipment.type == type.displayName))
            .toList();

        return li.length > 0 ? li[0] : null;

      case AccessoryType.earring2:
        List li = equipments
            .where((equipment) => (equipment.type == type.displayName))
            .toList();

        return li.length > 1 ? li[1] : null;

      case AccessoryType.ring1:
        List li = equipments
            .where((equipment) => (equipment.type == type.displayName))
            .toList();

        return li.length > 0 ? li[0] : null;

      case AccessoryType.ring2:
        List li = equipments
            .where((equipment) => (equipment.type == type.displayName))
            .toList();

        return li.length > 1 ? li[1] : null;

      case AccessoryType.bracelet:
        int idx = equipments
            .indexWhere((equipment) => equipment.type == type.displayName);

        return idx == -1 ? null : equipments[idx];

      case AccessoryType.abilityStone:
        int idx = equipments
            .indexWhere((equipment) => equipment.type == type.displayName);

        return idx == -1 ? null : equipments[idx];
    }
  }
}

enum EquipType {
  headGear,
  top,
  bottom,
  shoulder,
  glove,
  weapon;

  String get displayName {
    switch (this) {
      case EquipType.headGear:
        return "투구";

      case EquipType.top:
        return "상의";

      case EquipType.bottom:
        return "하의";

      case EquipType.shoulder:
        return "어깨";

      case EquipType.glove:
        return "장갑";

      case EquipType.weapon:
        return "무기";
    }
  }
}

enum AccessoryType {
  neckless,
  earring1,
  earring2,
  ring1,
  ring2,
  bracelet,
  abilityStone;

  String get displayName {
    switch (this) {
      case AccessoryType.neckless:
        return "목걸이";

      case AccessoryType.earring1:
        return "귀걸이";

      case AccessoryType.earring2:
        return "귀걸이";

      case AccessoryType.ring1:
        return "반지";

      case AccessoryType.ring2:
        return "반지";

      case AccessoryType.bracelet:
        return "팔찌";

      case AccessoryType.abilityStone:
        return "어빌리티 스톤";
    }
  }
}

class Equipment {
  final String type;
  final String name;
  final String icon;
  final String grade;
  final Tooltip tooltip;

  Equipment(
      {required this.type,
      required this.name,
      required this.icon,
      required this.grade,
      required this.tooltip});

  factory Equipment.fromJson(Map<String, dynamic> json) {
    return Equipment(
      type: json['Type'],
      name: json['Name'],
      icon: json['Icon'],
      grade: json['Grade'],
      tooltip: Tooltip.fromJson(jsonDecode(json['Tooltip'])),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "Type": type,
      "Name": name,
      "Icon": icon,
      "Grade": grade,
      "Tooltip": tooltip
    };
  }
}

class Tooltip {
  final List<NameTagBox>? nameTagBox;
  final List<ItemTitle>? itemTitle;
  final List<ItemPartBox>? itemPartBox;
  final List<SingleTextBox>? singleTextBox;
  final List<IndentStringGroup>? indentStringGroup;

  // 상급재련
  String? get advancedUpgrade {
    List<SingleTextBox>? li =
        singleTextBox?.where((e) => (e.value.contains("상급 재련"))).toList();

    if (li != null && li.isNotEmpty) {
      return RegUtil.getNumbersFromString(li[0].value)[4];
    } else {
      return null;
    }
  }

  // 치명, 신속, 특화가 있는 경우만 추출
  String? get mainStats {
    String? s = null;

    itemPartBox?.forEach((element) {
      List<String?> li = RegUtil.getCritSpeedOrSpecializationValues(
          element.value?["Element_001"] ?? "");

      if (li.isNotEmpty) {
        s = li.join(" ");
      }
    });

    return s;
  }

  // 치명, 신속, 특화, 제압, 인내, 숙련 모두 추출
  String? get stats {
    String? s = null;

    itemPartBox?.forEach((element) {
      List<String?> li =
          RegUtil.getStatValues(element.value?["Element_001"] ?? "");

      if (li.isNotEmpty) {
        s = li.join(" ");
      }
    });

    return s;
  }

  List<List<String?>> get elixir {
    List<List<String?>> option = [];

    indentStringGroup?.forEach((isg) {
      isg.value?.values.forEach((v) {
        if (v.topStr.contains("엘릭서")) {
          v.contentStr?.values.forEach((e) {
            option.add(RegUtil.getElixirSkillAndLevel(e.contentStr));
          });
        }
      });
    });

    return option;
  }

  List<String>? get transcendence {
    List<String>? transcendence = null;

    indentStringGroup?.forEach((isg) {
      isg.value?.values.forEach((v) {
        if (v.topStr.contains("초월")) {
          transcendence = RegUtil.getTranscendence(v.topStr);
        }
      });
    });

    return transcendence;
  }

  String get elixirAddtionalEffect {
    String option = "추가 효과 없음";

    indentStringGroup?.forEach((isg) {
      isg.value?.values.forEach((v) {
        if (v.topStr.contains("연성 추가 효과")) {
          option = RegUtil.getElixirAddtionalEffect(v.topStr);
        }
      });
    });

    return option;
  }

  List<String>? get braceletOption {
    List<String>? result = null;

    itemPartBox?.forEach((e) {
      if (e.value?["Element_000"]?.contains("팔찌 효과") ?? false) {
        result = RegUtil.getBraceletOption(e.value?["Element_001"] ?? "");
      }
    });

    return result;
  }

  List<List<String>> get buffAbilityStoneOption {
    List<List<String>> result = [];
    indentStringGroup?.forEach((isg) {
      isg.value?.values.forEach((v) {
        if (v.topStr.contains("무작위 각인 효과")) {
          v.contentStr?.values.forEach((cs) {
            List<String> option = RegUtil.getAbilityStoneOption(cs.contentStr);
            if (option[0] != "이동속도 감소" &&
                option[0] != "공격력 감소" &&
                option[0] != "공격속도 감소" &&
                option[0] != "방어력 감소") {
              result.add(option);
            }
          });
        }
      });
    });

    return result;
  }

  List<List<String>> get debuffAbilityStoneOption {
    List<List<String>> result = [];
    indentStringGroup?.forEach((isg) {
      isg.value?.values.forEach((v) {
        if (v.topStr.contains("무작위 각인 효과")) {
          v.contentStr?.values.forEach((cs) {
            List<String> option = RegUtil.getAbilityStoneOption(cs.contentStr);

            if (option[0] == "이동속도 감소" ||
                option[0] == "공격력 감소" ||
                option[0] == "공격속도 감소" ||
                option[0] == "방어력 감소") {
              result.add(option);
            }
          });
        }
      });
    });

    return result;
  }

  Tooltip(
      {this.nameTagBox,
      this.itemTitle,
      this.itemPartBox,
      this.singleTextBox,
      this.indentStringGroup});

  factory Tooltip.fromJson(Map<String, dynamic> json) {
    Element? parsingFromJson(Map<String, dynamic> json) {
      switch (json['type']) {
        case 'NameTagBox':
          return NameTagBox.fromJson(json);

        case 'ItemTitle':
          return ItemTitle.fromJson(json);

        case "ItemPartBox":
          return ItemPartBox.fromJson(json);

        case "SingleTextBox":
          return SingleTextBox.fromJson(json);

        case "IndentStringGroup":
          return IndentStringGroup.fromJson(json);
      }
    }

    Map<String, List<Element>> elements = {};

    json.values.forEach((e) {
      Element? item = parsingFromJson(e);

      if (item != null) {
        elements.appendToList(item.type, item);
      }
    });

    return Tooltip(
        nameTagBox:
            (elements['NameTagBox']?.map((e) => (e as NameTagBox)).toList() ??
                []),
        itemTitle:
            (elements['ItemTitle']?.map((e) => (e as ItemTitle)).toList() ??
                []),
        itemPartBox:
            (elements['ItemPartBox']?.map((e) => (e as ItemPartBox)).toList() ??
                []),
        singleTextBox: (elements['SingleTextBox']
                ?.map((e) => (e as SingleTextBox))
                .toList() ??
            []),
        indentStringGroup: (elements['IndentStringGroup']
                ?.map((e) => (e as IndentStringGroup))
                .toList() ??
            []));
  }

  Map<String, dynamic> toJson() {
    return {"NameTagBox": nameTagBox, 'ItemTitle': itemTitle};
  }
}

class Element {
  final String type;
  final dynamic value;

  Element({required this.type, required this.value});
}

class NameTagBox implements Element {
  final String type;
  final String value;

  NameTagBox({required this.type, required this.value});

  factory NameTagBox.fromJson(Map<String, dynamic> json) {
    return NameTagBox(
      type: json['type'],
      value: json['value'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "type": type,
      "value": value,
    };
  }
}

class ItemTitle implements Element {
  final String type;
  final ItemTitleValue value;

  ItemTitle({required this.type, required this.value});

  factory ItemTitle.fromJson(Map<String, dynamic> json) {
    return ItemTitle(
      type: json['type'],
      value: ItemTitleValue.fromJson(json['value']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "type": type,
      "value": value,
    };
  }
}

class ItemTitleValue {
  final int quality;
  final String? itemLevel;

  ItemTitleValue({required this.quality, required this.itemLevel});

  factory ItemTitleValue.fromJson(Map<String, dynamic> json) {
    String? itemLevelString = null;
    if (json['leftStr2'].contains("레벨")) {
      itemLevelString = RegUtil.getNumbersFromString(json['leftStr2'])[1];
    }
    return ItemTitleValue(
        quality: json['qualityValue'], itemLevel: itemLevelString);
  }

  Color getQualityColor() {
    if (this.quality < 10) {
      return Color.fromRGBO(192, 0, 0, 1);
    } else if (this.quality < 30) {
      return Color.fromRGBO(255, 192, 0, 1);
    } else if (this.quality < 70) {
      return Color.fromRGBO(112, 173, 71, 1);
    } else if (this.quality < 90) {
      return Color.fromRGBO(67, 114, 196, 1);
    } else if (this.quality < 100) {
      return Color.fromRGBO(112, 48, 160, 1);
    } else if (this.quality == 100) {
      return Color.fromRGBO(205, 70, 0, 1);
    } else {
      return Colors.transparent;
    }
  }

  Map<String, dynamic> toJson() {
    return {"quality": quality, "itemLevel": itemLevel};
  }
}

class ItemPartBox implements Element {
  final String type;
  final Map<String, String>? value;

  ItemPartBox({required this.type, required this.value});

  factory ItemPartBox.fromJson(Map<String, dynamic> json) {
    var valueJson =
        json['value'] != null ? json['value'] as Map<String, dynamic> : null;

    Map<String, String>? value = valueJson?.map((key, value) {
      return MapEntry(key, value.toString());
    });

    return ItemPartBox(
      type: json['type'],
      value: value,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "type": type,
      "value": value,
    };
  }
}

class SingleTextBox implements Element {
  final String type;
  final String value;

  SingleTextBox({required this.type, required this.value});

  factory SingleTextBox.fromJson(Map<String, dynamic> json) {
    return SingleTextBox(
      type: json['type'],
      value: json['value'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "type": type,
      "value": value,
    };
  }
}

class IndentStringGroup implements Element {
  final String type;
  final Map<String, IndentStringGroupSubElement>? value;

  IndentStringGroup({required this.type, required this.value});

  factory IndentStringGroup.fromJson(Map<String, dynamic> json) {
    var valueJson =
        json['value'] != null ? json['value'] as Map<String, dynamic> : null;

    Map<String, IndentStringGroupSubElement>? value =
        valueJson?.map((key, value) {
      return MapEntry(key, IndentStringGroupSubElement.fromJson(value));
    });

    return IndentStringGroup(
      type: json['type'],
      value: value,
    );
  }

  Map<String, dynamic> toJson() {
    var valueJson = value?.map((key, value) => MapEntry(key, value.toJson()));
    return {
      'type': type,
      'value': valueJson,
    };
  }
}

class IndentStringGroupSubElement {
  final Map<String, ContentStr>? contentStr;
  final String topStr;

  IndentStringGroupSubElement({required this.contentStr, required this.topStr});

  factory IndentStringGroupSubElement.fromJson(Map<String, dynamic> json) {
    var valueJson = json['contentStr'] != null
        ? json['contentStr'] as Map<String, dynamic>
        : null;

    Map<String, ContentStr>? value = valueJson?.map((key, value) {
      return MapEntry(key, ContentStr.fromJson(value));
    });

    return IndentStringGroupSubElement(
      contentStr: value,
      topStr: json['topStr'],
    );
  }

  Map<String, dynamic> toJson() {
    var valueJson =
        contentStr?.map((key, value) => MapEntry(key, value.toJson()));
    return {
      'contentStr': valueJson,
      'topStr': topStr,
    };
  }
}

class ContentStr {
  final dynamic bPoint;
  final String contentStr;

  ContentStr({required this.bPoint, required this.contentStr});

  factory ContentStr.fromJson(Map<String, dynamic> json) {
    return ContentStr(
      bPoint: json['bPoint'],
      contentStr: json['contentStr'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'bPoint': bPoint,
      'contentStr': contentStr,
    };
  }
}
