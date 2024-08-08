import 'dart:math';

import 'package:flutter/material.dart';
import 'package:result_dart/result_dart.dart';
import 'package:sample_project/DI/di_controller.dart';
import 'package:sample_project/Model/notice.dart';
import 'package:sample_project/Screen/Notice/notice_view.dart';

class NoticeViewModel extends ChangeNotifier {
  List<Notice> _noticeList = [];
  List<Notice> get noticeList {
    int firstIdx = (page - 1) * itemPerPage;
    int lastIdx = min(firstIdx + (itemPerPage - 1), _noticeList.length);
    return _noticeList.sublist(firstIdx, lastIdx);
  }

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  int _page = 1;
  int get page => _page;

  int get maxPage {
    return (_noticeList.length / (_itemPerPage)).ceil();
  }

  int _itemPerPage = 15;
  int get itemPerPage => _itemPerPage;

  String _filter = "전체";
  String get filter => _filter;

  NoticeViewModel() {
    fetchNoticeList();
  }

  void fetchNoticeList() async {
    _isLoading = true;
    _page = 1;
    notifyListeners();
    Result<List<Notice>, Exception> result =
        await DIController.services.newsService.fetchNoticeList();

    result.fold((list) {
      _noticeList = list.where(noticeFilter).toList();
    }, (err) {
      //에러처리
    });

    _isLoading = false;
    notifyListeners();
  }

  bool noticeFilter(Notice notice) {
    if (filter == "전체") {
      return true;
    } else {
      return notice.type == filter;
    }
  }

  void changeFilter(String filter) {
    _filter = filter;
    fetchNoticeList();
    notifyListeners();
  }

  void lastPageButtonTap() {
    // >>
    _page = maxPage;
    notifyListeners();
  }

  void nextPageButtonTap() {
    // >
    _page += 1;
    notifyListeners();
  }

  void prevPageButtonTap() {
    // <
    _page -= 1;
    notifyListeners();
  }

  void firstPageButtonTap() {
    // <<
    _page = 1;
    notifyListeners();
  }
}
