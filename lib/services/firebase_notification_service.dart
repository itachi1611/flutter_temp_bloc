import 'dart:async';
import 'dart:io' show Platform;

import 'package:firebase_messaging/firebase_messaging.dart' show RemoteMessage, FirebaseMessaging, NotificationSettings, AuthorizationStatus;
import 'package:flutter/foundation.dart';
import 'package:flutter_temp/services/notification_service.dart';
import 'package:flutter_temp/utils/app_logger.dart' show devLog, simpleLog;
import 'package:timezone/data/latest_all.dart' as tz;

/// firebase_messaging_service.dart
/// Integrated with your NotificationService (flutter_local_notifications wrapper).
/// - Singleton service for Firebase Messaging
/// - Uses your NotificationService to show local notifications for foreground messages
/// - Exposes streams: onMessage, onMessageOpenedApp, onNotificationTap (payload string), onTokenRefresh
/// - Handles token management, topic subscribe/unsubscribe, initial message
///
/// Usage (in main.dart before runApp):
/// WidgetsFlutterBinding.ensureInitialized();
/// await Firebase.initializeApp();
/// FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
/// await FirebaseMessagingService.instance.initialize();
/// runApp(MyApp());
class FirebaseNotificationService {
  FirebaseNotificationService._internal();
  static final FirebaseNotificationService instance = FirebaseNotificationService._internal();

  final FirebaseMessaging _messaging = FirebaseMessaging.instance;

  // Streams
  final StreamController<RemoteMessage> _onMessageController = StreamController.broadcast();
  Stream<RemoteMessage> get onMessage => _onMessageController.stream;

  final StreamController<RemoteMessage> _onMessageOpenedController = StreamController.broadcast();
  Stream<RemoteMessage> get onMessageOpenedApp => _onMessageOpenedController.stream;

  // Emits when user taps a notification to open the app (both from background and terminated)
  final StreamController<String?> _onNotificationTapController = StreamController.broadcast();
  // Emits the payload (String?) when user taps a local notification created by NotificationService
  Stream<String?> get onNotificationTap => _onNotificationTapController.stream;

  final StreamController<String> _tokenRefreshController = StreamController.broadcast();
  Stream<String> get onTokenRefresh => _tokenRefreshController.stream;

  bool isFlutterLocalNotificationsInitialized = false;

  bool _initialized = false;

  Future<void> initialize() async {
    if(_initialized) return;

    // Setup flutter local notifications
    await _setupFlutterLocalNotifications();

    await _requestNotificationPermission();

    /// Update the iOS foreground notification presentation options to allow
    /// heads up notifications.
    await _messaging.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    await _setupInteractedMessage();
    await _getFCMToken();

    _initialized = true;
  }

  Future<void> _setupFlutterLocalNotifications() async {
    _configureLocalTimeZone();
    if (isFlutterLocalNotificationsInitialized) {
      return;
    }

    NotificationService.instance.initPlatformSetting(
        onSelectNotification: (notificationRes) {
          _onNotificationTapController.add(notificationRes);
        }
    );
    isFlutterLocalNotificationsInitialized = true;
  }

  Future<void> _requestNotificationPermission() async {
    // If you want to use flutter_local_notifications for ask permission, uncomment the line below
    // await NotificationService.instance.requestPlatformPermission();
    // Or you can rely on the Firebase messaging for ask permission
    /// Request permission
    NotificationSettings settings = await _messaging.requestPermission(
      alert: true,
      announcement: true,
      badge: true,
      carPlay: true,
      criticalAlert: true,
      provisional: true,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      debugPrint('User granted permission');
    } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
      debugPrint('User granted provisional permission');
    } else {
      debugPrint('User declined or has not accepted permission');
      return;
    }
  }

  Future<void> _configureLocalTimeZone() async {
    if (kIsWeb || Platform.isLinux) {
      return;
    }
    tz.initializeTimeZones();
  }

  Future<void> _setupInteractedMessage() async {
    // Foreground FCM message
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      _onMessageController.add(message);

      if(Platform.isAndroid) {
        NotificationService.instance.showFirebaseNotification(message);
      }
    });

    // Background to foreground
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      _onMessageOpenedController.add(message);
    });

    // Terminate to opened
    try {
      final initialMessage = await _messaging.getInitialMessage();
      if(initialMessage != null) {
        _onMessageOpenedController.add(initialMessage);
      }
    } catch (e) {
      simpleLog(e);
    }
  }

  Future<void> _getFCMToken() async {
    String? fcmToken;

    if (Platform.isIOS) {
      final apnsToken = await _messaging.getAPNSToken();
      if (apnsToken == null) {
        devLog('⚠️ APNs token not ready yet. Cannot fetch FCM token right now.');
        return; // stop here, wait until user grants notification permission, then retry later
      }
    }

    // If iOS has APNs token or if Android, always fetch the FCM token
    fcmToken = await _messaging.getToken();
    if (fcmToken != null) {
      devLog('🔑 FCM 4 push: $fcmToken');
      devLog('✅ FCM token just received!');
    }

    // Listen to token refresh (ensure this is registered only once)
    _messaging.onTokenRefresh.listen((newToken) {
      devLog('♻️ FCM token refreshed: $newToken');
      _tokenRefreshController.add(newToken);
    });
  }

  Future<String?> getToken() => _messaging.getToken();
  Future<void> deleteToken() => _messaging.deleteToken();
  Future<void> subscribeToTopic(String topic) => _messaging.subscribeToTopic(topic);
  Future<void> unsubscribeFromTopic(String topic) => _messaging.unsubscribeFromTopic(topic);

  Future<void> dispose() async {
    await _onMessageController.close();
    await _onMessageOpenedController.close();
    await _onNotificationTapController.close();
    await _tokenRefreshController.close();
  }
}