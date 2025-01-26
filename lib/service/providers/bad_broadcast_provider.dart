import 'package:bar_client/core/src/constants/api_constants.dart';
import 'package:bar_client/service/models/broadcast/broadcast_model_request.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';

part 'bad_broadcast_provider.g.dart';

@RestApi(baseUrl: ApiConstants.xamppBaseUrl)
abstract class BadBroadcastProvider {
  factory BadBroadcastProvider(Dio dio, {String baseUrl}) = _BadBroadcastProvider;

  @POST(ApiConstants.xamppSqlIn)
  Future<void> createBroadcast(@Body() BroadcastModelRequest request);
}
