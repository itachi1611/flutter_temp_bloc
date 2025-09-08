import 'dart:developer' as dev;

import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

class ErrorLogger implements ParseErrorLogger {
  @override
  void logError(Object error, StackTrace stackTrace, RequestOptions options) {
    // Write detail request logs
    dev.log('---- API ERROR ----');
    dev.log('URL: ${options.baseUrl}${options.path}');
    dev.log('Method: ${options.method}');
    dev.log('Headers: ${options.headers}');
    dev.log('QueryParams: ${options.queryParameters}');
    dev.log('Data: ${options.data}');

    // Write error logs
    dev.log('Error: $error');
    dev.log('StackTrace: $stackTrace');
    dev.log('-------------------');

    // Also can be included
    // - send log to Sentry
    // - write log to local
    // - show toast
  }
  
}