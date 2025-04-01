import 'package:result_dart/result_dart.dart';
import 'package:sample_project/Model/market_category.dart';
import 'package:sample_project/Model/market_item.dart';
import 'package:sample_project/Repository/market_repository.dart';

abstract interface class MarketServiceType {
  Future<Result<List<MarketCategory>, Exception>> fetchItemCategories();
  Future<Result<List<MarketItem>, Exception>> fetchItemList(
      MarketCategory category);
}

class MarketService implements MarketServiceType {
  NetworkMarketRepository networkMarketRepository = NetworkMarketRepository();

  @override
  Future<Result<List<MarketCategory>, Exception>> fetchItemCategories() {
    return networkMarketRepository.fetchMarketCategories();
  }

  @override
  Future<Result<List<MarketItem>, Exception>> fetchItemList(
      MarketCategory category) {
    return networkMarketRepository.fetchItemList(category);
  }
}
