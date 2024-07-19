import 'package:flutter_local_notifications/flutter_local_notifications.dart';

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