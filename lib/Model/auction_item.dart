class AuctionItem {
  int id;
  String itemName;
  int categoryCode;
  String icon;
  int order;
  String grade;
  int price;

  AuctionItem(
      {required this.id,
      required this.itemName,
      required this.categoryCode,
      required this.icon,
      required this.order,
      required this.grade,
      required this.price});

  factory AuctionItem.fromJson(Map<String, dynamic> jsonData) {
    return AuctionItem(
        id: jsonData["id"],
        itemName: jsonData["ItemName"],
        categoryCode: jsonData["CategoryCode"],
        icon: jsonData["Icon"],
        order: jsonData["Order"],
        grade: jsonData["Grade"],
        price: jsonData["Price"] ?? 0);
  }
}

class LoaAPIAuctionPrice {
  String name;
  int price;

  LoaAPIAuctionPrice({required this.name, required this.price});

  factory LoaAPIAuctionPrice.fromJson(Map<String, dynamic> jsonData) {
    var price = jsonData["AuctionInfo"]["BuyPrice"] ?? 0;
    return LoaAPIAuctionPrice(name: jsonData["Name"], price: price);
  }
}
