import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

class UserData {
  static UserData? _instance;
  static Future<UserData> get instance async {
    if (_instance == null) {
      _instance = UserData._internal();
      await _instance!._initializeUUID();
    }
    return _instance!;
  }

  UserData._internal();

  static const String _uuidKey = 'user_uuid';
  String? _uuid;

  String get uuid => _uuid ?? '';

  // private로 변경
  Future<void> _initializeUUID() async {
    if (_uuid != null) return;

    final prefs = await SharedPreferences.getInstance();
    _uuid = prefs.getString(_uuidKey);

    if (_uuid == null) {
      _uuid = const Uuid().v4();
      await prefs.setString(_uuidKey, _uuid!);
    }
  }

  Future<void> resetUUID() async {
    final prefs = await SharedPreferences.getInstance();
    _uuid = const Uuid().v4();
    await prefs.setString(_uuidKey, _uuid!);
  }

  Future<void> clearUUID() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_uuidKey);
    _uuid = null;
  }
}
