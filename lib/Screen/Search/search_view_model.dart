import 'package:flutter/material.dart';

class SearchViewModel extends ChangeNotifier {
  String _keyword = "";

  void changeKeyword(String newKeyword) {
    _keyword = newKeyword;
    print(newKeyword);
  }
}
