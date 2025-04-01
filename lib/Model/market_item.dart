class MarketItem {
  int id;
  String itemName;
  int categoryCode;
  String icon;
  int order;
  String grade;
  int price;

  MarketItem(
      {required this.id,
      required this.itemName,
      required this.categoryCode,
      required this.icon,
      required this.order,
      required this.grade,
      required this.price});

  factory MarketItem.fromJson(Map<String, dynamic> jsonData) {
    return MarketItem(
        id: jsonData["id"],
        itemName: jsonData["ItemName"],
        categoryCode: jsonData["CategoryCode"],
        icon: jsonData["Icon"],
        order: jsonData["Order"],
        grade: jsonData["Grade"],
        price: jsonData["Price"] ?? 0);
  }
}

class LoaAPIMarketPrice {
  String name;
  int recentPrice;

  LoaAPIMarketPrice({required this.name, required this.recentPrice});

  factory LoaAPIMarketPrice.fromJson(Map<String, dynamic> jsonData) {
    return LoaAPIMarketPrice(
        name: jsonData["Name"], recentPrice: jsonData["RecentPrice"]);
  }
}
