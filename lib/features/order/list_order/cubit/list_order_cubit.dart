import 'dart:async';

import 'package:bar_client/core/src/logger/logger.dart';
import 'package:bar_client/navigation/app_router/app_router.dart';
import 'package:bar_client/service/models/order/order_response.dart';
import 'package:bar_client/service/services/order_service.dart';
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../navigation/app_router/app_router.gr.dart';
import '../../../../service/exceptions/app_exception.dart';

part 'list_order_cubit.freezed.dart';
part 'list_order_state.dart';

class ListOrderCubit extends Cubit<ListOrderState> {
  final OrderService _orderService;
  final AppRouter _appRouter;

  ListOrderCubit({
    required OrderService orderService,
    required AppRouter appRouter,
  })  : _orderService = orderService,
        _appRouter = appRouter,
        super(const LoadingState()) {
    getOrders();
  }

  Future<void> getOrders() async {
    try {
      emit(const LoadingState());
      final List<OrderResponse> orders = await _orderService.getOrders();
      emit(DataState(orders: orders));
    } on AppException catch (e, st) {
      AppLogger().error(error: e, stackTrace: st);
      emit(ErrorState(errorMessage: e.errorMessageKey));
    }
  }

  Future<void> deleteOrders(int id) async {
    try {
      emit(const LoadingState());
      await _orderService.deleteOrder(id);
      await getOrders();
    } on AppException catch (e, st) {
      AppLogger().error(error: e, stackTrace: st);
      emit(ErrorState(errorMessage: e.errorMessageKey));
    }
  }

  Future<void> goToCreateOrder() async {
    await _appRouter.push(const AddOrderItemRoute());
    unawaited(getOrders());
  }
}
