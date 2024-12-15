import 'package:bar_client/core/src/constants/api_constants.dart';
import 'package:bar_client/service/models/user/no_role_user_model.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../models/auth/token_model.dart';
import '../models/auth/user_model.dart';

part 'user_provider.g.dart';

@RestApi()
abstract class UserProvider {
  factory UserProvider(Dio dio, {String baseUrl}) = _UserProvider;

  @POST(ApiConstants.userInfo)
  Future<UserModel> getUserInfo(@Body() TokenModel token);

  @GET(ApiConstants.waiterEntities)
  Future<List<NoRoleUserModel>> getWaiters();

  @GET(ApiConstants.cookEntities)
  Future<List<NoRoleUserModel>> getCooks();
}
