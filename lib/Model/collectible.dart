class Collectible {
  final String type;
  final String icon;
  final int point;
  final int maxPoint;

  const Collectible(
      {required this.type,
      required this.icon,
      required this.point,
      required this.maxPoint});

  factory Collectible.fromJson(Map<String, dynamic> json) {
    return Collectible(
        type: json["Type"],
        icon: json["Icon"],
        point: json["Point"],
        maxPoint: json["MaxPoint"]);
  }

  Map<String, dynamic> toJson() {
    return {"Type": type, "Icon": icon, "Point": point, "MaxPoint": maxPoint};
  }
}
