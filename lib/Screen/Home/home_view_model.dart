import 'package:flutter/material.dart';
import 'package:sample_project/DI/DIController.dart';
import 'package:sample_project/Model/Event.dart';
import 'package:sample_project/Model/FavoriteCharacter.dart';
import 'package:sample_project/Model/adventrue_island.dart';
import 'package:sample_project/Model/notice.dart';

class HomeViewModel extends ChangeNotifier {
  String _nickname = "";
  String get nickname => _nickname;
  AdventrueIslandCalendar? _adventrueIslandCalendar;
  AdventrueIslandCalendar? get adventrueIslandCalendar =>
      _adventrueIslandCalendar;

  List<Event>? _eventList;
  List<Event>? get eventList => _eventList;

  List<Notice>? _noticeList;
  List<Notice>? get noticeList => _noticeList;

  FavoriteCharacter? _favoriteCharacter;
  FavoriteCharacter? get favoriteCharacter => _favoriteCharacter;

  HomeViewModel() {
    _fetchAdventureIslandSchedule();
    _fetchEventList();
    _fetchNoticeList();
    fetchFavoriteCharacter();
  }

  void nicknameChanged(String nickname) {
    _nickname = nickname;
  }

  void _fetchAdventureIslandSchedule() async {
    _adventrueIslandCalendar =
        await DIController.gameContentsService.fetchAdventrueIslandSchedule();
    notifyListeners();
  }

  void _fetchEventList() async {
    _eventList = await DIController.newsService.fetchEventList();
    notifyListeners();
  }

  void _fetchNoticeList() async {
    _noticeList = await DIController.newsService.fetchNoticeList();
    notifyListeners();
  }

  void fetchFavoriteCharacter() async {
    _favoriteCharacter =
        await DIController.characterService.fetchFavoriteCharacter();
    notifyListeners();
  }

  void removeFavButtonTap() async {
    await DIController.characterService.removeFavoriteCharacter();
    _favoriteCharacter = null;
    notifyListeners();
  }
}
