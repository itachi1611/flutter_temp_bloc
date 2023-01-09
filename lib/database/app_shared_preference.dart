import 'dart:convert';

import 'package:flutter_temp/common/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppSharedPreference {
  static SharedPreferences? _prefs;

  // call this method from iniState() function of mainApp().
  static Future<SharedPreferences?> init() async {
    _prefs ??= await SharedPreferences.getInstance();
    return _prefs;
  }

  static dynamic getSharedPrefConfig(String key) async {
    switch(key) {
      case AppConstants.firstRun:
        return await _isFirstRun();
      case AppConstants.appInfo:
        return await _getDeviceInfo();
    }
  }

  static Future<bool?> setSharedPrefConfig(String key, dynamic value) async {
    switch(key) {
      case AppConstants.firstRun:
        return await _saveFirstRun(value as bool);
      case AppConstants.appInfo:
        return await _saveDeviceInfo(value as Map<String, dynamic>);
      default:
        return null;
    }
  }

  static void removeSharedPrefConfig() {
    _removeFirstAttempt();
    _removeDeviceInfo();
  }

  /// Event
  // First Attempt
  static Future<bool?> _saveFirstRun(bool isFirstRun) async => await _prefs?.setBool(AppConstants.firstRun, isFirstRun);

  static Future<bool?> _isFirstRun() async => _prefs?.getBool(AppConstants.firstRun);

  static Future<bool?> _removeFirstAttempt() async => await _prefs?.remove(AppConstants.firstRun);

  // Device info
  static Future<bool?> _saveDeviceInfo(Map<String, dynamic> mapData) async => await _prefs?.setString(AppConstants.appInfo, json.encode(mapData));

  static Future<String?> _getDeviceInfo() async => _prefs?.getString(AppConstants.appInfo);

  static Future<bool?> _removeDeviceInfo() async => await _prefs?.remove(AppConstants.appInfo);
}
