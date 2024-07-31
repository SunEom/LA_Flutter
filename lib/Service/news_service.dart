import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

import 'package:sample_project/Constant/Constant.dart';
import 'package:sample_project/Model/Event.dart';
import 'package:sample_project/Model/adventrue_island.dart';
import 'package:sample_project/Model/notice.dart';

abstract interface class NewsServiceType {
  Future<List<Notice>?> fetchNoticeList();
  Future<List<Event>?> fetchEventList();
}

class NewsService implements NewsServiceType {
  @override
  Future<List<Notice>?> fetchNoticeList() async {
    var url = Uri.parse('${K.lostArkAPI.base}news/notices');
    var client = http.Client();

    try {
      var response = await client.get(
        url,
        headers: {'Authorization': 'Bearer ${dotenv.env["API_KEY"]}'},
      );

      if (response.statusCode == 200 && response.body != "null") {
        // 성공적으로 데이터를 받음
        List<Notice> noticeList = (json.decode(response.body) as List)
            .map((e) => Notice.fromJSON(e))
            .toList();

        return noticeList;
      } else {
        // 에러 처리
        return null;
      }
    } finally {
      client.close();
    }
  }

  @override
  Future<List<Event>?> fetchEventList() async {
    var url = Uri.parse('${K.lostArkAPI.base}news/events');
    var client = http.Client();

    try {
      var response = await client.get(
        url,
        headers: {'Authorization': 'Bearer ${dotenv.env["API_KEY"]}'},
      );

      if (response.statusCode == 200 && response.body != "null") {
        // 성공적으로 데이터를 받음
        List<Event> eventList = (json.decode(response.body) as List)
            .map((e) => Event.fromJSON(e))
            .toList();

        return eventList;
      } else {
        // 에러 처리
        return null;
      }
    } finally {
      client.close();
    }
  }
}
