class RegUtil {
  static List<String?> getNumbersFromString(String input) {
    // 정규 표현식을 사용하여 숫자만 추출
    RegExp regExp = RegExp(r'\d+');
    Iterable<Match> matches = regExp.allMatches(input);
    return matches.map((match) => match.group(0)).toList();
  }

  static List<String?> getCritSpeedOrSpecializationValues(String input) {
    // 정규 표현식을 사용하여 "치명 +숫자", "신속 +숫자" 또는 "특화 +숫자" 패턴을 추출
    RegExp regExp = RegExp(r'(치명 \+\d+|신속 \+\d+|특화 \+\d+)');
    Iterable<Match> matches = regExp.allMatches(input);

    // 매치된 부분들을 문자열로 변환하여 리스트에 추가
    List<String?> results = matches.map((match) => match.group(0)).toList();

    return results;
  }

  static List<String?> getStatValues(String input) {
    // 정규 표현식을 사용하여 "치명 +숫자", "신속 +숫자" 또는 "특화 +숫자" 패턴을 추출
    RegExp regExp =
        RegExp(r'(치명 \+\d+|신속 \+\d+|특화 \+\d+|인내 \+\d+|숙련 \+\d+|제압 \+\d+)');
    Iterable<Match> matches = regExp.allMatches(input);

    // 매치된 부분들을 문자열로 변환하여 리스트에 추가
    List<String?> results = matches.map((match) => match.group(0)).toList();

    return results;
  }

  static List<String?> getElixirSkillAndLevel(String input) {
    RegExp skillRegExp = RegExp(
        r"<FONT color=\'#[0-9A-Fa-f]{6}\'>\[[^\]]+\]<\/FONT> ([^<]+) <FONT color=\'#[0-9A-Fa-f]{6}\'>Lv\.\d+<\/FONT>");
    Iterable<Match> skillMatches = skillRegExp.allMatches(input);

    // 매치된 부분들을 문자열로 변환하여 리스트에 추가
    List<String?> results =
        skillMatches.map((match) => match.group(1)).toList();

    // "Lv." 다음에 오는 숫자만 추출
    RegExp levelRegExp = RegExp(r'Lv\.(\d+)');
    Iterable<Match> levelMatches = levelRegExp.allMatches(input);

    // 매치된 숫자 부분을 문자열로 변환하여 리스트에 추가
    results.addAll(levelMatches.map((match) => match.group(1)).toList());

    return results;
  }

  static List<String>? getTranscendence(String input) {
    RegExp regExp =
        RegExp(r"<FONT COLOR='#[0-9A-Fa-f]{6}'>(\d+)</FONT>단계.*>(\d+)$");

    RegExpMatch? match = regExp.firstMatch(input);

    if (match != null) {
      String level = match.group(1)!; // "단계" 앞의 숫자
      String count = match.group(2)!; // 마지막 숫자
      return [level, count];
    } else {
      return null;
    }
  }

  static String getElixirAddtionalEffect(String input) {
    final regex = RegExp(r"([가-힣]+ \(\d+단계\))");
    final match = regex.firstMatch(input);

    if (match != null) {
      return match.group(1).toString(); // 회심 (2단계)
    } else {
      return "추가 효과 없음";
    }
  }

  static List<String> getBraceletOption(String input) {
    RegExp exp = RegExp(r"\[<FONT COLOR=\'\'>(.*?)<\/FONT>\]");

    Iterable<Match> matches = exp.allMatches(input);

    return matches.map((match) => match.group(1)!).toList();
  }

  static List<String> getAbilityStoneOption(String input) {
    final optionRegex = RegExp(r"([가-힣\s]+)\s*<.*Lv\.(\d+)");
    final activeLevelRegex = RegExp(r'활성도 (\d+)');

    final optionMatch = optionRegex.firstMatch(input);
    final optionText = optionMatch?.group(1);
    final levelText = optionMatch?.group(2);
    if (optionText == null || levelText == null) {
      return [];
    } else {
      return [optionText, levelText];
    }
  }

  static List<String> getEngravingOptions(String input) {
    RegExp exp = RegExp(r'^(.*) Lv\. (\d+)$');
    var match = exp.firstMatch(input);
    if (match != null) {
      return [match.group(1)!, match.group(2)!];
    } else {
      return [];
    }
  }

  static List<String> getAccessoryGrindingEffect(String input) {
    // 정규표현식 패턴
    RegExp regExp =
        RegExp(r"[\uAC00-\uD7A3A-Za-z0-9 ,]+ \+[0-9]+(\.[0-9]+)?%?");

    // 패턴에 맞는 모든 부분을 찾기
    Iterable<RegExpMatch> matches = regExp.allMatches(input);

    return matches.map((m) => m.group(0)!).toList();
  }
}
