import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:result_dart/result_dart.dart';
import 'package:sample_project/Constant/constant.dart';
import 'package:sample_project/Model/market_category.dart';
import 'package:sample_project/Model/market_item.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:http/http.dart' as http;

abstract class MarketRepository {
  Future<Result<List<MarketCategory>, Exception>> fetchMarketCategories();
  Future<Result<List<MarketItem>, Exception>> fetchItemList(
      MarketCategory category);
}

class NetworkMarketRepository extends MarketRepository {
  final supabase = Supabase.instance.client;
  final marketCategoryTable = K.appConfig.supabaseMarketCategoryTable;
  final marketItemTable = K.appConfig.supabaseMarketItemTable;

  @override
  Future<Result<List<MarketCategory>, Exception>>
      fetchMarketCategories() async {
    try {
      final result = await supabase
          .from(marketCategoryTable)
          .select("*")
          .order("Order", ascending: true);

      List<MarketCategory> categories =
          result.map((e) => MarketCategory.fromJson(e)).toList();

      categories.sort((a, b) => a.order.compareTo(b.order));

      return Success(categories);
    } catch (e) {
      return Failure(Exception(e));
    }
  }

  @override
  Future<Result<List<MarketItem>, Exception>> fetchItemList(
      MarketCategory category) async {
    try {
      final items = await supabase
          .from(marketItemTable)
          .select("*")
          .eq("CategoryId", category.id)
          .order("Order", ascending: true);

      List<MarketItem> itemList =
          items.map((e) => MarketItem.fromJson(e)).toList();

      for (MarketItem m in itemList) {
        //오늘의 시세가 조회되지 않은 경우
        var url = Uri.parse('${K.lostArkAPI.base}markets/items');
        var client = http.Client();

        var response = await client.post(url, headers: {
          'Authorization': 'Bearer ${dotenv.env["API_KEY"]}'
        }, body: {
          "CategoryCode": m.categoryCode.toString(),
          "ItemName": m.itemName,
          "ItemGrade": m.grade
        });

        if (response.statusCode == 200) {
          final responseJson = jsonDecode(response.body);
          Map<String, dynamic> itemData = responseJson["Items"][0];
          LoaAPIMarketPrice loaAPIMarketPrice =
              LoaAPIMarketPrice.fromJson(itemData);

          m.price = loaAPIMarketPrice.recentPrice;
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
}
