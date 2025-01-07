import 'package:bar_client/core/src/constants/api_constants.dart';
import 'package:bar_client/service/models/weights/weights_model.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';

part 'weights_provider.g.dart';

@RestApi()
abstract class WeightsProvider {
  factory WeightsProvider(Dio dio, {String baseUrl}) = _WeightsProvider;

  @GET('${ApiConstants.weights}/{id}')
  Future<WeightsModel> getWeights({@Path('id') int id = 1});

  @PUT('${ApiConstants.weights}/{id}')
  Future<void> putWeights({
    @Path('id') int id = 1,
    @Body() required WeightsModel weights,
  });
}
