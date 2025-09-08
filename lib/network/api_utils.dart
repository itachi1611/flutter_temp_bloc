import 'package:dio/dio.dart';
import 'package:flutter_temp/network/api_client.dart';
import 'package:flutter_temp/network/dio_logger_interceptor.dart';

import '../common/app_constants.dart';
import 'api_interceptors.dart';
import 'api_retry_interceptor.dart';
import 'curl_logger_interceptor.dart';

class ApiUtil {
  static Dio? dio;

  ApiUtil._internal();
  
  static final ApiUtil _apiUtil = ApiUtil._internal();

  factory ApiUtil() => _apiUtil;
  
  static Dio getDio() {
    if(dio == null) {
      dio = Dio();
      dio!.options.connectTimeout = const Duration(milliseconds: AppConstants.connectTimeout);
      dio!.options.baseUrl = '';
      dio!.interceptors.add(ApiInterceptors());
      dio!.interceptors.add(DioLoggerInterceptor());
      dio!.interceptors.add(CurlLoggerInterceptors());
      /// Retry request when no internet connection
      dio!.interceptors.add(ApiRetryInterceptor(requestRetries: DioConnectivityRequestRetries(dio: dio!)));
    }
    return dio!;
  }

  ApiClient getApiClient() {
    final apiClient = ApiClient(getDio());
    return apiClient;
  }
}