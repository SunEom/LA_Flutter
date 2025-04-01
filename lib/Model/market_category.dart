class MarketCategory {
  int id;
  String name;
  int order;

  MarketCategory({required this.id, required this.name, required this.order});

  factory MarketCategory.fromJson(Map<String, dynamic> jsonData) {
    return MarketCategory(
        id: jsonData["id"],
        name: jsonData["CategoryName"],
        order: jsonData["Order"]);
  }
}
