import 'dart:ui';

// Previously, Color had the concept of opacity, which showed up in the methods opacity and withOpacity().
// Opacity was introduced as a way to communicate with Color about its alpha channel using floating-point values.
// Now that alpha is a floating-point value, opacity is redundant, and both opacity and withOpacity are deprecated and slated to be removed.
// Update Deprecated Method:
// Before final x = color.withOpacity(0.0);
// After final x = color.withValues(alpha: 0.0);
extension ColorExtension on Color {
  Color withOpacities(double opacity) => withValues(alpha: opacity);
}