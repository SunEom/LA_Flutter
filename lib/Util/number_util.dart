import 'package:intl/intl.dart';

class NumberUtil {
  static int toInt(String number) {
    try {
      return int.parse(number);
    } catch (e) {
      return 0;
    }
  }

  static String getCommaNumber(int number) {
    var f = NumberFormat('###,###,###,###');
    return f.format(number);
  }

  static String getCommaStringNumber(String number) {
    var f = NumberFormat('###,###,###,###');
    return f.format(toInt(number));
  }
}
