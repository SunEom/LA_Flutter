import 'package:flutter/material.dart';
import 'package:result_dart/result_dart.dart';
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
    Result<AdventrueIslandCalendar, Exception> result = await DIController
        .services.gameContentsService
        .fetchAdventrueIslandSchedule();
    result.fold((calendar) {
      _adventrueIslandCalendar = calendar;
    }, (err) {
      //에러처리
    });
    notifyListeners();
  }

  void _fetchEventList() async {
    Result<List<Event>, Exception> result =
        await DIController.services.newsService.fetchEventList();

    result.fold((list) {
      _eventList = list;
    }, (err) {
      //에러처리
    });

    notifyListeners();
  }

  void _fetchNoticeList() async {
    Result<List<Notice>, Exception> result =
        await DIController.services.newsService.fetchNoticeList();

    result.fold((list) {
      _noticeList = list;
    }, (err) {
      //에러처리
    });

    notifyListeners();
  }

  void fetchFavoriteCharacter() async {
    Result<FavoriteCharacter, Exception> result =
        await DIController.services.characterService.fetchFavoriteCharacter();

    result.fold((character) {
      _favoriteCharacter = character;
    }, (err) {
      _favoriteCharacter = null;
    });

    notifyListeners();
  }

  void removeFavButtonTap() async {
    await DIController.services.characterService.removeFavoriteCharacter();
    _favoriteCharacter = null;
    notifyListeners();
  }
}
