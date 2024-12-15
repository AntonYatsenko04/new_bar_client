part of 'broadcast_list_cubit.dart';

@immutable
sealed class BroadcastListState {}

final class DataState implements BroadcastListState {
  final List<BroadcastModelResponse> broadcasts;
  final String? searchString;

  List<BroadcastModelResponse> get filteredBroadcasts {
    if (searchString == null) {
      return broadcasts;
    }

    return broadcasts
        .where(
          (BroadcastModelResponse e) => e.name.trim().toLowerCase().contains(
                searchString!.trim().toLowerCase(),
              ),
        )
        .toList();
  }

  DataState({
    required this.broadcasts,
    this.searchString,
  });

  DataState copyWith({
    required String? searchString,
    List<BroadcastModelResponse>? broadcasts,
  }) {
    return DataState(
      broadcasts: broadcasts ?? this.broadcasts,
      searchString: searchString,
    );
  }

  @override
  String toString() {
    return 'DataState{broadcasts: $broadcasts, searchString: $searchString}';
  }
}

final class ErrorState implements BroadcastListState {
  final String errorMessage;

  ErrorState({required this.errorMessage});
}

final class LoadingState implements BroadcastListState {}
