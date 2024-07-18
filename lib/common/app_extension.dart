import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:package_info_plus/package_info_plus.dart';

extension ConnectivityMess on ConnectivityResult {
  String get message {
    switch(this) {
      case ConnectivityResult.none:
        return 'Internet connection has been lost !';
      case ConnectivityResult.mobile:
      case ConnectivityResult.wifi:
        return 'Internet connection has been recover';
      case ConnectivityResult.bluetooth:
      case ConnectivityResult.ethernet:
      case ConnectivityResult.vpn:
      case ConnectivityResult.other:
      default:
        return '';
    }
  }
}

extension AppPackage on PackageInfo {
  String get appVersion => '${version.split(' ').first} ($buildNumber)';

  String get packageAppName => packageName;
}