import 'package:package_info_plus/package_info_plus.dart';

extension AppPackageExt on PackageInfo {
  String get appVersion => '${version.split(' ').first} ($buildNumber)';

  String get packageAppName => packageName;
}