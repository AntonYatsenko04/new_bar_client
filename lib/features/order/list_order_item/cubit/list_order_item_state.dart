part of 'list_order_item_cubit.dart';

sealed class ListOrderItemState {}

final class LoadingState implements ListOrderItemState {}

@freezed
class ErrorState with _$ErrorState implements ListOrderItemState {
  const factory ErrorState({
    required String errorMessage,
  }) = _ErrorState;
}

@freezed
class DataState with _$DataState implements ListOrderItemState {
  const factory DataState({
    required List<OrderItemResponse> orderItems,
    required List<NoRoleUserModel> cooks,
    required List<NoRoleUserModel?> cooksForOrderItems,
  }) = _DataState;
}
