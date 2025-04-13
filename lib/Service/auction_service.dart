import 'package:result_dart/result_dart.dart';
import 'package:sample_project/Model/auction_category.dart';
import 'package:sample_project/Model/auction_item.dart';
import 'package:sample_project/Repository/auction_repository.dart';

abstract interface class AuctionNetworkService {
  Future<Result<List<AuctionCategory>, Exception>> fetchAuctionCategories();
  Future<Result<List<AuctionItem>, Exception>> fetchItemList(
      AuctionCategory category);
}

class AuctionService implements AuctionNetworkService {
  AuctionRepository repository = NetworkAuctionRepository();

  @override
  Future<Result<List<AuctionCategory>, Exception>> fetchAuctionCategories() {
    return repository.fetchAuctionCategories();
  }

  @override
  Future<Result<List<AuctionItem>, Exception>> fetchItemList(
      AuctionCategory category) {
    return repository.fetchItemList(category);
  }
}
