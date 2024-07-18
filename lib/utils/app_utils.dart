import 'package:flutter_temp/utils/app_logger.dart';
import 'package:url_launcher/url_launcher.dart';

import '../common/app_enums.dart';

class AppUtils {
  static Future<void> onLaunchExternalApp({LaunchExternalType? externalType, required String data}) async {
    Uri uri;
    try {
      switch(externalType ?? LaunchExternalType.webview) {
        case LaunchExternalType.mail:
          uri = Uri(
            scheme: externalType!.type,
            path: data,
            queryParameters: {
              'subject': "Testing subject"
            },
          );
          break;
        case LaunchExternalType.sms:
        case LaunchExternalType.tel:
        case LaunchExternalType.webview:
        default:
          uri = Uri(
            scheme: externalType!.type,
            path: data,
          );
          break;
      }

      await launchUrl(uri);
    }
    catch(e) {
      AppLogger().e(e.toString());
    }
  }
}