import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class DioLoggerInterceptor extends PrettyDioLogger {
  /// private constructor
  DioLoggerInterceptor._internal() : super(
    requestHeader: false,
    requestBody: false,
    responseBody: false,
    responseHeader: false,
    error: true,
    compact: true,
    maxWidth: 120,
    enabled: true,
    // filter: (options, args){
    //   // don't print requests with uris containing '/posts'
    //   if(options.path.contains('/posts')){
    //     return false;
    //   }
    //   // don't print responses with unit8 list data
    //   return !args.isResponse || !args.hasUint8ListData;
    // }
  );

  static final DioLoggerInterceptor _instance = DioLoggerInterceptor._internal();
  factory DioLoggerInterceptor() => _instance;
}

