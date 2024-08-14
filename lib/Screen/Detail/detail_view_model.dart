import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:result_dart/result_dart.dart';
import 'package:sample_project/DI/di_controller.dart';
import 'package:sample_project/Model/character.dart';
import 'package:sample_project/Model/favorite_character.dart';
import 'package:sample_project/Model/sibling.dart';

enum DetailViewTab {
  main,
  skill,
  armory,
  collectibles;

  static List<DetailViewTab> get defaultOrder {
    return [
      DetailViewTab.main,
      DetailViewTab.skill,
      DetailViewTab.armory,
      DetailViewTab.collectibles
    ];
  }

  String get displayName {
    switch (this) {
      case DetailViewTab.main:
        return "메인";

      case DetailViewTab.skill:
        return "스킬";

      case DetailViewTab.armory:
        return "원정대";

      case DetailViewTab.collectibles:
        return "내실";
    }
  }
}

class DetailViewModel extends ChangeNotifier {
  late String nickname;
  CharacterInfo? _info;
  CharacterInfo? get info => _info;
  bool isLoading = true;
  DetailViewTab selectedTab = DetailViewTab.main;
  ArmorySiblings? _armorySiblings;
  ArmorySiblings? get armorySiblings => _armorySiblings;

  FavoriteCharacter? _favoriteCharacter;
  FavoriteCharacter? get favoriteCharacter => _favoriteCharacter;

  String? _alertData;
  String? get alertData => _alertData;

  bool get isFavCharacter {
    if (_info == null || _favoriteCharacter == null) {
      return false;
    }

    return favoriteCharacter!.name == info!.armoryProfile.characterName;
  }

  DetailViewModel(this.nickname) {
    fetchDetail();
    _fetchFavoriteCharacter();
  }

  Future<void> reloadData() async {
    fetchDetail();
    _fetchFavoriteCharacter();
  }

  void fetchDetail() async {
    isLoading = true;

    Result<Option<CharacterInfo>, Exception> fetchCharacterInfoResult =
        await DIController.services.characterService
            .fetchCharacterInfo(nickname);
    fetchCharacterInfoResult.fold((info) {
      _info = info.toNullable();
    }, (err) {
      _alertData = err.toString();
    });

    Result<ArmorySiblings, Exception> fetchSiblingsResult =
        await DIController.services.characterService.fetchSiblings(nickname);

    fetchSiblingsResult.fold((siblings) {
      _armorySiblings = siblings;
    }, (err) {
      _alertData = err.toString();
    });

    isLoading = false;
    notifyListeners();
  }

  void fetchAnotherUserDetail(String nickname) async {
    this.nickname = nickname;
    changeTab(DetailViewTab.main);
    fetchDetail();
    notifyListeners();
  }

  void changeTab(DetailViewTab tab) {
    selectedTab = tab;
    notifyListeners();
  }

  void favButtonTap() async {
    if (isFavCharacter) {
      // 이미 즐겨찾기에 등록된 캐릭터인 경우 -> 삭제
      await DIController.services.characterService.removeFavoriteCharacter();
    } else {
      await DIController.services.characterService.saveFavoriteCharacter(info);
    }
    _fetchFavoriteCharacter(); // 즐겨찾기 변경 후 정보 갱신
  }

  void _fetchFavoriteCharacter() async {
    Result<FavoriteCharacter, Exception> result =
        await DIController.services.characterService.fetchFavoriteCharacter();
    result.fold((character) {
      _favoriteCharacter = character;
    }, (err) {
      _favoriteCharacter = null;
    });
    notifyListeners();
  }

  void resetAlertData() {
    _alertData = null;
  }
}
