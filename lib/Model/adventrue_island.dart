class AdventrueIslandCalendar {
  final List<AdventrueIsland> gameContents;

  bool get isOnFieldBossDay {
    DateTime today = DateTime.now();
    return today.weekday == 2 || today.weekday == 5 || today.weekday == 7;
  }

  bool get isOnChaosGateDay {
    DateTime today = DateTime.now();
    return today.weekday == 1 ||
        today.weekday == 4 ||
        today.weekday == 6 ||
        today.weekday == 7;
  }

  List<AdventrueIsland> get adventrueIslands =>
      gameContents.where((i) => i.categoryName == "모험 섬").toList();

  List<AdventrueIsland> get todayAdventrueIslands {
    List<AdventrueIsland> result = adventrueIslands
        .where((i) =>
            i.startTimes != null && _checkTodayAdventureIsland(i.startTimes!))
        .toList();

    result.sort((i1, i2) {
      return i1.todayStartTime.first.compareTo(i2.todayStartTime.first);
    });

    return result;
  }

  bool _checkTodayAdventureIsland(List<String> dates) {
    DateTime today = DateTime.now();
    bool result = false;

    for (String date in dates) {
      DateTime dateTime = DateTime.parse(date);
      if (dateTime.year == today.year &&
          dateTime.month == today.month &&
          dateTime.day == today.day) {
        result = true;
        break;
      }
    }

    return result;
  }

  const AdventrueIslandCalendar({required this.gameContents});

  factory AdventrueIslandCalendar.fromJSON(List<dynamic> json) {
    return AdventrueIslandCalendar(
        gameContents:
            (json as List).map((e) => AdventrueIsland.fromJSON(e)).toList());
  }
}

class AdventrueIsland {
  final String categoryName;
  final String contentsName;
  final String contentsIcon;
  final List<String>? startTimes;
  final String location;
  final List<RewardItem> rewards;
  final MainRewardType mainRewardType;

  List<String> get todayStartTime {
    List<String> result = [];

    if (startTimes != null) {
      for (String date in startTimes!) {
        DateTime today = DateTime.now();
        DateTime dateTime = DateTime.parse(date);
        if (dateTime.year == today.year &&
            dateTime.month == today.month &&
            dateTime.day == today.day) {
          // startTimes 목록 중에 오늘 날짜가 포함되어있는지 확인
          result.add(date);
        }
      }
    }

    return result;
  }

  const AdventrueIsland({
    required this.categoryName,
    required this.contentsName,
    required this.contentsIcon,
    required this.startTimes,
    required this.location,
    required this.rewards,
    required this.mainRewardType,
  });

  factory AdventrueIsland.fromJSON(Map<String, dynamic> json) {
    List<RewardItem> rewards =
        (((json["RewardItems"] as List)[0]["Items"] as List)
            .map((e) => RewardItem.fromJSON(e))
            .toList());

    MainRewardType rewardType = MainRewardType.siling;

    rewards.forEach((r) {
      r.startTimes?.forEach((date) {
        DateTime today = DateTime.now();
        DateTime dateTime = DateTime.parse(date);
        if (dateTime.year == today.year &&
            dateTime.month == today.month &&
            dateTime.day == today.day) {
          // startTimes 목록 중에 오늘 날짜가 포함되어있는지 확인
          if (r.name == "골드") {
            rewardType = MainRewardType.gold;
          } else if (r.name.contains("카드 팩")) {
            rewardType = MainRewardType.card;
          } else if (r.name == "대양의 주화 상자") {
            rewardType = MainRewardType.coin;
          }
        }
      });
    });

    return AdventrueIsland(
      categoryName: json["CategoryName"],
      contentsName: json["ContentsName"],
      contentsIcon: json["ContentsIcon"],
      startTimes: json["StartTimes"] != null
          ? (json["StartTimes"] as List).map((e) => e.toString()).toList()
          : null,
      location: json["Location"],
      rewards: rewards,
      mainRewardType: rewardType,
    );
  }
}

class RewardItem {
  final String name;
  final String icon;
  final List<String>? startTimes;

  const RewardItem({required this.name, required this.icon, this.startTimes});

  factory RewardItem.fromJSON(Map<String, dynamic> json) {
    return RewardItem(
      name: json["Name"],
      icon: json["Icon"],
      startTimes: json["StartTimes"] == null
          ? null
          : (json["StartTimes"] as List).map((e) => e.toString()).toList(),
    );
  }
}

enum MainRewardType {
  gold,
  siling,
  card,
  coin;

  String get icon {
    if (this == MainRewardType.gold) {
      return "https://cdn-lostark.game.onstove.com/efui_iconatlas/money/money_4.png";
    } else if (this == MainRewardType.card) {
      return "https://cdn-lostark.game.onstove.com/efui_iconatlas/use/use_10_236.png";
    } else if (this == MainRewardType.siling) {
      return "https://cdn-lostark.game.onstove.com/efui_iconatlas/etc/etc_14.png";
    } else if (this == MainRewardType.coin) {
      return "https://cdn-lostark.game.onstove.com/efui_iconatlas/use/use_2_8.png";
    } else {
      return "";
    }
  }
}
