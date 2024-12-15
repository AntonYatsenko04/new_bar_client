part of 'list_menu_cubit.dart';

sealed class ListMenuState {}

@freezed
class LoadingState with _$LoadingState implements ListMenuState {
  const factory LoadingState() = _LoadingState;
}

@freezed
class ErrorState with _$ErrorState implements ListMenuState {
  const factory ErrorState({
    required String errorMessage,
  }) = _ErrorState;
}

@freezed
class DataState with _$DataState implements ListMenuState {
  const factory DataState({
    required List<MenuItemResponse> menuItems,
  }) = _DataState;
}
