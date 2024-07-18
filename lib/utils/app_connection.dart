import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class AppConnection {
  // Define singleton AppConnection
  AppConnection._();

  static final _instance = AppConnection._();

  factory AppConnection() => _instance;

  // Package detect network connection
  final _networkConnectivity = Connectivity();

  final InternetConnectionChecker _internetConnectionChecker = InternetConnectionChecker();

  Stream<List<ConnectivityResult>> get connectivityStream => _networkConnectivity.onConnectivityChanged;

  Future<bool> isConnectInternet() async {
    // Check if there is active network connection
    List<ConnectivityResult> connectivityResults = await _networkConnectivity.checkConnectivity();
    if(connectivityResults.contains(ConnectivityResult.none)) {
      return false;
    }

    // Check if the device is connected to the internet
    return await _internetConnectionChecker.hasConnection;
  }
}