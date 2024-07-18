import 'dart:developer' as developer;

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
            dateTimeFormat: DateTimeFormat.dateAndTime, // Using instead of printTime(@Deprecated)
        ), // Use the PrettyPrinter to format and print log
        output: null, // Use the default LogOutput (-> send everything to console)
      );
  }

  late Logger logger;

  final err = Error();

  static final AppLogger _instance = AppLogger._internal();

  factory AppLogger() => _instance;

  /// Logger level
  void t(dynamic message, {bool isErr = false}) {
    logger.log(Level.trace, message, error: isErr ? err : '', stackTrace: isErr ? err.stackTrace : null);
  }

  void d(dynamic message, {bool isErr = false}) {
    logger.log(Level.debug, message, error: isErr ? err : '', stackTrace: isErr ? err.stackTrace : null);
  }

  void i(dynamic message, {bool isErr = false}) {
    logger.log(Level.info, message, error: isErr ? err : '', stackTrace: isErr ? err.stackTrace : null);
  }

  void w(dynamic message, {bool isErr = false}) {
    logger.log(Level.warning, message, error: isErr ? err : '', stackTrace: isErr ? err.stackTrace : null);
  }

  void e(dynamic message, {bool isErr = false}) {
    logger.log(Level.error, message, error: isErr ? err : '', stackTrace: isErr ? err.stackTrace : null);
  }

  void fatal(dynamic message, {bool isErr = false}) {
    logger.log(Level.fatal, message, error: isErr ? err : '', stackTrace: isErr ? err.stackTrace : null);
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

class DevLog {
  static void log(String mess) => developer.log('🦊 - $mess');
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
