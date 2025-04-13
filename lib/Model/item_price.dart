class ItemPrice {
  String itemName;
  List<ItemPriceData> prices;

  ItemPrice({required this.itemName, required this.prices});

  factory ItemPrice.fromJson(Map<String, dynamic> jsonData) {
    return ItemPrice(
        itemName: jsonData["Name"],
        prices: (jsonData["Stats"] as List)
            .map((e) => ItemPriceData.fromJson(e))
            .toList());
  }
}

class ItemPriceData {
  String date;
  double avgPrice;
  int tradeCnt;

  ItemPriceData(
      {required this.date, required this.avgPrice, required this.tradeCnt});

  factory ItemPriceData.fromJson(Map<String, dynamic> jsonData) {
    return ItemPriceData(
        date: jsonData["Date"],
        avgPrice: jsonData["AvgPrice"],
        tradeCnt: jsonData["TradeCount"]);
  }
}
