import 'package:dio/dio.dart';
import 'package:flutter_temp/models/responses/array_response.dart';
import 'package:retrofit/retrofit.dart';

import '../common/app_config.dart';

part 'app_api.g.dart';

@RestApi(baseUrl: AppConfig.baseUrl)
abstract class AppApi {
  factory AppApi(Dio dio, {String baseUrl}) = _AppApi;

  // @GET('')
  // @POST('')
  // @PATCH('')
  // @PUT('')
  // @DELETE('')
}
