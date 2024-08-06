class Event {
  final String title;
  final String thumbnail;
  final String link;
  final String startDate;
  final String endDate;
  final String? rewardDate;

  const Event(
      {required this.title,
      required this.thumbnail,
      required this.link,
      required this.startDate,
      required this.endDate,
      this.rewardDate});

  factory Event.fromJSON(Map<String, dynamic> json) {
    return Event(
        title: json["Title"],
        thumbnail: json["Thumbnail"],
        link: json["Link"],
        startDate: json["StartDate"],
        endDate: json["EndDate"],
        rewardDate: json["RewardDate"]);
  }

  Map<String, dynamic> toJson() {
    return {
      "Title": title,
      "Thumbnail": thumbnail,
      "Link": link,
      "StartDate": startDate,
      "EndDate": endDate,
      "RewardDate": rewardDate
    };
  }
}
