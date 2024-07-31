import 'package:flutter/material.dart';
import 'package:sample_project/DI/DIController.dart';
import 'package:sample_project/Model/Event.dart';
import 'package:sample_project/Model/adventrue_island.dart';
import 'package:sample_project/Model/notice.dart';

class HomeViewModel extends ChangeNotifier {
  String _nickname = "가니잇";
  String get nickname => _nickname;
  AdventrueIslandCalendar? _adventrueIslandCalendar = null;
  AdventrueIslandCalendar? get adventrueIslandCalendar =>
      this._adventrueIslandCalendar;

  List<Event>? _eventList = null;
  List<Event>? get eventList => this._eventList;

  List<Notice>? _noticeList = null;
  List<Notice>? get noticeList => this._noticeList;

  HomeViewModel() {
    fetchAdventureIslandSchedule();
    fetchEventList();
    fetchNoticeList();
  }

  void nicknameChanged(String nickname) {
    _nickname = nickname;
  }

  void fetchAdventureIslandSchedule() async {
    _adventrueIslandCalendar =
        await DIController.gameContentsService.fetchAdventrueIslandSchedule();
    notifyListeners();
  }

  void fetchEventList() async {
    _eventList = await DIController.newsService.fetchEventList();
    notifyListeners();
  }

  void fetchNoticeList() async {
    _noticeList = await DIController.newsService.fetchNoticeList();
    notifyListeners();
  }
}
