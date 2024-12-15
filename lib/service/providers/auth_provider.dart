import 'package:bar_client/core/src/constants/api_constants.dart';
import 'package:bar_client/service/models/auth/sign_in_model.dart';
import 'package:bar_client/service/models/auth/sign_up_model.dart';
import 'package:bar_client/service/models/auth/token_model.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'auth_provider.g.dart';

@RestApi()
abstract class AuthProvider {
  factory AuthProvider(Dio dio, {String baseUrl}) = _AuthProvider;

  @POST(ApiConstants.signIn)
  Future<TokenModel> signIn(@Body() SignInModel model);

  @POST(ApiConstants.signUp)
  Future<void> signUp(@Body() SignInModel model);

  @POST(ApiConstants.signUpWithRole)
  Future<void> signUpWithRole(@Body() SignUpModel model);
}
