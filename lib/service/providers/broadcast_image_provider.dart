import 'package:bar_client/core/src/constants/api_constants.dart';
import 'package:bar_client/service/models/broadcast/broadcast_image_model.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';

part 'broadcast_image_provider.g.dart';

@RestApi()
abstract class BroadcastImageProvider {
  factory BroadcastImageProvider(Dio dio, {String baseUrl}) = _BroadcastImageProvider;

  @GET(ApiConstants.broadcastImageResources)
  Future<List<BroadcastImageModel>> getBroadcastImages();

  @POST(ApiConstants.broadcastImageToDb)
  Future<void> uploadBroadcastImageToDb(@Body() BroadcastImageModel request);

  @POST(ApiConstants.broadcastImageToFile)
  Future<void> uploadBroadcastImageToFile(@Body() BroadcastImageModel request);
}
