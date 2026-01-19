import 'package:xml/xml.dart';

class XmlUtil {
  static String getArkGridGrade(String rawXml) {
    final document = XmlDocument.parse(rawXml);

    return document.firstChild?.innerText.split(" ")[0] ?? '';
  }
}
