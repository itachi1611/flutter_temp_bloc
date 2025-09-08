import 'package:animations/animations.dart';
import 'package:flutter/material.dart';

/// Container transform
/// The container transform pattern is designed for transitions between UI elements that include a container.
/// This pattern creates a visible connection between two UI elements.
///
/// Examples of the container transform:
///
/// 1. A card into a details page
/// 2. A list item into a details page
/// 3. A FAB into a details page
/// 4. úA search bar into expanded search
class OpenContainerWrapper extends StatelessWidget {
  const OpenContainerWrapper({
    super.key,
    required this.closedBuilder,
    required this.transitionType,
    required this.onClosed,
    required this.target,
  });

  final CloseContainerBuilder closedBuilder; // Open item widget
  final ContainerTransitionType transitionType; // Transition type
  final ClosedCallback<bool?> onClosed; // Callback with return value from Navigator.pop()
  final Widget target;

  @override
  Widget build(BuildContext context) {
    return OpenContainer<bool>(
      transitionType: transitionType,
      openBuilder: (BuildContext context, VoidCallback _) {
        return target;
      },
      onClosed: onClosed,
      tappable: false,
      closedBuilder: closedBuilder,
    );
  }
}
