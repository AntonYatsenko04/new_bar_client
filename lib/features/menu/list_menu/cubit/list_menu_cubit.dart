import 'dart:async';

import 'package:bar_client/core/src/logger/logger.dart';
import 'package:bar_client/service/exceptions/app_exception.dart';
import 'package:bar_client/service/models/menu/menu_item_response.dart';
import 'package:bar_client/service/services/menu_service.dart';
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'list_menu_cubit.freezed.dart';
part 'list_menu_state.dart';

class ListMenuCubit extends Cubit<ListMenuState> {
  final MenuService _menuService;

  ListMenuCubit({required MenuService menuService})
      : _menuService = menuService,
        super(const LoadingState()) {
    getMenuItems();
  }

  Future<void> getMenuItems() async {
    try {
      emit(const LoadingState());
      final List<MenuItemResponse> menuItems = await _menuService.getAllMenuItems();
      emit(DataState(menuItems: menuItems));
    } on AppException catch (e, st) {
      AppLogger().error(error: e, stackTrace: st);
      emit(ErrorState(errorMessage: e.errorMessageKey));
    }
  }

  Future<void> deleteMenuItem(int id) async {
    try {
      emit(const LoadingState());
      await _menuService.deleteMenuItem(id: id);
      unawaited(getMenuItems());
    } on AppException catch (e, st) {
      AppLogger().error(error: e, stackTrace: st);
      emit(ErrorState(errorMessage: e.errorMessageKey));
    }
  }

  Future<void> searchMenuItem(String request) async {
    try {
      emit(const LoadingState());
      final List<MenuItemResponse> menuItems = await _menuService.searchMenuItems(request);
      emit(DataState(menuItems: menuItems));
    } on AppException catch (e, st) {
      AppLogger().error(error: e, stackTrace: st);
      emit(ErrorState(errorMessage: e.errorMessageKey));
    }
  }
}
