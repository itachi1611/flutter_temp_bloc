import 'dart:async';
import 'dart:developer' as dev;
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/services.dart';

class NetworkService {
  NetworkService._internal();
  static final NetworkService instance = NetworkService._internal();

  final _connectivity = Connectivity();
  /// A broadcast controller so multiple listeners can be listened to connectivity changes
  final _controller = StreamController<bool>.broadcast();

  /// Expose the stream that emits connection status updates
  /// true means connected to internet and vice versa
  Stream<bool> get connectStream => _controller.stream;

  /// Initialize the service and emit initial connection status
  Future<void> initialize() async {
    try {
      // Emit the initial connection status

      // Listen to connectivity changes
      _connectivity.onConnectivityChanged.listen(_onConnectionChanged);
    } on PlatformException catch (e) {
      dev.log('Could not check connectivity status', error: e);
    }
  }

  /// Manual check connection
  Future<bool> onCheckConnection() async {
    try {
      List<ConnectivityResult> result = await _connectivity.checkConnectivity();
      if (!result.contains(ConnectivityResult.none)) {
        return await onDNSLookUp();
        // return false;
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  /// Test DNS connection lookup
  Future<bool> onDNSLookUp() async {
    try {
      final result = await InternetAddress.lookup('example.com');
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } on SocketException catch (_) {
      return false;
    }
  }

  /// Checks if there is real internet access based on [result]
  /// Uses DNS lookup of `example.com` to verify actual connectivity
  Future<void> _onConnectionChanged(List<ConnectivityResult> result) async {
    bool hasInternet = false;
    if (!result.contains(ConnectivityResult.none)) {
      try {
        final result = await InternetAddress.lookup('example.com');
        hasInternet = result.isNotEmpty && result[0].rawAddress.isNotEmpty;
      } on SocketException catch (_) {
        hasInternet = false;
      }
    }
    _controller.sink.add(hasInternet);
  }

  /// Disposes internal stream
  void disposeStream() => _controller.close();
}