import 'package:dio/dio.dart';
import 'package:flutter_temp/models/responses/object_response.dart';
import 'package:retrofit/retrofit.dart';

part 'app_api.g.dart';

@RestApi()
abstract class AppApi {
  factory AppApi(Dio dio, {String baseUrl}) = _AppApi;

  @GET('/user')
  Future<ObjectResponse> onFetchUserData();
  // @GET('')
  // @POST('')
  // @PATCH('')
  // @PUT('')
  // @DELETE('')
}
