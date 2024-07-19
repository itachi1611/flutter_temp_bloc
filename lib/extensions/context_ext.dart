import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_temp/common/app_extension.dart';

import '../common/app_enums.dart';
import '../utils/app_flush_bar.dart';

extension ContextExt on BuildContext {
  void onConnectionChanged(ConnectivityResult connectivityResult) {
    switch (connectivityResult) {
      case ConnectivityResult.none:
        AppFlushBar.showFlushBar(
          this,
          message: connectivityResult.message.toString().trim(),
          type: FlushType.error,
        );
        break;
      case ConnectivityResult.mobile:
      case ConnectivityResult.wifi:
        AppFlushBar.showFlushBar(
          this,
          message: connectivityResult.message.toString().trim(),
          type: FlushType.notification,
        );
        break;
      case ConnectivityResult.bluetooth:
      case ConnectivityResult.ethernet:
      case ConnectivityResult.vpn:
      case ConnectivityResult.other:
      default:
        break;
    }
  }
}