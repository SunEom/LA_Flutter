import 'package:sprintf/sprintf.dart';

class Utils {
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
    String text =
        '''<img src='emoticon_tooltip_bracelet_locked' vspace='-5'></img> 치명 +97<BR><img src='emoticon_tooltip_bracelet_changeable' width='20' height='20' vspace='-6'></img>[<FONT COLOR=''>결투</FONT>] 헤드어택으로 주는 피해가 <FONT COLOR='#99ff99'>4%</FONT> 증가한다. <FONT COLOR='#969696'>(60레벨 초과 몬스터에게는 효과 감소)</FONT><BR><img src='emoticon_tooltip_bracelet_changeable' width='20' height='20' vspace='-6'></img>[<FONT COLOR=''>열정</FONT>] 자신의 생명력이 40% 이상일 경우 적에게 공격 적중 시 3초 동안 '열정' 효과를 획득한다.<BR>'냉정' 효과를 보유 중 일 때 '열정' 효과가 1% 추가 증가한다.<BR>열정 : 몬스터에게 주는 피해가 <FONT COLOR='#99ff99'>4%</FONT> 증가한다. <FONT COLOR='#969696'>(60레벨 초과 몬스터에게는 효과 감소)</FONT><BR><img src='emoticon_tooltip_bracelet_changeable' width='20' height='20' vspace='-6'></img>[<FONT COLOR=''>속공</FONT>] 몬스터에게 피격 시 <FONT COLOR='#99ff99'>10%</FONT> 확률로 8초 동안 '속공' 효과를 획득한다. <BR>속공: 무기 공격력이 <FONT COLOR='#99ff99'>1000</FONT>, 공격속도가 <FONT COLOR='#99ff99'>2%</FONT>, 이동속도가 <FONT COLOR='#99ff99'>2%</FONT> 상승한다. <FONT COLOR='#969696'>(60레벨 초과 몬스터에게는 효과 감소)</FONT>''';

    Iterable<Match> matches = exp.allMatches(text);

    return matches.map((match) => match.group(1)!).toList();
  }

  static List<String> getAbilityStoneOption(String input) {
    final optionRegex =
        RegExp(r"<FONT COLOR='#([0-9A-Fa-f]{6})'>([^<]+)</FONT>");
    final activeLevelRegex = RegExp(r'활성도 (\d+)');

    final optionMatch = optionRegex.firstMatch(input);
    final optionText = optionMatch?.group(2);

    final activeLevelMatch = activeLevelRegex.firstMatch(input);
    final activeLevel = activeLevelMatch?.group(1);

    if (optionText == null || activeLevel == null) {
      return [];
    } else {
      return [optionText, activeLevel];
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

  static String getTimeData(String date) {
    DateTime dateTime = DateTime.parse(date);
    return sprintf("%.2d:%.2d", [dateTime.hour, dateTime.minute]);
  }

  static bool isBeforeNow(String date) {
    DateTime dateTime = DateTime.parse(date);
    DateTime now = DateTime.now();

    return dateTime.isBefore(now);
  }
}
