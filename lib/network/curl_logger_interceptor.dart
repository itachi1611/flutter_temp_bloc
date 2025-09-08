import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';

class CurlLoggerInterceptors extends Interceptor {
  final bool? printOnSuccess;
  final bool convertFormData;

  CurlLoggerInterceptors({this.printOnSuccess, this.convertFormData = true});

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    _renderCurlRepresentation(err.requestOptions);

    return handler.next(err); //continue
  }

  @override
  void onResponse(
      Response response,
      ResponseInterceptorHandler handler,
      ) {
    if (printOnSuccess != null && printOnSuccess == true) {
      _renderCurlRepresentation(response.requestOptions);
    }

    return handler.next(response); //continue
  }

  void _renderCurlRepresentation(RequestOptions requestOptions) {
    // add a breakpoint here so all errors can break
    try {
      log(_cURLRepresentation(requestOptions));
    } catch (err) {
      log('unable to create a CURL representation of the requestOptions');
    }
  }

  String _cURLRepresentation(RequestOptions options) {
    List<String> components = ['curl -i'];
    if (options.method.toUpperCase() != 'GET') {
      components.add('-X ${options.method}');
    }

    options.headers.forEach((k, v) {
      if (k != 'Cookie') {
        components.add('-H "$k: $v"');
      }
    });

    if (options.data != null) {
      if (options.data is FormData && convertFormData) {
        FormData formData = options.data as FormData;
        List<String> formComponents = [];

        // Handle fields
        for (var field in formData.fields) {
          formComponents.add(
              '-F "${field.key}=${field.value}"'); // Standard form-data format
        }

        // Handle files
        for (var file in formData.files) {
          MultipartFile fileData = file.value;
          formComponents.add(
              '-F "${file.key}=@${fileData.filename};type=${fileData.contentType}"');
        }

        components.addAll(formComponents);
      } else {
        final data = json.encode(options.data).replaceAll('"', '\\"');
        components.add('-d "$data"');
      }
    }

    components.add('"${options.uri.toString()}"');

    return components.join(' \\\n\t');
  }
}