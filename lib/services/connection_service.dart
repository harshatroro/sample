import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectionService {
  Connectivity conn = Connectivity();

  Future<bool> checkConnected() async {
    final connection = await conn.checkConnectivity();
    switch(connection) {
      case ConnectivityResult.wifi:
      case ConnectivityResult.ethernet:
      case ConnectivityResult.mobile:
      case ConnectivityResult.vpn:
        return true;
      case ConnectivityResult.bluetooth:
      case ConnectivityResult.other:
      case ConnectivityResult.none:
        return false;
    }
  }
}