import 'package:flutter/material.dart';
import 'package:sample_project/DI/DIController.dart';
import 'package:sample_project/Model/Character.dart';
import 'package:sample_project/Model/FavoriteCharacter.dart';
import 'package:sample_project/Model/Sibling.dart';

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
  DetailViewTab selectedTab = DetailViewTab.main;
  ArmorySiblings? _armorySiblings = null;
  ArmorySiblings? get armorySiblings => _armorySiblings;

  FavoriteCharacter? _favoriteCharacter = null;
  FavoriteCharacter? get favoriteCharacter => _favoriteCharacter;

  bool get isFavCharacter {
    if (_info == null || _favoriteCharacter == null) {
      return false;
    }

    return favoriteCharacter!.name == info!.armoryProfile.characterName;
  }

  DetailViewModel(String nickname) {
    this.nickname = nickname;
    fetchDetail();
    _fetchFavoriteCharacter();
  }

  void fetchDetail() async {
    isLoading = true;
    _info = await DIController.characterService.fetchCharacterInfo(nickname);
    _armorySiblings =
        await DIController.characterService.fetchSiblings(nickname);
    isLoading = false;
    notifyListeners();
  }

  void fetchAnotherUserDetail(String nickname) async {
    isLoading = true;
    this.nickname = nickname;
    selectedTab = DetailViewTab.main;
    _info = await DIController.characterService.fetchCharacterInfo(nickname);
    _armorySiblings =
        await DIController.characterService.fetchSiblings(nickname);
    isLoading = false;
    notifyListeners();
  }

  void changeTab(DetailViewTab tab) {
    this.selectedTab = tab;
    notifyListeners();
  }

  void favButtonTap() async {
    if (isFavCharacter) {
      // 이미 즐겨찾기에 등록된 캐릭터인 경우 -> 삭제
      await DIController.characterService.removeFavoriteCharacter();
    } else {
      await DIController.characterService.saveFavoriteCharacter(info);
    }
    _fetchFavoriteCharacter(); // 즐겨찾기 변경 후 정보 갱신
  }

  void _fetchFavoriteCharacter() async {
    _favoriteCharacter =
        await DIController.characterService.fetchFavoriteCharacter();
    notifyListeners();
  }
}
