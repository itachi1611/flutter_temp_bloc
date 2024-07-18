import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter_temp/network/app_api.dart';

import '../common/app_config.dart';
import '../common/app_constants.dart';
import 'api_interceptors.dart';
import 'api_logger.dart';
import 'api_retry_interceptors.dart';

class ApiUtil {
  late final Dio dio;
  late final AppApi appApi;

  ApiUtil._privateConstructor() {
    dio = Dio();

    dio.options.connectTimeout = const Duration(milliseconds: AppConstants.connectTimeout);
    dio.interceptors.add(ApiInterceptors());

    /// Retry request when no internet connection
    dio.interceptors.add(
      ApiRetryInterceptor(
        requestRetries: DioConnectivityRequestRetries(
          dio: dio,
          connectivity: Connectivity(),
        ),
      ),
    );

    /// Choose network call logger
    /// No style
    dio.interceptors.add(ApiLogger(
      request: true,
      requestHeader: false,
      requestBody: true,
      responseBody: true,
      responseHeader: false,
      error: true,
      compact: true,
      maxWidth: 120
    ));

    // dio.interceptors.add(StyleApiLogger(logger: debugPrint)); // With style

    appApi = AppApi(dio, baseUrl: AppConfig.baseUrl);
  }

  static final ApiUtil instance = ApiUtil._privateConstructor();
}