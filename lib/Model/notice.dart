import 'package:flutter/material.dart';
import 'package:sample_project/Constant/Constant.dart';

class Notice {
  final String title;
  final String date;
  final String link;
  final String type;
  DateTime get dateTime => DateTime.parse(date);
  bool get isNew {
    DateTime date = DateTime.parse(this.date);
    DateTime beforeAWeek = DateTime.now().subtract(Duration(days: 5));

    return date.isAfter(beforeAWeek);
  }

  Color get typeColor {
    switch (type) {
      case "이벤트":
        return const Color.fromRGBO(154, 92, 199, 1);

      case "상점":
        return const Color.fromRGBO(32, 255, 255, 1);

      case "점검":
        return const Color.fromRGBO(67, 148, 254, 1);

      default:
        return K.appColor.white;
    }
  }

  const Notice(
      {required this.title,
      required this.date,
      required this.link,
      required this.type});

  factory Notice.fromJSON(Map<String, dynamic> json) {
    return Notice(
        title: json["Title"],
        date: json["Date"],
        link: json["Link"],
        type: json["Type"]);
  }

  Map<String, dynamic> toJson() {
    return {"Title": title, "Date": date, "Link": link, "Type": type};
  }
}
