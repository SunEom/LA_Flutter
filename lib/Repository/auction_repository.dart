import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:result_dart/result_dart.dart';
import 'package:sample_project/Constant/constant.dart';
import 'package:sample_project/Model/auction_category.dart';
import 'package:sample_project/Model/auction_item.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:http/http.dart' as http;

abstract class AuctionRepository {
  Future<Result<List<AuctionCategory>, Exception>> fetchAuctionCategories();
  Future<Result<List<AuctionItem>, Exception>> fetchItemList(
      AuctionCategory category);
}

class NetworkAuctionRepository extends AuctionRepository {
  final supabase = Supabase.instance.client;
  final auctionCategoryTable = K.appConfig.supabaseAuctionCategoryTable;
  final auctionItemTable = K.appConfig.supabaseAuctionItemTable;

  @override
  Future<Result<List<AuctionCategory>, Exception>>
      fetchAuctionCategories() async {
    try {
      final result = await supabase
          .from(auctionCategoryTable)
          .select("*")
          .order("Order", ascending: true);

      List<AuctionCategory> categories =
          result.map((e) => AuctionCategory.fromJson(e)).toList();
      categories.sort((a, b) => a.order.compareTo(b.order));

      return Success(categories);
    } catch (e) {
      return Failure(Exception(e));
    }
  }

  @override
  Future<Result<List<AuctionItem>, Exception>> fetchItemList(
      AuctionCategory category) async {
    try {
      final items = await supabase
          .from(auctionItemTable)
          .select("*")
          .eq("CategoryId", category.id)
          .order("Order", ascending: true);

      List<AuctionItem> itemList =
          items.map((e) => AuctionItem.fromJson(e)).toList();

      for (AuctionItem m in itemList) {
        var url = Uri.parse('${K.lostArkAPI.base}auctions/items');
        var client = http.Client();

        var response = await client.post(url, headers: {
          'Authorization': 'Bearer ${dotenv.env["API_KEY"]}'
        }, body: {
          "CategoryCode": m.categoryCode.toString(),
          "ItemName": m.itemName,
          "Sort": "BUY_PRICE",
          "SortCondition": "ASC"
        });

        if (response.statusCode == 200) {
          final responseJson = jsonDecode(response.body);
          Map<String, dynamic> itemData = responseJson["Items"][0];
          LoaAPIAuctionPrice loaAPIAuctionPrice =
              LoaAPIAuctionPrice.fromJson(itemData);

          m.price = loaAPIAuctionPrice.price;
        } else {
          // 에러 처리
          return Result.failure(Exception("HTTP 응답 오류"));
        }
      }

      return Success(itemList);
    } catch (e) {
      return Failure(Exception(e));
    }
  }

  // Future<Result<ItemPrice, Exception>> fetchItemRecentPriceList(
  //     MarketItem item) async {
  //   try {
  //     //오늘의 시세가 조회되지 않은 경우
  //     var url = Uri.parse('${K.lostArkAPI.base}markets/items/${item.itemId}');
  //     var client = http.Client();

  //     var response = await client.get(url,
  //         headers: {'Authorization': 'Bearer ${dotenv.env["API_KEY"]}'});

  //     if (response.statusCode == 200) {
  //       final responseJson = jsonDecode(response.body);

  //       return Success(ItemPrice.fromJson(responseJson[0]));
  //     }
  //     return Result.failure(Exception("HTTP 응답 오류"));
  //   } catch (e) {
  //     return Failure(Exception(e));
  //   }
  //  }
}
