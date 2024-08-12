import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:result_dart/result_dart.dart';
import 'package:sample_project/Constant/constant.dart';
import 'package:sample_project/Model/adventrue_island.dart';
import 'package:http/http.dart' as http;
import 'package:sample_project/Util/datetime_util.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract interface class GameContentsRepository {
  Future<Result<AdventrueIslandCalendar, Exception>>
      fetchAdventrueIslandSchedule();
}

class NetworkGameContentRepository implements GameContentsRepository {
  @override
  Future<Result<AdventrueIslandCalendar, Exception>>
      fetchAdventrueIslandSchedule() async {
    var url = Uri.parse('${K.lostArkAPI.base}gamecontents/calendar');
    var client = http.Client();

    try {
      final SharedPreferences pref = await SharedPreferences.getInstance();

      var response = await client.get(
        url,
        headers: {'Authorization': 'Bearer ${dotenv.env["API_KEY"]}'},
      );

      if (response.statusCode == 200 && response.body != "null") {
        // 성공적으로 데이터를 받음
        var adventrueIslandCalendar =
            AdventrueIslandCalendar.fromJSON(json.decode(response.body));
        _saveNoticeList(adventrueIslandCalendar);
        return Result.success(adventrueIslandCalendar);
      } else {
        // 에러 처리
        return Result.failure(Exception("HTTP 응답 오류"));
      }
    } finally {
      client.close();
    }
  }

  void _saveNoticeList(AdventrueIslandCalendar adventrueIslandCalendar) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    List<String> jsonStringList = adventrueIslandCalendar.gameContents
        .map((e) => jsonEncode(e.toJson()))
        .toList();

    bool isSuccess =
        await pref.setStringList('adventrueIslandCalendar', jsonStringList);

    if (isSuccess) {
      await pref.setString(
          'recentAdventrueIslandCalendarFetchDate', DateTime.now().toString());
    }
  }
}

class LocalGameContentRepository implements GameContentsRepository {
  @override
  Future<Result<AdventrueIslandCalendar, Exception>>
      fetchAdventrueIslandSchedule() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();

    String? recentAdventrueIslandCalendarFetchDateString =
        pref.getString("recentAdventrueIslandCalendarFetchDate");

    if (recentAdventrueIslandCalendarFetchDateString == null) {
      // 모험섬 정보를 가져온 적이 없는 경우
      return Result.failure(Exception("저장된 모험섬 정보가 없습니다."));
    } else {
      if (DatetimeUtil.isAfterLastWednesday(
          DateTime.parse(recentAdventrueIslandCalendarFetchDateString))) {
        // 최근 1주일 안에 모험섬 정보를 가져온 경우
        List<String>? jsonStringList =
            pref.getStringList('adventrueIslandCalendar');

        if (jsonStringList != null) {
          List<AdventrueIsland> gameContents = jsonStringList
              .map((e) => AdventrueIsland.fromJSON(json.decode(e)))
              .toList();

          AdventrueIslandCalendar calendar =
              AdventrueIslandCalendar(gameContents: gameContents);

          return Result.success(calendar);
        } else {
          return Result.failure(Exception("모험섬 정보를 가져올 수 없습니다."));
        }
      } else {
        // 모험섬 정보를 가져온 날짜가 지난 수요일 이전인 경우
        return Result.failure(Exception("모험섬 갱신이 필요합니다."));
      }
    }
  }
}
