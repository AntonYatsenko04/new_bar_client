part of 'add_image_cubit.dart';

@immutable
sealed class AddImageState {}

final class LoadingState implements AddImageState {}

@freezed
class DataState with _$DataState implements AddImageState {
  const DataState._();

  const factory DataState({
    required List<BroadcastModelResponse> broadcasts,
    @Default(false) bool saveToSeparateFile,
    @Default(false) bool blockSendImageButton,
    BroadcastModelResponse? selectedBroadcast,
    Uint8List? imageBytes,
    String? commonError,
  }) = _DataState;

  bool get canSendImage => !blockSendImageButton && selectedBroadcast != null && imageBytes != null;
}

class ErrorState implements AddImageState {
  final String errorMessage;

  ErrorState({required this.errorMessage});
}
