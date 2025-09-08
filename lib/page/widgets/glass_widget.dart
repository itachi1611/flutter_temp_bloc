import 'dart:ui';

import 'package:flutter/material.dart';

class GlassWidget extends StatelessWidget {
  const GlassWidget({
    super.key,
    this.borderRadius,
  });

  final double? borderRadius;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius ?? 0),
      child: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Stack(
          children: [
            /// Blur effect
            BackdropFilter(
              filter: ImageFilter.blur(
                sigmaX: 5,
                sigmaY: 5,
              ),
              child: const SizedBox(),
            ),

            /// Gradient effect
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(borderRadius ?? 0),
                border: Border.all(color: Colors.white.withValues(alpha: 0.2)),
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Colors.white.withValues(alpha: 0.4),
                    Colors.white.withValues(alpha: 0.1),
                  ],
                ),
              ),
            ),

            /// Child if need
          ],
        ),
      ),
    );
  }
}
