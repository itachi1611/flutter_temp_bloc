import 'package:animations/animations.dart';
import 'package:flutter/material.dart';

/// Shared axis
/// The shared axis pattern is used for transitions between UI elements that have a spatial or navigational relationship.
/// This pattern uses a shared transformation on the x, y, or z axis to reinforce the relationship between elements.
/// Examples of the shared axis pattern:
///
/// 1. An onboarding flow transitions along the x-axis
/// 2. A stepper transitions along the y-axis
/// 3. A parent-child navigation transitions along the z-axis
class SharedAxisTransitionWrapper extends StatelessWidget {
  const SharedAxisTransitionWrapper({
    super.key,
    required this.isReverse,
    required this.transitionType,
    required this.target,
  });

  final bool isReverse;

  /// Creates a shared axis vertical (y-axis) page transition. vertical,
  /// Creates a shared axis horizontal (x-axis) page transition. horizontal,
  /// Creates a shared axis scaled (z-axis) page transition. scaled,
  final SharedAxisTransitionType transitionType;
  final Widget target;

  @override
  Widget build(BuildContext context) {
    return PageTransitionSwitcher(
      duration: const Duration(milliseconds: 350),
      reverse: isReverse,
      transitionBuilder: (
        Widget child,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
      ) {
        return SharedAxisTransition(
          animation: animation,
          secondaryAnimation: secondaryAnimation,
          transitionType: transitionType,
          child: child,
        );
      },
      child: target,
    );
  }
}
