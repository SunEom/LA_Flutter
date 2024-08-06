import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:result_dart/result_dart.dart';
import 'package:sample_project/Model/adventrue_island.dart';
import 'package:sample_project/Repository/game_contents_repository.dart';
import 'package:sample_project/Util/network_util.dart';

abstract interface class GameContentsServiceType {
  Future<Result<AdventrueIslandCalendar, Exception>>
      fetchAdventrueIslandSchedule();
}

class GameContentsService implements GameContentsServiceType {
  GameContentsRepository networkGameContentRepository =
      NetworkGameContentRepository();

  @override
  Future<Result<AdventrueIslandCalendar, Exception>>
      fetchAdventrueIslandSchedule() async {
    if (await NetworkUtil.isConnected()) {
      return await networkGameContentRepository.fetchAdventrueIslandSchedule();
    } else {
      return Result.failure(Exception("인터넷 연결 오류"));
    }
  }
}
