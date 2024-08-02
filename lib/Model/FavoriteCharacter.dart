class FavoriteCharacter {
  final String name;
  final String itemAvgLevel;
  final String serverName;
  final String className;

  const FavoriteCharacter(
      {required this.name,
      required this.itemAvgLevel,
      required this.serverName,
      required this.className});

  factory FavoriteCharacter.fromJSON(Map<String, dynamic> json) {
    return FavoriteCharacter(
        name: json["name"],
        itemAvgLevel: json["itemAvgLevel"],
        serverName: json["serverName"],
        className: json["className"]);
  }

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "itemAvgLevel": itemAvgLevel,
      "serverName": serverName,
      "className": className
    };
  }
}
