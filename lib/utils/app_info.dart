import 'package:device_info_plus/device_info_plus.dart';

class AppInfo {
  AppInfo._();

  static final _instance = AppInfo._();

  static AppInfo get instance => _instance;

  Future<Map<String, dynamic>> getDeviceInfo() async {
    DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
    final deviceInfo = await deviceInfoPlugin.deviceInfo;
    return deviceInfo.data;

    // final allInfo = deviceInfo.data;
    // AndroidDeviceInfo? androidInfo = await deviceInfoPlugin.androidInfo;
    // appLogger.i('Running on ${androidInfo?.model}');  // e.g. "Moto G (4)"
    // IosDeviceInfo? iosInfo = await deviceInfoPlugin.iosInfo;
    // appLogger.i('Running on ${iosInfo?.utsname.machine}');  // e.g. "iPod7,1"
    // WebBrowserInfo? webBrowserInfo = await deviceInfoPlugin.webBrowserInfo;
    // appLogger.i('Running on ${webBrowserInfo?.userAgent}');
  }
}