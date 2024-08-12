import 'package:flutter/material.dart';
import 'package:result_dart/result_dart.dart';
import 'package:sample_project/DI/di_controller.dart';
import 'package:sample_project/Model/event.dart';
import 'package:sample_project/Model/favorite_character.dart';
import 'package:sample_project/Model/adventrue_island.dart';
import 'package:sample_project/Model/notice.dart';

class HomeViewModel extends ChangeNotifier {
  String _nickname = "";
  String get nickname => _nickname;

  bool _adventrueIslandCalendarLoading = false;
  bool get adventrueIslandCalendarLoading => _adventrueIslandCalendarLoading;
  AdventrueIslandCalendar? _adventrueIslandCalendar;
  AdventrueIslandCalendar? get adventrueIslandCalendar =>
      _adventrueIslandCalendar;

  List<Event>? _eventList;
  List<Event>? get eventList => _eventList;

  List<Notice>? _noticeList;
  List<Notice>? get noticeList => _noticeList;

  bool _favoriteCharacterLoading = false;
  bool get favoriteCharacterLoading => _favoriteCharacterLoading;

  FavoriteCharacter? _favoriteCharacter;
  FavoriteCharacter? get favoriteCharacter => _favoriteCharacter;

  String? _alertData;
  String? get alertData => _alertData;

  HomeViewModel() {
    _fetchAdventureIslandSchedule();
    _fetchEventList();
    _fetchNoticeList();
    fetchFavoriteCharacter();
  }

  Future<void> reloadData() async {
    _fetchAdventureIslandSchedule();
    _fetchEventList();
    _fetchNoticeList();
    fetchFavoriteCharacter();
  }

  void nicknameChanged(String nickname) {
    _nickname = nickname;
  }

  void _fetchAdventureIslandSchedule() async {
    _adventrueIslandCalendarLoading = true;
    Result<AdventrueIslandCalendar, Exception> result = await DIController
        .services.gameContentsService
        .fetchAdventrueIslandSchedule();
    result.fold((calendar) {
      _adventrueIslandCalendar = calendar;
    }, (err) {
      _alertData = err.toString();
    });
    _adventrueIslandCalendarLoading = false;
    notifyListeners();
  }

  void _fetchEventList() async {
    Result<List<Event>, Exception> result =
        await DIController.services.newsService.fetchEventList();

    result.fold((list) {
      _eventList = list;
    }, (err) {
      _alertData = err.toString();
    });

    notifyListeners();
  }

  void _fetchNoticeList() async {
    Result<List<Notice>, Exception> result =
        await DIController.services.newsService.fetchNoticeList();

    result.fold((list) {
      _noticeList = list;
    }, (err) {
      _alertData = err.toString();
    });

    notifyListeners();
  }

  void fetchFavoriteCharacter() async {
    _favoriteCharacterLoading = true;
    Result<FavoriteCharacter, Exception> result =
        await DIController.services.characterService.fetchFavoriteCharacter();

    result.fold((character) {
      _favoriteCharacter = character;
    }, (err) {
      _favoriteCharacter = null;
    });

    _favoriteCharacterLoading = false;
    notifyListeners();
  }

  void removeFavButtonTap() async {
    await DIController.services.characterService.removeFavoriteCharacter();
    _favoriteCharacter = null;
    notifyListeners();
  }

  void resetAlertData() {
    _alertData = null;
  }
}
