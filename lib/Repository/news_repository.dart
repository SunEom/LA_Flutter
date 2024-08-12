import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:result_dart/result_dart.dart';
import 'package:sample_project/Constant/constant.dart';
import 'package:sample_project/Model/event.dart';
import 'package:sample_project/Model/notice.dart';
import 'package:http/http.dart' as http;
import 'package:sample_project/Util/datetime_util.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract interface class NewsRepository {
  Future<Result<List<Notice>, Exception>> fetchNoticeList();
  Future<Result<List<Event>, Exception>> fetchEventList();
}

class NetworkNewsRepository implements NewsRepository {
  @override
  Future<Result<List<Notice>, Exception>> fetchNoticeList() async {
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

        _saveNoticeList(noticeList);

        return Result.success(noticeList);
      } else {
        return Result.failure(Exception("HTTP 응답 오류"));
      }
    } finally {
      client.close();
    }
  }

  @override
  Future<Result<List<Event>, Exception>> fetchEventList() async {
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

        _saveEventList(eventList);

        return Result.success(eventList);
      } else {
        // 에러 처리
        return Result.failure(Exception("HTTP 응답 오류"));
      }
    } finally {
      client.close();
    }
  }

  void _saveNoticeList(List<Notice> noticeList) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    List<String> jsonStringList =
        noticeList.map((e) => jsonEncode(e.toJson())).toList();
    await pref.setStringList('noticeList', jsonStringList);
  }

  void _saveEventList(List<Event> eventList) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    List<String> jsonStringList =
        eventList.map((e) => jsonEncode(e.toJson())).toList();

    bool isSuccess = await pref.setStringList('eventList', jsonStringList);

    if (isSuccess) {
      await pref.setString('recentEventFetchDate', DateTime.now().toString());
    }
  }
}

class LocalNewsRepository implements NewsRepository {
  @override
  Future<Result<List<Notice>, Exception>> fetchNoticeList() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();

    List<String>? jsonStringList = pref.getStringList('noticeList');

    if (jsonStringList != null) {
      List<Notice> noticeList =
          jsonStringList.map((e) => Notice.fromJSON(json.decode(e))).toList();

      return Result.success(noticeList);
    } else {
      return const Result.success([]);
    }
  }

  @override
  Future<Result<List<Event>, Exception>> fetchEventList() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();

    List<String>? jsonStringList = pref.getStringList('eventList');

    String? recentEventFetchDateString = pref.getString("recentEventFetchDate");

    if (recentEventFetchDateString == null) {
      // 이벤트 정보를 가져온 적이 없는 경우
      return Result.failure(Exception("이벤트 정보를 가져온 기록이 없습니다."));
    } else {
      if (DatetimeUtil.isAfterLastWednesday(
          DateTime.parse(recentEventFetchDateString))) {
        if (jsonStringList != null) {
          List<Event> eventList = jsonStringList
              .map((e) => Event.fromJSON(json.decode(e)))
              .toList();

          return Result.success(eventList);
        } else {
          return Result.failure(Exception("이벤트 정보를 가져올 수 없습니다."));
        }
      } else {
        // 이벤트 정보를 가져온 날짜가 지난 수요일 이전인 경우
        return Result.failure(Exception("이벤트 갱신이 필요합니다."));
      }
    }
  }
}
