import 'dart:async';

import 'package:bar_client/service/models/weights/weights_model.dart';
import 'package:bar_client/service/services/weights_service.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../core/src/logger/logger.dart';
import '../../../service/exceptions/app_exception.dart';

part 'weights_state.dart';

class WeightsCubit extends Cubit<WeightsState> {
  final WeightsService _weightsService;

  WeightsCubit({
    required WeightsService weightsService,
  })  : _weightsService = weightsService,
        super(LoadingState());

  Future<void> getWeights() async {
    try {
      emit(LoadingState());
      final WeightsModel weights = await _weightsService.getWeights();
      emit(DataState(weights: weights));
    } on AppException catch (e, st) {
      AppLogger().error(error: e, stackTrace: st);
      emit(ErrorState(errorMessage: e.errorMessageKey));
    }
  }

  Future<void> putWeights({required WeightsModel weights}) async {
    try {
      emit(LoadingState());
      await _weightsService.putWeights(weights: weights);
      unawaited(getWeights());
    } on AppException catch (e, st) {
      AppLogger().error(error: e, stackTrace: st);
      emit(ErrorState(errorMessage: e.errorMessageKey));
    }
  }
}
