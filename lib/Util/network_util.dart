import 'package:connectivity_plus/connectivity_plus.dart';

class NetworkUtil {
  static Future<bool> isConnected() async {
    final List<ConnectivityResult> connectivityResult =
        await (Connectivity().checkConnectivity());

    if (connectivityResult.contains(ConnectivityResult.none)) {
      // 네트워크 연결이 되어있지 않은 경우
      return false;
    } else {
      // 네트워크 연결이 되어있는 경우
      return true;
    }
  }
}
