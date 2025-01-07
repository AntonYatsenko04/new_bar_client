import 'package:bar_client/service/providers/weights_provider.dart';
import 'package:bar_client/service/safe_request/safe_request.dart';

import '../models/weights/weights_model.dart';

class WeightsService {
  final WeightsProvider _weightsProvider;

  WeightsService({
    required WeightsProvider weightsProvider,
  }) : _weightsProvider = weightsProvider;

  Future<WeightsModel> getWeights() {
    return safeRequest(_weightsProvider.getWeights);
  }

  Future<void> putWeights({required WeightsModel weights}) {
    return safeRequest(() => _weightsProvider.putWeights(weights: weights));
  }
}
