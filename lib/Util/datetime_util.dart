import 'package:sprintf/sprintf.dart';

class DatetimeUtil {
  static String getToday() {
    DateTime dateTime = DateTime.now();
    return sprintf(
        "%.4d-%.2d-%.2d", [dateTime.year, dateTime.month, dateTime.day]);
  }

  static String getTimeData(String date) {
    DateTime dateTime = DateTime.parse(date);
    return sprintf("%.2d:%.2d", [dateTime.hour, dateTime.minute]);
  }

  static String getMonthAndDate(String date) {
    DateTime dateTime = DateTime.parse(date);
    return sprintf("%.2d.%.2d", [dateTime.month, dateTime.day]);
  }

  static bool isBeforeNow(String date) {
    DateTime dateTime = DateTime.parse(date);
    DateTime now = DateTime.now();

    return dateTime.isBefore(now);
  }

  static DateTime getLastWednesdayAt11AM(DateTime date) {
    // 현재 날짜의 요일
    int weekday = date.weekday;

    // 지난 수요일의 날짜를 계산
    DateTime lastWednesday;
    if (weekday == DateTime.wednesday) {
      // 현재 요일이 수요일인 경우
      lastWednesday = DateTime(date.year, date.month, date.day, 11);
    } else if (weekday > DateTime.wednesday) {
      // 현재 요일이 수요일 이후인 경우
      lastWednesday =
          date.subtract(Duration(days: weekday - DateTime.wednesday));
    } else {
      // 현재 요일이 수요일 이전인 경우
      lastWednesday =
          date.subtract(Duration(days: weekday - DateTime.wednesday + 7));
    }

    // 해당 날짜에 11시를 추가
    return DateTime(
        lastWednesday.year, lastWednesday.month, lastWednesday.day, 11);
  }

  static bool isAfterLastWednesday(DateTime dateToCheck) {
    DateTime today = DateTime.now();
    DateTime lastWednesday = getLastWednesdayAt11AM(today);
    return dateToCheck.isAfter(lastWednesday);
  }

  static bool isAfter11AM(DateTime dateToCheck) {
    DateTime date = DateTime.now();
    DateTime today11AM = DateTime(date.year, date.month, date.day, 11);
    return dateToCheck.isAfter(today11AM);
  }
}
