import 'package:flutter/material.dart';
import 'package:flutter_temp/utils/app_logger.dart';

class RouterObserver extends NavigatorObserver {
  final _logger = AppLogger();

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    _logger.i('PUSH TO $route FROM $previousRoute');
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    _logger.i('POP TO $route FROM $previousRoute');
  }

  @override
  void didRemove(Route route, Route? previousRoute) {
    _logger.i('REMOVE $route FROM $previousRoute');
  }

  @override
  void didReplace({Route? newRoute, Route? oldRoute}) {
    _logger.i('REPLACE ROUTER $newRoute BY $oldRoute');
  }

  @override
  void didStartUserGesture(Route<dynamic> route, Route<dynamic>? previousRoute) => _logger.i('didStartUserGesture: $route, previousRoute= $previousRoute');

  @override
  void didStopUserGesture() => _logger.i('didStopUserGesture');
}