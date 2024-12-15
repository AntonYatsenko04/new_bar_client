import 'package:bar_client/core/src/constants/api_constants.dart';
import 'package:bar_client/service/models/broadcast/broadcast_model_request.dart';
import 'package:bar_client/service/models/broadcast/broadcast_model_response.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';

part 'broadcast_provider.g.dart';

@RestApi()
abstract class BroadcastProvider {
  factory BroadcastProvider(Dio dio, {String baseUrl}) = _BroadcastProvider;

  @GET(ApiConstants.broadcast)
  Future<List<BroadcastModelResponse>> getBroadCasts();

  @POST(ApiConstants.broadcast)
  Future<void> createBroadcast(@Body() BroadcastModelRequest request);

  @DELETE('${ApiConstants.broadcast}/{id}')
  Future<void> deleteBroadcast(@Path() int id);

  @PATCH('${ApiConstants.broadcast}/{id}')
  Future<void> updateBroadcast(
    @Body() BroadcastModelRequest request,
    @Path() int id,
  );
}
