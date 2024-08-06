import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:result_dart/result_dart.dart';
import 'package:sample_project/Constant/Constant.dart';
import 'package:sample_project/Model/adventrue_island.dart';
import 'package:http/http.dart' as http;

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
      var response = await client.get(
        url,
        headers: {'Authorization': 'Bearer ${dotenv.env["API_KEY"]}'},
      );

      if (response.statusCode == 200 && response.body != "null") {
        // 성공적으로 데이터를 받음
        var adventrueIslandCalendar =
            AdventrueIslandCalendar.fromJSON(json.decode(response.body));
        return Result.success(adventrueIslandCalendar);
      } else {
        // 에러 처리
        return Result.failure(Exception("HTTP 응답 오류"));
      }
    } finally {
      client.close();
    }
  }
}
