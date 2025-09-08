import 'package:animations/animations.dart';
import 'package:flutter/material.dart';

/// Fade
/// The fade pattern is used for UI elements that enter or exit within the bounds of the screen, such as a dialog that fades in the center of the screen.
/// Examples of the fade pattern:
///
/// 1. A dialog
/// 2. A menu
/// 3. A snackbar
/// 4. A FAB
class FadeWrapper extends StatelessWidget {
  const FadeWrapper({
    super.key,
    required this.controller,
    required this.target,
  });

  final AnimationController controller;
  final Widget target;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (BuildContext context, Widget? child) {
        return FadeScaleTransition(
          animation: controller,
          child: child,
        );
      },
      child: target,
    );
  }
}
