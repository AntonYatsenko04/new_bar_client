part of 'add_order_item_cubit.dart';

sealed class AddOrderItemState {}

@freezed
class LoadingState with _$LoadingState implements AddOrderItemState {
  const factory LoadingState() = _LoadingState;
}

@freezed
class ErrorState with _$ErrorState implements AddOrderItemState {
  const factory ErrorState({
    required String errorMessage,
  }) = _ErrorState;
}

@freezed
class DataState with _$DataState implements AddOrderItemState {
  const factory DataState({
    required Map<MenuItemResponse, int> menuToCountMap,
    required List<int> tableIds,
    required List<int> waiterIds,
    int? tableNumber,
    int? selectedWaiterId,
    String? errorMessage,
  }) = _DataState;
}
