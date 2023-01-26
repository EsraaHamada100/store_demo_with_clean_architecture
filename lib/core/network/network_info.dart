import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:internet_connection_checker/internet_connection_checker.dart';

abstract class NetworkInfo {
  Future<bool> get isConnected;
}

class NetworkInfoImpl implements NetworkInfo {
  final InternetConnectionChecker? connectionChecker;
  final Connectivity connectivity;
  NetworkInfoImpl(
      {required this.connectionChecker, required this.connectivity});
  @override
  Future<bool> get isConnected async {
    if (kIsWeb) {
      final ConnectivityResult connectivityResult =
          await connectivity.checkConnectivity();
      if (connectivityResult == ConnectivityResult.none) {
        return false;
      }
      return true;
    } else {
      return connectionChecker!.hasConnection;
    }
  }
}
