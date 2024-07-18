import 'package:flutter/material.dart';
import 'package:flutter_temp/page/widgets/loading/loading_widget.dart';

import '../common/app_enums.dart';

extension LoadingAnimationExtension on LoadingAnimationType {
  static const Color color = Colors.orange;
  static const double size = 20;

  Widget get loadingWidget {
    switch(this) {
      case LoadingAnimationType.beat:
        return LoadingWidget.beat(color: color, size: size);
      case LoadingAnimationType.bouncingBall:
        return LoadingWidget.bouncingBall(color: color, size: size);
      case LoadingAnimationType.discreteCircle:
        return LoadingWidget.discreteCircle(color: color, size: size);
      case LoadingAnimationType.dotsTriangle:
        return LoadingWidget.dotsTriangle(color: color, size: size);
      case LoadingAnimationType.fallingDot:
        return LoadingWidget.fallingDot(color: color, size: size);
      case LoadingAnimationType.flickr:
        return LoadingWidget.flickr(leftDotColor: color, rightDotColor: color, size: size);
      case LoadingAnimationType.fourRotatingDots:
        return LoadingWidget.fourRotatingDots(color: color, size: size);
      case LoadingAnimationType.halfTriangleDot:
        return LoadingWidget.halfTriangleDot(color: color, size: size);
      case LoadingAnimationType.hexagonDots:
        return LoadingWidget.hexagonDots(color: color, size: size);
      case LoadingAnimationType.horizontalRotatingDots:
        return LoadingWidget.horizontalRotatingDots(color: color, size: size);
      case LoadingAnimationType.inkDrop:
        return LoadingWidget.inkDrop(color: color, size: size);
      case LoadingAnimationType.newtonCradle:
        return LoadingWidget.newtonCradle(color: color, size: size);
      case LoadingAnimationType.progressiveDots:
        return LoadingWidget.prograssiveDots(color: color, size: size);
      case LoadingAnimationType.staggeredDotsWave:
        return LoadingWidget.staggeredDotsWave(color: color, size: size);
      case LoadingAnimationType.stretchedDots:
        return LoadingWidget.stretchedDots(color: color, size: size);
      case LoadingAnimationType.threeArchedCircle:
        return LoadingWidget.threeArchedCircle(color: color, size: size);
      case LoadingAnimationType.threeRotatingDots:
        return LoadingWidget.threeRotatingDots(color: color, size: size);
      case LoadingAnimationType.twistingDots:
        return LoadingWidget.twistingDots(leftDotColor: color, rightDotColor: color, size: size);
      case LoadingAnimationType.twoRotatingArc:
        return LoadingWidget.twoRotatingArc(color: color, size: size);
      case LoadingAnimationType.waveDots:
        return LoadingWidget.waveDots(color: color, size: size);
    }
  }
}