import 'package:result_dart/result_dart.dart';

import 'package:sample_project/Model/event.dart';
import 'package:sample_project/Model/notice.dart';
import 'package:sample_project/Repository/news_repository.dart';
import 'package:sample_project/Util/network_util.dart';

abstract interface class NewsServiceType {
  Future<Result<List<Notice>, Exception>> fetchNoticeList();
  Future<Result<List<Event>, Exception>> fetchEventList();
}

class NewsService implements NewsServiceType {
  NetworkNewsRepository networkNewsRepository = NetworkNewsRepository();
  LocalNewsRepository localNewsRepository = LocalNewsRepository();

  @override
  Future<Result<List<Notice>, Exception>> fetchNoticeList() async {
    if (await NetworkUtil.isConnected()) {
      // 네트워크 연결이 되어있는 경우
      return await networkNewsRepository.fetchNoticeList();
    } else {
      // 네트워크 연결이 되어있지 않은 경우
      return await localNewsRepository.fetchNoticeList();
    }
  }

  @override
  Future<Result<List<Event>, Exception>> fetchEventList() async {
    Result<List<Event>, Exception> result =
        await localNewsRepository.fetchEventList();

    if (result.isSuccess()) {
      return result;
    } else {
      if (await NetworkUtil.isConnected()) {
        return await networkNewsRepository.fetchEventList();
      } else {
        return Result.failure(Exception("인터넷 연결 오류"));
      }
    }
  }
}
