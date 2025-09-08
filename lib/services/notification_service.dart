
import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart' show RemoteMessage;
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/intl.dart';
import 'package:timezone/timezone.dart';

import '../utils/app_logger.dart' show simpleLog;

typedef NotificationCallback = void Function(String? notificationResponse);

/// Define channel
const defaultChannel = AndroidNotificationChannel(
  'fox_channel', // id
  'Fox Push Notification Channel', // title
  description: 'This channel is used for push notifications.', // description
  importance: Importance.max,
  showBadge: true,
  enableLights: false,
  enableVibration: true,
  playSound: true,
  // sound:
);

class NotificationService {
  // Private constructor
  NotificationService._();

  static final NotificationService _instance = NotificationService._();

  // Accessor to the singleton instance
  static NotificationService get instance => _instance;

  // Define FlutterLocalNotificationsPlugin instance
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  /// Initialize the setting for each platform (Android, iOS)
  ///
  /// This method is used to setup the local notification plugin for each platform.
  /// The [onSelectNotification] is a callback that will be called when the user
  /// taps on the notification.
  ///
  /// The [onSelectNotification] callback will receive the payload of the notification
  /// as a parameter. This payload can be used to navigate to a specific page
  /// or to perform any other action.
  ///
  /// Note that this method is asynchronous and returns a [Future<void>].
  Future<void> initPlatformSetting({NotificationCallback? onSelectNotification}) async {
    // Android settings
    const AndroidInitializationSettings androidSetting = AndroidInitializationSettings('notification');

    // iOS settings
    const DarwinInitializationSettings iosSetting = DarwinInitializationSettings();

    // Initialize setting for android and ios
    const InitializationSettings initializationSettings = InitializationSettings(
      android: androidSetting,
      iOS: iosSetting,
    );

    // Initialize the plugin
    await _flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (notificationResponse) async {
        final String actionId = notificationResponse.actionId ?? '';

        if(Platform.isAndroid && actionId.isNotEmpty) {
          switch(actionId) {
            case 'action_1':
              simpleLog('User tapped on dismiss action');
              break;
            case 'action_2':
              simpleLog('User tapped on to setting action');
              break;
          }
        } else {
          if(onSelectNotification != null) {
            onSelectNotification(notificationResponse.payload);
          }
        }
      },
    );

    /// Create an Android Notification Channel.
    /// We use this channel in the `AndroidManifest.xml` file to override the
    /// default FCM channel to enable heads up notifications.
    await _flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()?.createNotificationChannel(defaultChannel);
  }

  /// Check if the permission to display notification is granted on Android.
  ///
  /// The permission status is checked using the
  /// [AndroidFlutterLocalNotificationsPlugin.areNotificationsEnabled] method.
  ///
  /// If the permission is granted, this method returns [true].
  /// Otherwise, it returns [false].
  ///
  /// Note that this method is only available on Android.
  ///
  /// Returns a [Future] that completes with [true] if the permission is granted,
  /// and [false] otherwise.
  Future<bool> _isAndroidPermissionGranted() async {
    return await _flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>()
        ?.areNotificationsEnabled() ?? false;
  }

  /// Request the platform permission to display notification.
  ///
  /// On Android, check if the permission to display notification is granted
  /// and if not, request the permission.
  ///
  /// On iOS, request the permission to display notification.
  Future<void> requestPlatformPermission() async {
    // Android 13+ permission
    if(Platform.isAndroid) {
      final hasPermission = await _isAndroidPermissionGranted();

      if(!hasPermission) {
        await _flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()?.requestNotificationsPermission();
      }
    } else if(Platform.isIOS) {
      await _flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<IOSFlutterLocalNotificationsPlugin>()?.requestPermissions(
        alert: true,
        badge: true,
        sound: true,
      );
    } else if(Platform.isMacOS) {
      await _flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<MacOSFlutterLocalNotificationsPlugin>()?.requestPermissions(
        alert: true,
        badge: true,
        sound: true,
      );
    }
  }

  Future<void> showFirebaseNotification(RemoteMessage message) async {
    try {
      final notification = message.notification;
      final payload = message.data.isNotEmpty ? jsonEncode(message.data) : null;
      if(notification == null) return;

      await showNotification(
        id: notification.hashCode,
        title: notification.title ?? '',
        body: notification.body ?? '',
        payload: payload,
        message: message,
      );
    } catch (e) {
      simpleLog(e.toString());
    }
  }

  /// Show a local notification.
  ///
  /// [id] is the unique identifier of the notification.
  ///
  /// [title] is the title of the notification.
  ///
  /// [body] is the body of the notification.
  ///
  /// [payload] is a string used to pass data to the app when the user taps
  /// on the notification.
  Future<void> showNotification({
    required int id,
    required String title,
    required String body,
    String? payload,
    RemoteMessage? message,
  }) async {
    final notificationDetails = getNotificationDetails(message: message);
    await _flutterLocalNotificationsPlugin.show(
      id,
      title,
      body,
      notificationDetails,
      payload: payload,
    );
  }

  /// Schedule a local notification to be shown at a specified time in the future.
  ///
  /// [id] is the unique identifier of the notification.
  ///
  /// [title] is the title of the notification.
  ///
  /// [body] is the body of the notification.
  ///
  /// [nextInterval] is the duration from now until the notification should be shown.
  ///
  /// [payload] is a string used to pass data to the app when the user taps
  /// on the notification.
  ///
  /// The notification will be scheduled to be shown at [nextInterval] time from now.
  /// The [payload] will be passed to the app when the user taps on the notification.
  ///
  /// Note that this method is asynchronous and returns a [Future<void>].
  Future<void> scheduleNotification({
    required int id,
    required String title,
    required String body,
    required Duration nextInterval,
    String? payload,
  }) async {
    final now = TZDateTime.now(local);
    final next = now.add(nextInterval);
    final notificationDetails = getNotificationDetails();
    await _flutterLocalNotificationsPlugin.zonedSchedule(
      id,
      title,
      body,
      next,
      notificationDetails,
      payload: payload,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle
    );
  }

  /// Schedule a local notification to be shown at a specified time in the future
  /// and then repeat at a specified interval.
  ///
  /// [id] is the unique identifier of the notification.
  ///
  /// [title] is the title of the notification.
  ///
  /// [body] is the body of the notification.
  ///
  /// [scheduledDate] is the time at which the notification should first be shown.
  ///
  /// [interval] is the interval at which the notification should be repeated.
  ///
  /// [payload] is a string used to pass data to the app when the user taps
  /// on the notification.
  ///
  /// The notification will be scheduled to be shown at [scheduledDate] time and
  /// then repeated at [interval] interval.
  /// The [payload] will be passed to the app when the user taps on the notification.
  ///
  /// Note that this method is asynchronous and returns a [Future<void>].
  Future<void> periodicallyNotification({
    required int id,
    required String title,
    required String body,
    required TZDateTime scheduledDate,
    required RepeatInterval interval,
    String? payload,
  }) async {
    final notificationDetails = getNotificationDetails();
    await _flutterLocalNotificationsPlugin.periodicallyShow(
      id,
      title,
      body,
      interval,
      notificationDetails,
      payload: payload,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
    );
  }

  /// Schedules a notification to be shown at a specified time in the future
  /// and then repeat at a specified duration interval.
  ///
  /// [id] is the unique identifier of the notification.
  ///
  /// [title] is the title of the notification.
  ///
  /// [body] is the body of the notification.
  ///
  /// [interval] is the duration from now until the notification should be shown
  /// and then repeated.
  ///
  /// [payload] is a string used to pass data to the app when the user taps
  /// on the notification.
  ///
  /// The notification will be scheduled to be shown at [interval] time from now
  /// and then repeated at [interval] interval.
  /// The [payload] will be passed to the app when the user taps on the notification.
  ///
  /// Note that this method is asynchronous and returns a [Timer] that can be
  /// used to cancel the notification.
  Timer periodicallyNotificationWithDuration({
    required int id,
    required String title,
    required String body,
    required Duration interval,
    String? payload,
  }) {
    // Fires notifications on the specified interval while app is alive
    return Timer.periodic(interval, (_) async {
      await showNotification(
        id: id,
        title: title,
        body: body,
        payload: payload,
      );
    });
  }

  /// Returns the platform-specific notification details that should be used
  /// when showing notifications.
  ///
  /// This will be used as the default notification details when calling
  /// [showNotification] or [scheduleNotification].
  NotificationDetails getNotificationDetails({RemoteMessage? message}) {
    final subTxt = message != null
      ? DateFormat('yyyy-MM-dd HH:mm:ss').format(message.sentTime ?? DateTime.now())
      : null;

    final androidDetails = AndroidNotificationDetails(
      defaultChannel.id,
      defaultChannel.name,
      actions: <AndroidNotificationAction>[
        const AndroidNotificationAction(
          'action_1',
          'Dismiss',
          cancelNotification: true,
          showsUserInterface: true,
        ),
        const AndroidNotificationAction(
          'action_2',
          'Setting',
          showsUserInterface: true,
        ),
      ],
      channelDescription: defaultChannel.description,
      importance: Importance.max,
      priority: Priority.high,
      icon: 'notification',
      playSound: true,
      timeoutAfter: 5000,
      showWhen: true,
      subText: subTxt,
    );

    const iosDetails = DarwinNotificationDetails();

    return NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );
  }

  /// Cancel a specific notification.
  ///
  /// [id] is the unique identifier of the notification to cancel.
  ///
  /// This is an asynchronous operation and will return a [Future<void>].
  Future<void> cancelNotification(int id) async {
    await _flutterLocalNotificationsPlugin.cancel(id);
  }

  /// Cancel all notifications.
  ///
  /// This is an asynchronous operation and will return a [Future<void>].
  /// Cancel all pending notifications.
  ///
  /// This is an asynchronous operation and will return a [Future<void>].
  ///
  /// This operation will cancel all notifications that are currently scheduled
  /// to be shown but have not yet been shown.
  Future<void> cancelNotifications() async {
    await _flutterLocalNotificationsPlugin.cancelAll();
  }

  /// Cancel all pending notifications.
  ///
  /// This is an asynchronous operation and will return a [Future<void>].
  ///
  /// This operation will cancel all notifications that are currently scheduled
  /// to be shown but have not yet been shown.
  ///
  /// This operation is separate from [cancelNotifications] which will cancel
  /// all notifications, whether they have been shown or not.
  Future<void> cancelPendingNotifications() async {
    await _flutterLocalNotificationsPlugin.cancelAllPendingNotifications();
  }
}