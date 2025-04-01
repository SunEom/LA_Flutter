import 'package:flutter/material.dart';
import 'package:sample_project/DI/di_controller.dart';
import 'package:sample_project/Model/market_category.dart';
import 'package:sample_project/Model/market_item.dart';

class MarketViewModel extends ChangeNotifier {
  List<MarketCategory> _categories = [];
  List<MarketCategory> get categories => _categories;

  List<MarketViewItem> _marketItems = [];
  List<MarketViewItem> get marketItems => _marketItems;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  MarketViewModel() {
    _fetchMarketItemCategories();
  }

  void _fetchMarketItemCategories() async {
    _isLoading = true;
    notifyListeners();
    final categories =
        await DIController.services.marketService.fetchItemCategories();

    categories.fold((data) async {
      _categories = data;

      _marketItems = [];
      for (MarketCategory c in _categories) {
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
}

class MarketViewItem {
  MarketCategory category;
  List<MarketItem> items;

  MarketViewItem({required this.category, required this.items});
}
