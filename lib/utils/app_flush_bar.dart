import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_temp/ext/flush_ext.dart';

import '../common/app_enums.dart';

class AppFlushBar {
  static void showFlushBar(
      BuildContext context, {
        FlushType? type,
        String? title,
        String? message,
        int? duration,
        FlushbarPosition? position,
      }) {
    Flushbar(
      title: title ?? (type ?? FlushType.notification).flushTitle,
      // titleColor: ,
      // titleSize: ,
      message: message ?? '',
      // messageSize: ,
      // messageColor: ,
      // titleText: , Widget
      // messageText: , Widget
      icon: (type ?? FlushType.notification).flushIcon,
      shouldIconPulse: true,
      margin: const EdgeInsets.all(0),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      textDirection: TextDirection.ltr,
      backgroundColor: (type ?? FlushType.notification).flushBg,
      duration: Duration(minutes: duration ?? 2),
      flushbarPosition: position ?? FlushbarPosition.TOP,
      leftBarIndicatorColor: Colors.pink,
      isDismissible: true,
      dismissDirection: FlushbarDismissDirection.HORIZONTAL,
      flushbarStyle: FlushbarStyle.GROUNDED,
      forwardAnimationCurve: Curves.easeOutCirc,
      reverseAnimationCurve: Curves.easeOutCirc,
      animationDuration: const Duration(seconds: 1),
    ).show(context);
  }
}
