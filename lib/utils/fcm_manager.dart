import 'dart:convert';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_temp/extensions/string_ext.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

import '../config/notifications/fox_channel.dart';
import '../main.dart';
import 'app_logger.dart';

bool isFlutterLocalNotificationsInitialized = false;

Future<void> _configureLocalTimeZone() async {
  if (kIsWeb || Platform.isLinux) {
    return;
  }
  tz.initializeTimeZones();
  final String timeZoneName = await FlutterTimezone.getLocalTimezone();
  tz.setLocalLocation(tz.getLocation(timeZoneName));
}

Future<void> setupFlutterNotifications() async {
  _configureLocalTimeZone();
  if (isFlutterLocalNotificationsInitialized) {
    return;
  }
  channel = defaultChannel;

  notificationsPlugin = FlutterLocalNotificationsPlugin();

  // Android setting
  var initializationSettingsAndroid = const AndroidInitializationSettings('ic_push_notification');

  // IOS setting
  var initializationSettingsIOS = const DarwinInitializationSettings(
    requestAlertPermission: false,
    requestBadgePermission: false,
    requestSoundPermission: false,
  );

  // Init setting for android and ios
  var initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
  );

  // Apply setting to plugin
  await notificationsPlugin.initialize(
    initializationSettings,
    onDidReceiveNotificationResponse: onSelectNotification,
    onDidReceiveBackgroundNotificationResponse: onSelectNotification,
  );

  /// Create an Android Notification Channel.
  /// We use this channel in the `AndroidManifest.xml` file to override the
  /// default FCM channel to enable heads up notifications.
  await notificationsPlugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()?.createNotificationChannel(channel);

  /// Update the iOS foreground notification presentation options to allow
  /// heads up notifications.
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );

  isFlutterLocalNotificationsInitialized = true;
}

/**
 * * isAndroidPermissionGranted
 * @param none
 * * check android permission
 */
Future<bool> isAndroidPermissionGranted() async {
  if (Platform.isAndroid) {
    final bool granted = await notificationsPlugin
        .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>()
        ?.areNotificationsEnabled() ??
        false;
    return granted;
  }

  return false;
}

/**
 * * onRequestPushNotificationPermission
 * @param none
 * * Call to request ask push notification permission on device (Only call when firebase messaging fail to set permission for push notification)
 */
Future<void> onRequestPushNotificationPermission() async {
  if (Platform.isIOS || Platform.isMacOS) {
    await notificationsPlugin.resolvePlatformSpecificImplementation<IOSFlutterLocalNotificationsPlugin>()?.requestPermissions(
      alert: true,
      badge: true,
      sound: true,
    );
    await notificationsPlugin.resolvePlatformSpecificImplementation<MacOSFlutterLocalNotificationsPlugin>()?.requestPermissions(
      alert: true,
      badge: true,
      sound: true,
    );
  } else if (Platform.isAndroid) {
    final AndroidFlutterLocalNotificationsPlugin? androidImplementation = notificationsPlugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>();
    final bool? grantedNotificationPermission = await androidImplementation?.requestNotificationsPermission();
    DevLog.log('onAndroidPermission: $grantedNotificationPermission');
  }
}

/**
 * * onSelectNotification
 * @param NotificationResponse notificationResponse
 * * Called when tap on notification on background and foreground
 */
void onSelectNotification(NotificationResponse notificationResponse) async {}

/**
 * * setupInteractedMessage
 * @param none
 * * Listen FCM messaging status
 */
Future<void> setupInteractedMessage() async {
  // Get any messages which caused the application to open from
  // a terminated state.
  RemoteMessage? initialMessage = await FirebaseMessaging.instance.getInitialMessage();

  if (initialMessage != null) {
    _handleMessage(initialMessage);
  }

  FirebaseMessaging.onMessage.listen(_showFlutterNotification);

  // Also handle any interaction when the app is in the background via a
  // Stream listener
  FirebaseMessaging.onMessageOpenedApp.listen(_handleMessage);
}

/**
 * * _handleMessage
 * @param RemoteMessage message
 * * Called for handling FCM message
 */
Future<void> _handleMessage(RemoteMessage message) async {
  DevLog.log('FCM message just came ! ');
}

/**
 * * onGetFCMToken
 * @param none
 * * FCM Get token
 */
void onGetFCMToken() {
  FirebaseMessaging.instance.getToken().then((token) {
    DevLog.log('FCM 4 push $token');
    DevLog.log('FCM token just received ! ');
  });
}

Stream<String> get onFCMTokenUpdated => FirebaseMessaging.instance.onTokenRefresh;

/**
 * * onTokenReceived
 * @param String? token
 * * Call for handling fcm token changed from firebase
 */
void onTokenReceived(String? token) {
  DevLog.log('FCM token just received ! ');
}

Future<void> _showFlutterNotification(RemoteMessage message) async {
  BigPictureStyleInformation? bigPictureStyleInformation;
  BigTextStyleInformation? bigTextStyleInformation;

  RemoteNotification? notification = message.notification;
  AndroidNotification? android = message.notification?.android;

  if (notification != null && android != null && !kIsWeb) {

    if(android.imageUrl.validate) {
      final http.Response response = await http.get(Uri.parse(android.imageUrl!));

      bigTextStyleInformation ??= BigTextStyleInformation(
        notification.title ?? '',
        htmlFormatBigText: true,
        contentTitle: '<b>${notification.body ?? ''}</b>',
        htmlFormatContentTitle: true,
        summaryText: '<i>${notification.body}</i>',
        htmlFormatSummaryText: true,
      );

      bigPictureStyleInformation ??= BigPictureStyleInformation(
          ByteArrayAndroidBitmap.fromBase64String(base64Encode(response.bodyBytes)),
          largeIcon: ByteArrayAndroidBitmap.fromBase64String(base64Encode(response.bodyBytes)),
          contentTitle: '<b>${notification.title}</b>',
          htmlFormatContentTitle: true,
          summaryText: 'summary <i>${notification.body}</i>',
          htmlFormatSummaryText: true
      );
    }

    notificationsPlugin.show(
      notification.hashCode,
      notification.title,
      notification.body,
      NotificationDetails(
        android: AndroidNotificationDetails(
          android.channelId ?? channel.id,
          channel.name,
          channelDescription: channel.description,
          importance: channel.importance,
          priority: Priority.high,
          icon: 'ic_push_notification',
          showWhen: true,
          subText: DateFormat('yyyy-MM-dd HH:mm:ss').format(message.sentTime ?? DateTime.now()),
          // Big Picture style for push notification
          styleInformation: bigPictureStyleInformation,
          // There are more 3 style: InboxStyle, MediaStyle, MessageStyle
          // styleInformation: bigTextStyleInformation,
          // Add btn and actionCallBack when tap on button of push notification
          // actions:   <AndroidNotificationAction>[
          //   const AndroidNotificationAction(
          //     'action_1',
          //     'See more...',
          //     icon: DrawableResourceAndroidBitmap('ic_push_notification'),
          //     inputs: <AndroidNotificationActionInput>[
          //       AndroidNotificationActionInput(
          //         label: 'Enter a message',
          //       ),
          //     ],
          //   ),
          //   const AndroidNotificationAction(
          //     'action_2',
          //     'Action 1',
          //     icon: DrawableResourceAndroidBitmap('ic_push_notification'),
          //     contextual: true,
          //   ),
          //   const AndroidNotificationAction(
          //     'action_3',
          //     'Action 2',
          //     titleColor: Color.fromARGB(255, 255, 0, 0),
          //     icon: DrawableResourceAndroidBitmap('ic_push_notification'),
          //   ),
          //   const AndroidNotificationAction(
          //     'action_4',
          //     'Action 3',
          //     icon: DrawableResourceAndroidBitmap('ic_push_notification'),
          //     showsUserInterface: true,
          //     // By default, Android plugin will dismiss the notification when the
          //     // user tapped on a action (this mimics the behavior on iOS).
          //     cancelNotification: false,
          //   ),
          // ],
        ),
      ),
    );
  }
}