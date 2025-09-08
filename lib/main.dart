import 'dart:async';
import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_temp/database/app_shared_preference.dart';
import 'package:flutter_temp/services/firebase_notification_service.dart';
import 'package:flutter_temp/services/notification_service.dart';
import 'package:flutter_temp/utils/app_logger.dart' show simpleLog, customLog;
import 'package:get_storage/get_storage.dart';
import 'package:logger/logger.dart';

import 'app/app_page.dart';
import 'firebase_options.dart';

/// To verify that your messages are being received, you ought to see a notification appear on your device/emulator via the flutter_local_notifications plugin.
/// Define a top-level named handler which background/terminated messages will
/// call. Be sure to annotate the handler with `@pragma('vm:entry-point')` above the function declaration.
@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  try {
    await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
    simpleLog('Init Firebase on BackgroundHandler success');
  } catch (e, s) {
    customLog(Level.error, 'Init firebase on BackgroundHandler failed', e, s);
  }

  NotificationService.instance.showFirebaseNotification(message);
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  simpleLog('Handling a background message ${message.messageId}');
}

Future<void> main() async {
  /// Initialize packages
  WidgetsFlutterBinding.ensureInitialized();

  /// Initialize Firebase
  try {
    await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
    simpleLog('Init Firebase on MainIsolate success');
  } catch (e, s) {
    customLog(Level.error, 'Init firebase on MainIsolate failed', e, s);
  }

  // Set the background messaging handler early on, as a named top-level function
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  /// Optional: Set System Overlay
  // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
  //   statusBarColor: Colors.white.withOpacities(0), // set Status bar color in Android devices
  //   statusBarIconBrightness:
  //   Brightness.light, // set Status bar icons color in Android devices
  //   statusBarBrightness: Brightness.light, // set Status bar icon color in iOS
  // ));

  /// Set System Orientation
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
    // DeviceOrientation.landscapeLeft,
    // DeviceOrientation.landscapeRight,
  ]);

  runZonedGuarded(() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
      // DeviceOrientation.landscapeLeft,
      // DeviceOrientation.landscapeRight,
    ]);
  }, (onError, stack) {
    log('$onError');
  });

  await FirebaseNotificationService.instance.initialize();

  await GetStorage.init();
  await AppSharedPreference.init();

  runApp(const AppPage());
}
