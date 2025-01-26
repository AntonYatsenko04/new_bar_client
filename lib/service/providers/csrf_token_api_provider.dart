import 'package:bar_client/service/models/auth/sign_in_model.dart';
import 'package:bar_client/service/models/auth/token_model.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../core/src/constants/api_constants.dart';

part 'csrf_token_api_provider.g.dart';

@RestApi()
abstract class CsrfTokenApiProvider {
  factory CsrfTokenApiProvider(Dio dio, {String baseUrl}) = _CsrfTokenApiProvider;

  @GET(ApiConstants.csrfToken)
  Future<TokenModel> getToken();

  @POST(ApiConstants.attack)
  Future<void> sendUserData(@Body() SignInModel data);
}
