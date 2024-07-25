import 'package:flutter/material.dart';
import 'package:sample_project/DI/DIController.dart';

class HomeViewModel with ChangeNotifier {
  String _nickname = "가니잇";
  String get nickname => _nickname;

  void nicknameChanged(String nickname) {
    _nickname = nickname;
  }

  void fetchInfo() async {
    DIController.characterService.fetchCharacterInfo(_nickname);
  }
}
