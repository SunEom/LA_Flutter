import 'dart:convert';

import 'package:sample_project/Util/xml_util.dart';

class ArkGrid {
  final List<ArkGridSlot>? slots;

  ArkGrid({required this.slots});

  factory ArkGrid.fromJSON(Map<String, dynamic> json) {
    List<ArkGridSlot>? slots = json["Slots"] == null
        ? null
        : (json["Slots"] as List).map((e) => ArkGridSlot.fromJSON(e)).toList();
    return ArkGrid(slots: slots);
  }
}

class ArkGridSlot {
  final int index;
  final String icon;
  final String name;
  final int point;
  final Tooltip? tooltip;

  get grade {
    return XmlUtil.getArkGridGrade(
        tooltip?.itemTitle?.first.value.leftStr0 ?? '');
  }

  const ArkGridSlot(
      {this.index = 0,
      this.icon = '',
      this.name = '',
      this.point = 0,
      this.tooltip = null});

  factory ArkGridSlot.fromJSON(Map<String, dynamic> json) {
    return ArkGridSlot(
        index: json["Index"],
        icon: json["Icon"],
        name: json["Name"],
        point: json["Point"],
        tooltip: Tooltip.fromJson(jsonDecode(json["Tooltip"])));
  }
}

class Tooltip {
  final List<NameTagBox>? nameTagBox;
  final List<ItemTitle>? itemTitle;
  final List<ItemPartBox>? itemPartBox;
  final List<SingleTextBox>? singleTextBox;
  final List<IndentStringGroup>? indentStringGroup;

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

        case "MultiTextBox":
          return MultiTextBox.fromJson(json);
      }
    }

    Map<String, List<Element>> elements = {};

    json.values.forEach((e) {
      if (e != null) {
        Element? item = parsingFromJson(e);

        if (item != null) {
          String type = item.runtimeType.toString();
          if (elements.containsKey(type)) {
            elements[type]!.add(item);
          } else {
            elements[type] = [item];
          }
        }
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
  final String leftStr0;
  ItemTitleValue({this.leftStr0 = ''});

  factory ItemTitleValue.fromJson(Map<String, dynamic> json) {
    return ItemTitleValue(leftStr0: json['leftStr0']);
  }

  Map<String, dynamic> toJson() {
    return {
      "leftStr0": leftStr0,
    };
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

class MultiTextBox implements Element {
  final String type;
  final String value;

  MultiTextBox({required this.type, required this.value});

  factory MultiTextBox.fromJson(Map<String, dynamic> json) {
    return MultiTextBox(
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
