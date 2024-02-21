import 'package:connectivity_plus/connectivity_plus.dart';

Future<bool> isWifiConnected() async {
  var connectivityResult = await (Connectivity().checkConnectivity());
  return connectivityResult == ConnectivityResult.wifi;
}
