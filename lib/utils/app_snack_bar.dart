import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';

import '../ext/snack_ext.dart';

class AppSnackBar {
  static final AppSnackBar _instance = AppSnackBar._internal();

  static AppSnackBar get instance => _instance;

  AppSnackBar._internal();

  /// AnimatedSnackBarType
  // .info
  // .error
  // .success
  // .warning

  static void showMaterialSnackBar(
    BuildContext context, {
    required String messageText,
    required AnimatedSnackBarType type,
    BorderRadius? borderRadius,
    DesktopSnackBarPosition? desktopSnackBarPosition,
    MobileSnackBarPosition? mobileSnackBarPosition,
    Duration? duration,
  }) {
    AnimatedSnackBar.material(
      messageText,
      type: type,
      borderRadius: borderRadius,
      desktopSnackBarPosition: desktopSnackBarPosition ?? DesktopSnackBarPosition.bottomLeft,
      mobileSnackBarPosition: mobileSnackBarPosition ?? MobileSnackBarPosition.top,
      duration: duration ?? const Duration(seconds: 8),
    ).show(context);
  }

  static void showRectangleSnackBar(
    BuildContext context, {
    String? titleText,
    required String messageText,
    required AnimatedSnackBarType type,
    DesktopSnackBarPosition? desktopSnackBarPosition,
    MobileSnackBarPosition? mobileSnackBarPosition,
    Duration? duration,
    Brightness? brightness,
  }) {
    AnimatedSnackBar.rectangle(
      SnackBarExtension.snackBarType(type).snackTitle,
      messageText,
      type: type,
      desktopSnackBarPosition: desktopSnackBarPosition ?? DesktopSnackBarPosition.bottomLeft,
      mobileSnackBarPosition: mobileSnackBarPosition ?? MobileSnackBarPosition.top,
      duration: duration ?? const Duration(seconds: 8),
      brightness: brightness,
    ).show(context);
  }
}
