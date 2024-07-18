import 'package:flutter_temp/config/env/index.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../utils/app_logger.dart';
import 'app_enums.dart';
import 'app_env.dart';

class AppConfig {
  static Env env = Env.qa;
  static AppEnv appEnv = DevEnv();

  ///Network
  static String baseUrl = '';

  static Future<void> loadEnv() async {
    await _checkEnv();
    DevLog.log(env.toString());

    switch (env) {
      case Env.qa:
        appEnv = DevEnv();
        break;
      case Env.stg:
        appEnv = StgEnv();
        break;
      case Env.prod:
        appEnv = ProdEnv();
        break;
      default:
        break;
    }

    baseUrl = '${appEnv.baseUrl}/api/';
    DevLog.log(baseUrl);
  }

  static Future<void> _checkEnv() async {
    final packageInfo = await PackageInfo.fromPlatform();
    final appName = packageInfo.packageName;
    try {
      if (appName.contains(Env.qa.packageName)) {
        env = Env.qa;
      } else if (appName.contains(Env.stg.packageName)) {
        env = Env.stg;
      } else {
        env = Env.prod;
      }
    } catch (e) {
      env = Env.qa;
    }
  }
}
