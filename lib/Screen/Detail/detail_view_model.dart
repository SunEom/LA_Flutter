import 'package:flutter/material.dart';
import 'package:sample_project/DI/DIController.dart';
import 'package:sample_project/Model/Character.dart';

enum DetailViewTab {
  main,
  skill,
  armory;

  static List<DetailViewTab> get defaultOrder {
    return [DetailViewTab.main, DetailViewTab.skill, DetailViewTab.armory];
  }

  String get displayName {
    switch (this) {
      case DetailViewTab.main:
        return "메인";

      case DetailViewTab.skill:
        return "스킬";

      case DetailViewTab.armory:
        return "원정대";
    }
  }
}

class DetailViewModel extends ChangeNotifier {
  late String nickname;
  CharacterInfo? _info = null;
  CharacterInfo? get info => _info;
  bool isLoading = true;
  DetailViewTab selectedTab = DetailViewTab.skill;

  DetailViewModel(String nickname) {
    this.nickname = nickname;
    fetchDetail();
  }

  void fetchDetail() async {
    isLoading = true;
    _info = await DIController.characterService.fetchCharacterInfo(nickname);
    isLoading = false;
    notifyListeners();
  }

  void changeTab(DetailViewTab tab) {
    this.selectedTab = tab;
    notifyListeners();
  }
}
