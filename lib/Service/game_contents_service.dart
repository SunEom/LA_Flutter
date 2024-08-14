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

  LocalGameContentRepository localGameContentRepository =
      LocalGameContentRepository();

  @override
  Future<Result<AdventrueIslandCalendar, Exception>>
      fetchAdventrueIslandSchedule() async {
    Result<AdventrueIslandCalendar, Exception> result =
        await localGameContentRepository.fetchAdventrueIslandSchedule();

    if (result.isSuccess()) {
      print("Local");
      return result;
    } else {
      if (await NetworkUtil.isConnected()) {
        print("Network");
        return await networkGameContentRepository
            .fetchAdventrueIslandSchedule();
      } else {
        return Result.failure(Exception("인터넷 연결 오류"));
      }
    }
  }
}
