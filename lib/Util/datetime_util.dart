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
}
