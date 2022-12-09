import 'package:shared_preferences/shared_preferences.dart';

class AppSharedPreference {
  /// Define key prefs
  static const String _firstAttempt = "firstAttempt";

  /// Event
  /// First Attempt
  static Future<bool> saveFirstAttempt(bool isFirstAttempt) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setBool(_firstAttempt, isFirstAttempt);
  }

  static Future<bool?> getFirstAttempt() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var isFirstAttempt = prefs.getBool(_firstAttempt);
    if (isFirstAttempt != null) {
      return isFirstAttempt;
    }
    return null;
  }

  static Future<bool?> removeFirstAttempt() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.remove(_firstAttempt);
  }
}
