import 'dart:async';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';

import '../utils/app_connection.dart';
import '../utils/app_logger.dart';

class ApiRetryInterceptor extends Interceptor {
  final DioConnectivityRequestRetries requestRetries;

  ApiRetryInterceptor({
    required this.requestRetries,
  });

  @override
  Future<void> onError(DioException err, ErrorInterceptorHandler handler) async {
    if (_shouldRetry(err)) {
      try {
        return requestRetries.scheduleRequestRetry(err.requestOptions, handler);
      } catch (e) {
        AppLogger().e(e);
      }
    }
    // Let the error "pass through" if it's not the error we're looking for
    AppLogger().e(err);
  }

  bool _shouldRetry(DioException err) {
    return err.type == DioExceptionType.unknown &&
        err.error != null &&
        (err.error is SocketException || err.error is ArgumentError);
  }
}

class DioConnectivityRequestRetries {
  final Dio dio;
  final Connectivity connectivity;

  final AppConnection _appConnection = AppConnection();

  DioConnectivityRequestRetries({
    required this.dio,
    required this.connectivity,
  });

  Future<dynamic> scheduleRequestRetry(RequestOptions requestOptions, ErrorInterceptorHandler handler) async {
    late StreamSubscription? streamSubscription;

    void onListenConnectivity(List<ConnectivityResult> connectStatus) async {
      // We're connected either to WiFi or mobile data
      if (!connectStatus.contains(ConnectivityResult.none)) {
        if(streamSubscription != null) {
          streamSubscription.cancel();
        }
        final result = await dio.requestUri(
          requestOptions.uri,
          cancelToken: requestOptions.cancelToken,
          data: requestOptions.data,
          onReceiveProgress: requestOptions.onReceiveProgress,
          onSendProgress: requestOptions.onSendProgress,
          //queryParameters: requestOptions.queryParameters,
          options: Options(
              method: requestOptions.method,
              headers: requestOptions.headers
          ),
        );

        return handler.resolve(result);
      }
    }

    streamSubscription = _appConnection.connectivityStream.listen(onListenConnectivity);
  }
}