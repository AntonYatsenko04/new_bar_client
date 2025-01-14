part of 'broadcast_list_cubit.dart';

@immutable
sealed class BroadcastListState {}

@freezed
class DataState with _$DataState implements BroadcastListState {
  const DataState._();

  const factory DataState({
    required List<BroadcastModelResponse> broadcasts,
    required List<BroadcastImageUiModel> broadcastImages,
    required List<String> searchSuggestions,
    List<BroadcastModelResponse>? filteredBroadcasts,
  }) = _DataState;

  List<BroadcastModelResponse> get currentBroadcasts => filteredBroadcasts ?? broadcasts;

  Uint8List? getBroadcastImage(int id) {
    for (final BroadcastImageUiModel broadcastImage in broadcastImages) {
      if (broadcastImage.broadcastId == id) {
        return broadcastImage.image;
      }
    }

    return null;
  }
}

final class ErrorState implements BroadcastListState {
  final String errorMessage;

  ErrorState({required this.errorMessage});
}

final class LoadingState implements BroadcastListState {}
