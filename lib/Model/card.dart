class ArmoryCard {
  final List<Card> cards;
  final List<List<CardEffect>>? cardEffects;

  ArmoryCard({required this.cards, required this.cardEffects});

  factory ArmoryCard.fromJson(Map<String, dynamic> json) {
    return ArmoryCard(
        cards: (json["Cards"] as List)
            .map((jsonItem) => Card.fromJson(jsonItem))
            .toList(),
        cardEffects: json["Effects"] == null
            ? null
            : (json["Effects"] as List).map((jsonItem) {
                return (jsonItem["Items"] as List)
                    .map((item) => CardEffect.fromJson(item))
                    .toList();
              }).toList());
  }
}

class Card {
  final String name;
  final String icon;
  final int awakeCount;

  Card({required this.name, required this.icon, required this.awakeCount});

  factory Card.fromJson(Map<String, dynamic> json) {
    return Card(
        name: json["Name"], icon: json["Icon"], awakeCount: json["AwakeCount"]);
  }

  Map<String, dynamic> toJson() {
    return {"Name": name, "Icon": icon, "AwakeCount": awakeCount};
  }
}

class CardEffect {
  final String name;

  CardEffect({required this.name});

  factory CardEffect.fromJson(Map<String, dynamic> json) {
    return CardEffect(name: json["Name"]);
  }

  Map<String, dynamic> toJson() {
    return {"Name": name};
  }
}


// {
//   "ArmoryCard": {
//     "Cards": [
//       {
//         "Slot": 0,
//         "Name": "원포",
//         "Icon": "https://cdn-lostark.game.onstove.com/efui_iconatlas/card_rare/card_rare_04_4.png",
//         "AwakeCount": 5,
//         "AwakeTotal": 5,
//         "Grade": "희귀",
//         "Tooltip": "{\r\n  \"Element_000\": {\r\n    \"type\": \"NameTagBox\",\r\n    \"value\": \"<FONT COLOR='#00B0FA'>원포</FONT>\"\r\n  },\r\n  \"Element_001\": {\r\n    \"type\": \"Card\",\r\n    \"value\": {\r\n      \"awakeCount\": 5,\r\n      \"awakeTotal\": 5,\r\n      \"cardStack\": \"\",\r\n      \"iconData\": {\r\n        \"iconPath\": \"https://cdn-lostark.game.onstove.com/efui_iconatlas/card_rare/card_rare_04_4.png\"\r\n      },\r\n      \"isBookMark\": false,\r\n      \"tierGrade\": 3\r\n    }\r\n  },\r\n  \"Element_002\": {\r\n    \"type\": \"SingleTextBox\",\r\n    \"value\": \"창천비무제의 창천사검. 연가문 소속이었지만, 아내의 병을 고치기 위해 어두운 길로 발을 들였다.\"\r\n  },\r\n  \"Element_003\": {\r\n    \"type\": \"SingleTextBox\",\r\n    \"value\": \"<Font color='#5FD3F1'>[카오스 던전] 3티어</font><BR><Font color='#5FD3F1'>[쿠르잔 전선] </font><BR><font color='#97fffd'>[카드팩] 노래하는 혹한 카드 팩</font><BR><font color='#97fffd'>[카드팩] 신비한 풍류의 카드 팩</font><BR>\"\r\n  }\r\n}"
//       },
//       {
//         "Slot": 1,
//         "Name": "헨리",
//         "Icon": "https://cdn-lostark.game.onstove.com/efui_iconatlas/card_uncommon/card_uncommon_04_2.png",
//         "AwakeCount": 5,
//         "AwakeTotal": 5,
//         "Grade": "고급",
//         "Tooltip": "{\r\n  \"Element_000\": {\r\n    \"type\": \"NameTagBox\",\r\n    \"value\": \"<FONT COLOR='#8DF901'>헨리</FONT>\"\r\n  },\r\n  \"Element_001\": {\r\n    \"type\": \"Card\",\r\n    \"value\": {\r\n      \"awakeCount\": 5,\r\n      \"awakeTotal\": 5,\r\n      \"cardStack\": \"\",\r\n      \"iconData\": {\r\n        \"iconPath\": \"https://cdn-lostark.game.onstove.com/efui_iconatlas/card_uncommon/card_uncommon_04_2.png\"\r\n      },\r\n      \"isBookMark\": false,\r\n      \"tierGrade\": 2\r\n    }\r\n  },\r\n  \"Element_002\": {\r\n    \"type\": \"SingleTextBox\",\r\n    \"value\": \"금방 사랑에 빠져버리는 남자. 사랑과 관련된 일이라면 각종 착각과 환상에 빠져 있다.\"\r\n  },\r\n  \"Element_003\": {\r\n    \"type\": \"SingleTextBox\",\r\n    \"value\": \"<Font color='#5FD3F1'>[호감도] 리베하임 - 연애 고수 헨리</font><BR><Font color='#5FD3F1'>[카오스 던전] 3티어</font><BR><Font color='#5FD3F1'>[쿠르잔 전선] </font><BR><font color='#97fffd'>[카드팩] 조화로운 바다 카드 팩</font><BR>\"\r\n  }\r\n}"
//       },
//       {
//         "Slot": 2,
//         "Name": "프랭크",
//         "Icon": "https://cdn-lostark.game.onstove.com/efui_iconatlas/card_uncommon/card_uncommon_04_1.png",
//         "AwakeCount": 5,
//         "AwakeTotal": 5,
//         "Grade": "고급",
//         "Tooltip": "{\r\n  \"Element_000\": {\r\n    \"type\": \"NameTagBox\",\r\n    \"value\": \"<FONT COLOR='#8DF901'>프랭크</FONT>\"\r\n  },\r\n  \"Element_001\": {\r\n    \"type\": \"Card\",\r\n    \"value\": {\r\n      \"awakeCount\": 5,\r\n      \"awakeTotal\": 5,\r\n      \"cardStack\": \"\",\r\n      \"iconData\": {\r\n        \"iconPath\": \"https://cdn-lostark.game.onstove.com/efui_iconatlas/card_uncommon/card_uncommon_04_1.png\"\r\n      },\r\n      \"isBookMark\": false,\r\n      \"tierGrade\": 2\r\n    }\r\n  },\r\n  \"Element_002\": {\r\n    \"type\": \"SingleTextBox\",\r\n    \"value\": \"별빛 등대의 섬에 있는 등대지기. 세상에 떠도는 영혼들을 하늘로 올려 보내기 위해 피아노를 연주한다.\"\r\n  },\r\n  \"Element_003\": {\r\n    \"type\": \"SingleTextBox\",\r\n    \"value\": \"<Font color='#5FD3F1'>[카오스 던전] 3티어</font><BR><Font color='#5FD3F1'>[쿠르잔 전선] </font><BR><font color='#97fffd'>[카드팩] 조화로운 바다 카드 팩</font><BR>\"\r\n  }\r\n}"
//       },
//       {
//         "Slot": 3,
//         "Name": "케이사르",
//         "Icon": "https://cdn-lostark.game.onstove.com/efui_iconatlas/card_epic/card_epic_03_6.png",
//         "AwakeCount": 5,
//         "AwakeTotal": 5,
//         "Grade": "영웅",
//         "Tooltip": "{\r\n  \"Element_000\": {\r\n    \"type\": \"NameTagBox\",\r\n    \"value\": \"<FONT COLOR='#CE43FC'>케이사르</FONT>\"\r\n  },\r\n  \"Element_001\": {\r\n    \"type\": \"Card\",\r\n    \"value\": {\r\n      \"awakeCount\": 5,\r\n      \"awakeTotal\": 5,\r\n      \"cardStack\": \"\",\r\n      \"iconData\": {\r\n        \"iconPath\": \"https://cdn-lostark.game.onstove.com/efui_iconatlas/card_epic/card_epic_03_6.png\"\r\n      },\r\n      \"isBookMark\": false,\r\n      \"tierGrade\": 4\r\n    }\r\n  },\r\n  \"Element_002\": {\r\n    \"type\": \"SingleTextBox\",\r\n    \"value\": \"욘을 다스리는 국왕. 침착하고 카리스마가 넘친다.\"\r\n  },\r\n  \"Element_003\": {\r\n    \"type\": \"SingleTextBox\",\r\n    \"value\": \"<Font color='#5FD3F1'>[물물교환] 욘 - 떠돌이 상인</font><BR><Font color='#5FD3F1'>[호감도] 위대한 성 - 케이사르</font><BR><Font color='#5FD3F1'>[카오스 던전] 3티어</font><BR><font color='#97fffd'>[카드팩] 단단한 용기의 카드 팩</font><BR><Font color='#5FD3F1'>그 외에 획득처가 더 존재합니다.</FONT>\"\r\n  }\r\n}"
//       },
//       {
//         "Slot": 4,
//         "Name": "베아트리스",
//         "Icon": "https://cdn-lostark.game.onstove.com/efui_iconatlas/card_legend/card_legend_01_6.png",
//         "AwakeCount": 5,
//         "AwakeTotal": 5,
//         "Grade": "전설",
//         "Tooltip": "{\r\n  \"Element_000\": {\r\n    \"type\": \"NameTagBox\",\r\n    \"value\": \"<FONT COLOR='#F99200'>베아트리스</FONT>\"\r\n  },\r\n  \"Element_001\": {\r\n    \"type\": \"Card\",\r\n    \"value\": {\r\n      \"awakeCount\": 5,\r\n      \"awakeTotal\": 5,\r\n      \"cardStack\": \"\",\r\n      \"iconData\": {\r\n        \"iconPath\": \"https://cdn-lostark.game.onstove.com/efui_iconatlas/card_legend/card_legend_01_6.png\"\r\n      },\r\n      \"isBookMark\": false,\r\n      \"tierGrade\": 5\r\n    }\r\n  },\r\n  \"Element_002\": {\r\n    \"type\": \"SingleTextBox\",\r\n    \"value\": \"주신 루페온에게 차원의 틈인 트리시온에서 세계를 관찰하는 임무를 부여 받은 라제니스. \"\r\n  },\r\n  \"Element_003\": {\r\n    \"type\": \"SingleTextBox\",\r\n    \"value\": \"<Font color='#5FD3F1'>[호감도] 트리시온 - 베아트리스</font><BR><Font color='#5FD3F1'>[어비스 던전] 카양겔</font><BR><Font color='#5FD3F1'>[어비스 던전] 혼돈의 상아탑</font><BR><Font color='#5FD3F1'>그 외에 획득처가 더 존재합니다.</FONT>\"\r\n  }\r\n}"
//       },
//       {
//         "Slot": 5,
//         "Name": "알레그로",
//         "Icon": "https://cdn-lostark.game.onstove.com/efui_iconatlas/card_epic/card_epic_00_3.png",
//         "AwakeCount": 5,
//         "AwakeTotal": 5,
//         "Grade": "영웅",
//         "Tooltip": "{\r\n  \"Element_000\": {\r\n    \"type\": \"NameTagBox\",\r\n    \"value\": \"<FONT COLOR='#CE43FC'>알레그로</FONT>\"\r\n  },\r\n  \"Element_001\": {\r\n    \"type\": \"Card\",\r\n    \"value\": {\r\n      \"awakeCount\": 5,\r\n      \"awakeTotal\": 5,\r\n      \"cardStack\": \"\",\r\n      \"iconData\": {\r\n        \"iconPath\": \"https://cdn-lostark.game.onstove.com/efui_iconatlas/card_epic/card_epic_00_3.png\"\r\n      },\r\n      \"isBookMark\": false,\r\n      \"tierGrade\": 4\r\n    }\r\n  },\r\n  \"Element_002\": {\r\n    \"type\": \"SingleTextBox\",\r\n    \"value\": \"평온해보이는 음유시인. 오래된 악기 하나를 들고 세상사를 노래한다. 왠지 세상의 이치를 모두 깨우치고 있는 듯한 느낌이 든다.\"\r\n  },\r\n  \"Element_003\": {\r\n    \"type\": \"SingleTextBox\",\r\n    \"value\": \"<Font color='#5FD3F1'>[탐색] 해무리 언덕</font><BR><Font color='#5FD3F1'>[카오스 던전] 3티어</font><BR><Font color='#5FD3F1'>[쿠르잔 전선] </font><BR><font color='#97fffd'>[카드팩] 용감한 기사의 카드 팩</font><BR><font color='#97fffd'>[카드팩] 단단한 용기의 카드 팩</font><BR>\"\r\n  }\r\n}"
//       }
//     ],
//     "Effects": [
//       {
//         "Index": 0,
//         "CardSlots": [
//           0,
//           1,
//           2,
//           3
//         ],
//         "Items": [
//           {
//             "Name": "사랑꾼 2세트",
//             "Description": "이동기 재사용 대기시간이 10% 감소한다."
//           },
//           {
//             "Name": "사랑꾼 4세트",
//             "Description": "이동기 사용 시 10%의 확률로 재사용 대기시간이 초기화된다."
//           },
//           {
//             "Name": "사랑꾼 4세트 (8각성합계)",
//             "Description": "이동 속도 +2.00%"
//           },
//           {
//             "Name": "사랑꾼 4세트 (12각성합계)",
//             "Description": "이동 속도 +3.00%"
//           },
//           {
//             "Name": "사랑꾼 4세트 (20각성합계)",
//             "Description": "이동 속도 +8.00%"
//           }
//         ]
//       },
//       {
//         "Index": 1,
//         "CardSlots": [
//           4,
//           5
//         ],
//         "Items": [
//           {
//             "Name": "라제니스의 운명 2세트",
//             "Description": "모든 속성 피해 감소 +5.00%"
//           },
//           {
//             "Name": "라제니스의 운명 2세트 (4각성합계)",
//             "Description": "속성 피해 +2.00%"
//           },
//           {
//             "Name": "라제니스의 운명 2세트 (6각성합계)",
//             "Description": "공격 적중 시 일정 확률로 8초간 모든 속성 피해 6.0% 증가 (재사용 대기시간 32초)"
//           },
//           {
//             "Name": "라제니스의 운명 2세트 (10각성합계)",
//             "Description": "공격 적중 시 일정 확률로 8초간 모든 속성 피해 18.0% 증가 (재사용 대기시간 32초)"
//           }
//         ]
//       }
//     ]
//   }
// }
