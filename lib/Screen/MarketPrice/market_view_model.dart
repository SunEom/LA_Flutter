import 'dart:math';

import 'package:flutter/material.dart';
import 'package:sample_project/DI/di_controller.dart';
import 'package:sample_project/Model/auction_category.dart';
import 'package:sample_project/Model/auction_item.dart';
import 'package:sample_project/Model/item_price.dart';
import 'package:sample_project/Model/market_category.dart';
import 'package:sample_project/Model/market_item.dart';

enum MarketViewTab {
  market,
  auction;

  static List<MarketViewTab> get defaultOrder {
    return [MarketViewTab.market, MarketViewTab.auction];
  }

  String get displayName {
    switch (this) {
      case MarketViewTab.market:
        return "재련재료 & 각인서";
      case MarketViewTab.auction:
        return "보석";
    }
  }
}

class MarketViewModel extends ChangeNotifier {
  MarketViewTab _currentTab = MarketViewTab.market;
  MarketViewTab get currentTab => _currentTab;

  List<MarketCategory> _marketCategories = [];
  List<MarketCategory> get marketCategories => _marketCategories;

  List<MarketViewItem> _marketItems = [];
  List<MarketViewItem> get marketItems => _marketItems;

  List<AuctionCategory> _auctionCategories = [];
  List<AuctionCategory> get auctionCategories => _auctionCategories;

  List<AuctionViewItem> _auctionItems = [];
  List<AuctionViewItem> get auctionItems => _auctionItems;

  MarketItem? _openItem = null;
  MarketItem? get openItem => _openItem;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  bool _isAccordianLoading = false;
  bool get isAccordianLoading => _isAccordianLoading;

  ItemPrice? _itemPrice = null;
  ItemPrice? get itemPrice => _itemPrice;

  MarketViewModel() {
    _fetchMarketItemCategories();
    _fetchAuctionItemCategories();
  }

// ------------------ 거래소 관련 시작 ----------------------------

  void _fetchMarketItemCategories() async {
    _isLoading = true;
    notifyListeners();
    final categories =
        await DIController.services.marketService.fetchItemCategories();

    categories.fold((data) async {
      _marketCategories = data;

      _marketItems = [];
      for (MarketCategory c in _marketCategories) {
        await _fetchMarketItems(c);
      }

      _isLoading = false;
      notifyListeners();
    }, (e) {});
  }

  Future<void> _fetchMarketItems(MarketCategory category) async {
    final itemList =
        await DIController.services.marketService.fetchItemList(category);

    itemList.fold((data) {
      _marketItems.add(MarketViewItem(category: category, items: data));
    }, (e) {});
  }

  // ------------------ 거래소 관련 끝 ----------------------------

  // ------------------ 경매장 관련 시작 ----------------------------
  void _fetchAuctionItemCategories() async {
    _isLoading = true;
    notifyListeners();
    final categories =
        await DIController.services.auctionService.fetchAuctionCategories();

    categories.fold((data) async {
      _auctionCategories = data;

      _auctionItems = [];
      for (AuctionCategory c in _auctionCategories) {
        await _fetchAuctionItems(c);
      }

      _isLoading = false;
      notifyListeners();
    }, (e) {});
  }

  Future<void> _fetchAuctionItems(AuctionCategory category) async {
    final itemList =
        await DIController.services.auctionService.fetchItemList(category);

    itemList.fold((data) {
      _auctionItems.add(AuctionViewItem(category: category, items: data));
    }, (e) {});
  }

  // ------------------ 경매장 관련 끝 ----------------------------

  void onClickAccordianButton(MarketItem item) async {
    if (_openItem?.id == item.id) {
      _openItem = null;
    } else {
      _openItem = item;
    }

    _isAccordianLoading = true;
    notifyListeners();
    final result = await DIController.services.marketService
        .fetchItemRecentPriceList(item);

    result.fold((data) {
      _itemPrice = data;
    }, (e) {});

    _isAccordianLoading = false;

    notifyListeners();
  }

  double? getMinPrice() {
    if (itemPrice == null) {
      return 0;
    } else {
      double minValue = itemPrice!.prices.first.avgPrice;

      for (ItemPriceData p in itemPrice!.prices) {
        minValue = min(minValue, p.avgPrice);
      }
      return minValue;
    }
  }

  double? getMaxPrice() {
    if (itemPrice == null) {
      return 0;
    } else {
      double maxValue = itemPrice!.prices.first.avgPrice;

      for (ItemPriceData p in itemPrice!.prices) {
        maxValue = max(maxValue, p.avgPrice);
      }
      return maxValue;
    }
  }

  void changeTab(MarketViewTab tab) {
    _currentTab = tab;
    notifyListeners();
  }
}

class MarketViewItem {
  MarketCategory category;
  List<MarketItem> items;

  MarketViewItem({required this.category, required this.items});
}

class AuctionViewItem {
  AuctionCategory category;
  List<AuctionItem> items;

  AuctionViewItem({required this.category, required this.items});
}
