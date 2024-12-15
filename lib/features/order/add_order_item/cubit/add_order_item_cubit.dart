import 'dart:async';
import 'dart:math';

import 'package:bar_client/core/src/enums/user_type.dart';
import 'package:bar_client/core/src/localization/generated/locale_keys.g.dart';
import 'package:bar_client/navigation/app_router/app_router.dart';
import 'package:bar_client/service/models/auth/user_model.dart';
import 'package:bar_client/service/models/order/create_order_model.dart';
import 'package:bar_client/service/models/order/order_request.dart';
import 'package:bar_client/service/models/table/table_model.dart';
import 'package:bar_client/service/models/user/no_role_user_model.dart';
import 'package:bar_client/service/services/menu_service.dart';
import 'package:bar_client/service/services/table_service.dart';
import 'package:bar_client/service/services/user_service.dart';
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/src/logger/logger.dart';
import '../../../../service/exceptions/app_exception.dart';
import '../../../../service/models/menu/menu_item_response.dart';
import '../../../../service/services/order_service.dart';

part 'add_order_item_cubit.freezed.dart';
part 'add_order_item_state.dart';

class AddOrderItemCubit extends Cubit<AddOrderItemState> {
  final MenuService _menuService;
  final OrderService _orderService;
  final TableService _tableService;
  final UserService _userService;
  final AppRouter _appRouter;

  AddOrderItemCubit({
    required MenuService menuService,
    required OrderService orderService,
    required TableService tableService,
    required UserService userService,
    required AppRouter appRouter,
  })  : _menuService = menuService,
        _orderService = orderService,
        _tableService = tableService,
        _userService = userService,
        _appRouter = appRouter,
        super(const LoadingState()) {
    getMenuItems();
  }

  Future<void> getMenuItems() async {
    try {
      emit(const LoadingState());
      final List<MenuItemResponse> menuItems =
          await _menuService.getAllMenuItems();
      final List<TableModel> tableModels = await _tableService.getTables();
      final Map<MenuItemResponse, int> map = <MenuItemResponse, int>{
        for (final MenuItemResponse item in menuItems) item: 0,
      };

      final List<int> tableIds =
          tableModels.map((TableModel e) => e.id).toList();

      final List<int> waiterIds = (await _userService.getWaiters())
          .map((NoRoleUserModel e) => e.id)
          .toList();

      emit(
        DataState(
          menuToCountMap: map,
          tableIds: tableIds,
          tableNumber: tableIds.firstOrNull,
          waiterIds: waiterIds,
        ),
      );
    } on AppException catch (e, st) {
      AppLogger().error(error: e, stackTrace: st);
      emit(ErrorState(errorMessage: e.errorMessageKey));
    }
  }

  Future<void> addSubOrder() async {
    final AddOrderItemState currentState = state;
    if (currentState is DataState) {
      emit(currentState.copyWith(errorMessage: null));
      try {
        final Map<int, int> resultingOrders = Map.fromEntries(
          currentState.menuToCountMap.entries
              .map(
                (MapEntry<MenuItemResponse, int> e) => MapEntry<int, int>(
                  e.key.id,
                  e.value,
                ),
              )
              .where(
                (MapEntry<int, int> e) => e.value > 0,
              ),
        );

        if (resultingOrders.isEmpty) {
          emit(
            currentState.copyWith(
              errorMessage: LocaleKeys.order_itemsMustBeAddedToOrder,
            ),
          );
          return;
        }

        final int? waiterId = await _getWaiterId();

        if (waiterId == null) {
          emit(
            currentState.copyWith(
              errorMessage: LocaleKeys.order_waiterIdCantBeEmpty,
            ),
          );
          return;
        }

        await _orderService.createOrder(
          CreateOrderModel(
            orderRequest: OrderRequest(
              tableId: currentState.tableNumber!,
              waiterId: waiterId,
            ),
            menuToCount: resultingOrders,
          ),
        );

        unawaited(_appRouter.maybePop());
      } on AppException catch (e, st) {
        AppLogger().error(error: e, stackTrace: st);
        emit(ErrorState(errorMessage: e.errorMessageKey));
      }
    }
  }

  void setTableNumber(int? tableNumber) {
    final AddOrderItemState currentState = state;

    if (currentState is DataState) {
      emit(
        currentState.copyWith(
          tableNumber: tableNumber,
        ),
      );
    }
  }

  void setWaiterId(int? waiterId) {
    final AddOrderItemState currentState = state;

    if (currentState is DataState) {
      emit(
        currentState.copyWith(
          selectedWaiterId: waiterId,
        ),
      );
    }
  }

  void changeItemCount(
    MenuItemResponse item,
    bool add,
  ) {
    final AddOrderItemState currentState = state;

    if (currentState is DataState) {
      final List<MapEntry<MenuItemResponse, int>> oldEntries =
          currentState.menuToCountMap.entries.toList();

      final Map<MenuItemResponse, int> newEntries = <MenuItemResponse, int>{};

      for (int i = 0; i < oldEntries.length; i++) {
        final MapEntry<MenuItemResponse, int> oldEntry = oldEntries[i];
        final MapEntry<MenuItemResponse, int> newEntry;
        if (oldEntry.key == item) {
          newEntry = MapEntry(item, max(oldEntry.value + (add ? 1 : -1), 0));
        } else {
          newEntry = oldEntry;
        }
        newEntries.addEntries(<MapEntry<MenuItemResponse, int>>[newEntry]);
      }

      emit(currentState.copyWith(menuToCountMap: newEntries));
    }
  }

  Future<int?> _getWaiterId() async {
    final AddOrderItemState currentState = state;
    final UserModel info = await _userService.getCurrentUserInfo();

    if (currentState is DataState) {
      if (info.userType == UserType.manager) {
        return currentState.selectedWaiterId;
      }
      if (info.userType == UserType.waiter) {
        return info.id;
      }
    }

    return null;
  }
}
