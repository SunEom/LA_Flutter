class Assignment {
  int id;
  String title;
  String stage;
  String difficulty;
  String gold;
  String level;
  bool isCompleted;

  Assignment({
    required this.id,
    required this.title,
    required this.stage,
    required this.difficulty,
    required this.gold,
    required this.level,
    required this.isCompleted,
  });

  factory Assignment.fromJson(Map<String, dynamic> json) {
    return Assignment(
      id: json["id"],
      title: json['Title'],
      stage: json['Stage'],
      difficulty: json['Difficulty'],
      gold: json['Gold'],
      level: json['Level'],
      isCompleted: json['CompleteYn'] == '1',
    );
  }
}
