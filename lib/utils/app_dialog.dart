import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_temp/extensions/widget_ext.dart';
import 'package:flutter_temp/utils/app_logger.dart';
// import 'package:vector_math/vector_math.dart' as math;

class AppDialog {

  static void showAlertDialog(
    BuildContext mContext, {
    required String title,
    required String content,
  }) {
    if (Platform.isIOS) {
      showCupertinoDialog(
        context: mContext,
        builder: (mCtx) {
          return AlertDialog(
            title: Text(title),
            content: Text(content),
            actions: [
              InkWell(
                onTap: () => info('title'),
                child: const Text('Ok'),
              ),
              InkWell(
                onTap: () => info('title'),
                child: const Text('Cancel'),
              ),
            ],
          );
        },
      );
    } else {
      showDialog(
        context: mContext,
        builder: (mCtx) {
          return AlertDialog(
            title: Text(title),
            content: Text(content),
            actions: [
              InkWell(
                onTap: () => info('title'),
                child: const Text('Ok'),
              ),
              InkWell(
                onTap: () => info('title'),
                child: const Text('Cancel'),
              ),
            ],
          );
        },
      );
    }
  }

  static void showCustomAlertDialog(
    BuildContext mContext, {
    required String title,
    required String content,
  }) {
    if(Platform.isIOS) {
      showCupertinoDialog(
        context: mContext,
        builder: (mCtx) {
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ), //this right here
            child: Container(
              constraints: const BoxConstraints(
                maxHeight: 200,
                minHeight: 180,
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const CircleAvatar(child: FlutterLogo()),
                    const TextField(
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'What do you want to remember?'),
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        textStyle: const TextStyle(color: Colors.white),
                      ),
                      child: const Text("Save"),
                    ).center
                  ],
                ),
              ),
            ),
          );
        },
      );
    } else {
      showDialog(
        context: mContext,
        builder: (mCtx) {
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ), //this right here
            child: Container(
              constraints: const BoxConstraints(
                maxHeight: 200,
                minHeight: 180,
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const CircleAvatar(child: FlutterLogo()),
                    const TextField(
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'What do you want to remember?'),
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        textStyle: const TextStyle(color: Colors.white),
                      ),
                      child: const Text("Save"),
                    ).center
                  ],
                ),
              ),
            ),
          );
        },
      );
    }
  }

  static void showCustomDialog(
    BuildContext mContext, {
    required String title,
    required String content,
    bool barrierDismissible = false,
    String? barrierLabel,
    Color? barrierColor,
    Duration? transitionDuration,
    RouteTransitionsBuilder? transitionBuilder,
    bool? useRootNavigator,
    RouteSettings? routeSettings,
    Offset? anchorPoint,
  }) {
    showGeneralDialog(
      context: mContext,
      pageBuilder: (mCtx, a1, a2) {
        return AlertDialog(
          shape: OutlineInputBorder(borderRadius: BorderRadius.circular(16.0)),
          title: Text(title),
          content: Text(content),
        );
      },
      barrierDismissible: barrierDismissible,
      barrierLabel: barrierLabel,
      barrierColor: barrierColor ?? const Color(0x80000000),
      transitionDuration:
          transitionDuration ?? const Duration(milliseconds: 250),
      transitionBuilder: (mCtx, a1, a2, child) {
        // Rotate + Opacity
        // return Transform.rotate(
        //   angle: math.radians(a1.value * 360),
        //   child: Opacity(
        //     opacity: a1.value,
        //     child: child,
        //   ),
        // );

        // EaseInOutBack
        // return Transform(
        //   transform: Matrix4.translationValues(0.0, Curves.easeInOutBack.transform(a1.value) -   1.0 * 200, 0.0),
        //   child: Opacity(
        //     opacity: a1.value,
        //     child: child,
        //   ),
        // );

        // Scale
        return Transform.scale(
          scale: a1.value,
          child: Opacity(
            opacity: a1.value,
            child: child,
          ),
        );
      },
      useRootNavigator: useRootNavigator ?? true,
      routeSettings: routeSettings,
      anchorPoint: anchorPoint,
    );
  }
}
