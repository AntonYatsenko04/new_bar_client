import 'dart:async';

import 'package:bar_client/core/src/enums/order_status.dart';
import 'package:bar_client/core/src/logger/logger.dart';
import 'package:bar_client/service/exceptions/app_exception.dart';
import 'package:bar_client/service/models/order/order_item_response.dart';
import 'package:bar_client/service/models/user/no_role_user_model.dart';
import 'package:bar_client/service/services/order_service.dart';
import 'package:bar_client/service/services/user_service.dart';
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'list_order_item_cubit.freezed.dart';
part 'list_order_item_state.dart';

class ListOrderItemCubit extends Cubit<ListOrderItemState> {
  final OrderService _orderService;
  final UserService _userService;

  ListOrderItemCubit({
    required OrderService orderService,
    required UserService userService,
  })  : _orderService = orderService,
        _userService = userService,
        super(LoadingState()) {
    getOrderItems();
  }

  Future<void> getOrderItems() async {
    try {
      emit(LoadingState());
      final List<NoRoleUserModel> cooks = await _userService.getCooks();
      final List<OrderItemResponse> orderItems = await _orderService.getOrderItems();
      emit(
        DataState(
          orderItems: orderItems,
          cooks: cooks,
          cooksForOrderItems: List.generate(orderItems.length, (_) => null),
        ),
      );
    } on AppException catch (e, st) {
      AppLogger().error(error: e, stackTrace: st);
      emit(ErrorState(errorMessage: e.errorMessageKey));
    }
  }

  Future<void> setCookTookOrderStatus(int orderItemId) async {
    try {
      emit(LoadingState());
      await _orderService.setCookTookOrder(orderItemId: orderItemId);
      unawaited(getOrderItems());
    } on AppException catch (e, st) {
      AppLogger().error(error: e, stackTrace: st);
      emit(ErrorState(errorMessage: e.errorMessageKey));
    }
  }

  Future<void> setCookFinishedOrderStatus(OrderItemResponse order) async {
    try {
      emit(LoadingState());
      await _orderService.setOrderStatus(
        orderItem: order,
        status: OrderStatus.pendingPayment,
      );
      unawaited(getOrderItems());
    } on AppException catch (e, st) {
      AppLogger().error(error: e, stackTrace: st);
      emit(ErrorState(errorMessage: e.errorMessageKey));
    }
  }

  Future<void> advanceManagerStatus({
    required OrderItemResponse orderItem,
    NoRoleUserModel? cook,
  }) async {
    try {
      emit(LoadingState());

      if (orderItem.status.nextIfExists case final OrderStatus newStatus) {
        if (cook != null) {
          await _orderService.setCookTookOrder(orderItemId: orderItem.id, cookId: cook.id);
        }

        await _orderService.setOrderStatus(
          orderItem: orderItem,
          status: newStatus,
        );
      }

      unawaited(getOrderItems());
    } on AppException catch (e, st) {
      AppLogger().error(error: e, stackTrace: st);
      emit(ErrorState(errorMessage: e.errorMessageKey));
    }
  }

  void selectCookForOrder({
    required int orderIndex,
    NoRoleUserModel? cook,
  }) {
    if (state case final DataState dataState) {
      final List<NoRoleUserModel?> cooksForOrderItems = <NoRoleUserModel?>[
        ...dataState.cooksForOrderItems,
      ]
        ..removeAt(orderIndex)
        ..insert(orderIndex, cook);

      emit(
        dataState.copyWith(
          cooksForOrderItems: cooksForOrderItems,
        ),
      );
    }
  }
}
