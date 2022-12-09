//import 'dart:io' as io;

import 'package:logger/logger.dart';

class AppLogger {
  AppLogger._internal() {
    logger = Logger(
        filter: null, // Use the default LogFilter (-> only log in debug mode)
        printer: PrettyPrinter(
            methodCount: 0, // number of method calls to be displayed
            errorMethodCount: 5, // number of method calls if stacktrace is provided
            lineLength: 120, // width of the output (detect auto with io package io.stdout.terminalColumns)
            colors: true, // Colorful log messages (detect auto with io package io.stdout.supportsAnsiEscapes)
            printEmojis: true, // Print an emoji for each log message
            printTime: false, // Should each log print contain a timestamp
        ), // Use the PrettyPrinter to format and print log
        output: null, // Use the default LogOutput (-> send everything to console)
      );
  }

  late Logger logger;

  final err = Error();

  static final AppLogger _instance = AppLogger._internal();

  static AppLogger get instance =>  _instance;

  /// Logger level
  void v(dynamic message, {bool isErr = false}) {
    logger.log(Level.verbose, message, isErr ? err : '', isErr ? err.stackTrace : null);
  }

  void d(dynamic message, {bool isErr = false}) {
    logger.log(Level.debug, message, isErr ? err : '', isErr ? err.stackTrace : null);
  }

  void i(dynamic message, {bool isErr = false}) {
    logger.log(Level.info, message, isErr ? err : '', isErr ? err.stackTrace : null);
  }

  void w(dynamic message, {bool isErr = false}) {
    logger.log(Level.warning, message, isErr ? err : '', isErr ? err.stackTrace : null);
  }

  void e(dynamic message, {bool isErr = false}) {
    logger.log(Level.error, message, isErr ? err : '', isErr ? err.stackTrace : null);
  }

  void wtf(dynamic message, {bool isErr = false}) {
    logger.log(Level.wtf, message, isErr ? err : '', isErr ? err.stackTrace : null);
  }
}

class AppFilter extends LogFilter {
  @override
  bool shouldLog(LogEvent event) {
    if(event.level == Level.error || event.level == Level.warning) {
      return true;
    }

    return false; // Allow log on production mode
  }
}

// class AppPrinter extends LogPrinter {
//   final String className;
//   AppPrinter(this.className);
//
//   @override
//   List<String> log(LogEvent event) {
//     var color = PrettyPrinter.levelColors[event.level];
//     var emoji = PrettyPrinter.levelEmojis[event.level];
//
//     switch(event.level) {
//       case Level.verbose:
//
//         break;
//       case Level.debug:
//
//         break;
//       case Level.info:
//
//         break;
//       case Level.warning:
//
//         break;
//       case Level.error:
//
//         break;
//       case Level.wtf:
//
//         break;
//       default:
//         break;
//     }
//
//     //return (color('$emoji $className - ${event.message}'));
//   }
// }
