import 'package:animated_snack_bar/animated_snack_bar.dart';

enum LoadStatus {
  initial,
  loading,
  success,
  fail,
}

enum ConnectionStatus {
  mobileOnline('Mobile network connected'),
  mobileOffline('Mobile network problem'),
  wifiOnline('Wifi network connected'),
  wifiOffline('Wifi network problem'),
  offline('No network');

  final String message;

  const ConnectionStatus(this.message);
}

enum FlushType {
  notification,
  success,
  warning,
  error,
}

enum SnackBarType {
  info(AnimatedSnackBarType.info),
  error(AnimatedSnackBarType.error),
  success(AnimatedSnackBarType.success),
  warning(AnimatedSnackBarType.warning);

  final AnimatedSnackBarType snackBarType;

  const SnackBarType(this.snackBarType);
}

enum ButtonType {
  text,
  elevated,
  outlined,
}

enum FirstRunNavigationType {
  firstRun,
  notFirstRun,
}

enum LoadingAnimationType {
  beat('beat'),
  bouncingBall('bouncingBall'),
  discreteCircle('discreteCircle'),
  dotsTriangle('dotsTriangle'),
  fallingDot('fallingDot'),
  flickr('flickr'),
  fourRotatingDots('fourRotatingDots'),
  halfTriangleDot('halfTriangleDot'),
  hexagonDots('hexagonDots'),
  horizontalRotatingDots('horizontalRotatingDots'),
  inkDrop('inkDrop'),
  newtonCradle('newtonCradle'),
  prograssiveDots('prograssiveDots'),
  staggeredDotsWave('staggeredDotsWave'),
  stretchedDots('stretchedDots'),
  threeArchedCircle('threeArchedCircle'),
  threeRotatingDots('threeRotatingDots'),
  twistingDots('twistingDots'),
  twoRotatingArc('twoRotatingArc'),
  waveDots('waveDots');

  final String title;

  const LoadingAnimationType(this.title);
}

enum LaunchExternalType {
  sms('sms'),
  tel('tel'),
  mail('mailto'),
  webview('https'),
  file('file');

  final String type;

  const LaunchExternalType(this.type);
}
