class AuctionCategory {
  int id;
  String name;
  int order;

  AuctionCategory({required this.id, required this.name, required this.order});

  factory AuctionCategory.fromJson(Map<String, dynamic> jsonData) {
    return AuctionCategory(
        id: jsonData["id"],
        name: jsonData["CategoryName"],
        order: jsonData["Order"]);
  }
}
