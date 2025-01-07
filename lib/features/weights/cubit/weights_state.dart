part of 'weights_cubit.dart';

@immutable
sealed class WeightsState {}

final class LoadingState extends WeightsState {}

final class DataState extends WeightsState {
  final WeightsModel weights;

  DataState({
    required this.weights,
  });
}

final class ErrorState extends WeightsState {
  final String errorMessage;

  ErrorState({
    required this.errorMessage,
  });
}
