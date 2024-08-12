import 'package:sprintf/sprintf.dart';

class DatetimeUtil {
  static String getTimeData(String date) {
    DateTime dateTime = DateTime.parse(date);
    return sprintf("%.2d:%.2d", [dateTime.hour, dateTime.minute]);
  }

  static bool isBeforeNow(String date) {
    DateTime dateTime = DateTime.parse(date);
    DateTime now = DateTime.now();

    return dateTime.isBefore(now);
  }

  static DateTime getLastWednesdayAt10AM(DateTime date) {
    // 현재 날짜의 요일
    int weekday = date.weekday;

    // 지난 수요일의 날짜를 계산
    DateTime lastWednesday;
    if (weekday > DateTime.wednesday) {
      // 현재 요일이 수요일 이후인 경우
      lastWednesday =
          date.subtract(Duration(days: weekday - DateTime.wednesday));
    } else {
      // 현재 요일이 수요일 이전인 경우
      lastWednesday =
          date.subtract(Duration(days: weekday - DateTime.wednesday + 7));
    }

    // 해당 날짜에 10시를 추가
    return DateTime(
        lastWednesday.year, lastWednesday.month, lastWednesday.day, 10);
  }

  static bool isAfterLastWednesday(DateTime dateToCheck) {
    DateTime today = DateTime.now();
    DateTime lastWednesday = getLastWednesdayAt10AM(today);
    return dateToCheck.isAfter(lastWednesday);
  }
}
