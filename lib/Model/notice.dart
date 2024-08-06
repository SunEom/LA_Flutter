import 'package:flutter/material.dart';

class Notice {
  final String title;
  final String date;
  final String link;
  final String type;
  bool get isNew {
    DateTime date = DateTime.parse(this.date);
    DateTime beforeAWeek = DateTime.now().subtract(Duration(days: 5));

    return date.isAfter(beforeAWeek);
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
