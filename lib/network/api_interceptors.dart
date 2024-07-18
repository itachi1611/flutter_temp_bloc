import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class ApiInterceptors extends InterceptorsWrapper {
  @override
  Future<void> onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    final method = options.method;
    final uri = options.uri;
    final data = options.data;
    debugPrint("✈️ REQUEST[$method] => PATH: $uri \n Token: ${options.headers} \n Data: $data");

    return super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    final statusCode = response.statusCode;
    final uri = response.requestOptions.uri;
    final data = jsonEncode(response.data);
    debugPrint("✅ RESPONSE[$statusCode] => PATH: $uri\n DATA: $data");
    super.onResponse(response, handler);
  }

  @override
  Future<void> onError(DioException err, ErrorInterceptorHandler handler) async {
    final statusCode = err.response?.statusCode;
    final path = err.requestOptions.path;
    // final uri = err.requestOptions.uri;
    // final RequestOptions request = err.requestOptions;

    debugPrint("⚠️ ERROR[$statusCode] => PATH: $path");

    /**
     * Define the response status list, and how to handle
     * ! For returning 401, you can try to refresh your old token using the refreshToken to fetch new accessToken
     */

    switch (statusCode) {
      case 401:
        return super.onError(err, handler);
      case 404:
        return super.onError(err, handler);
      default:
        return super.onError(err, handler);
    }
  }
}