import 'package:animations/animations.dart';
import 'package:flutter/material.dart';

/// Fade through
/// The fade through pattern is used for transitions between UI elements that do not have a strong relationship to each other.
/// Examples of the fade through pattern:
///
/// 1. Tapping destinations in a bottom navigation bar
/// 2. Tapping a refresh icon
/// 3. Tapping an account switcher
class FadeThroughWrapper extends StatelessWidget {
  const FadeThroughWrapper({
    super.key,
    required this.isReverse,
    required this.target,
  });

  final bool isReverse;
  final Widget target;

  @override
  Widget build(BuildContext context) {
    return PageTransitionSwitcher(
      reverse: isReverse,
      transitionBuilder: (
        Widget child,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
      ) {
        return FadeThroughTransition(
          animation: animation,
          secondaryAnimation: secondaryAnimation,
          child: child,
        );
      },
      child: target,
    );
  }
}
