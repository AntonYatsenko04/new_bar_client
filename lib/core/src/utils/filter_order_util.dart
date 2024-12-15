import 'package:bar_client/service/exceptions/app_exception.dart';
import 'package:bar_client/service/models/order/order_item_response.dart';
import 'package:bar_client/service/models/order/order_response.dart';

import '../../../service/models/auth/user_model.dart';
import '../enums/user_type.dart';

sealed class FilterOrderUtil {
  static List<OrderResponse> filterOrders({
    required List<OrderResponse> orders,
    required UserModel userModel,
  }) {
    if (orders.isEmpty) return orders;

    switch (userModel.userType) {
      case UserType.manager:
        return orders;
      case UserType.waiter:
        return orders.where((OrderResponse e) => e.waiter.id == userModel.id).toList();
      case UserType.cook:
        throw AppException(type: AppExceptionType.unAuthorized);
    }
  }

  static List<OrderItemResponse> filterOrderItems({
    required List<OrderItemResponse> orderItems,
    required UserModel userModel,
  }) {
    if (orderItems.isEmpty) return orderItems;

    switch (userModel.userType) {
      case UserType.manager || UserType.waiter:
        return orderItems;
      case UserType.cook:
        final Iterable<OrderItemResponse> cookItems =
            orderItems.where((OrderItemResponse e) => e.cook == null || e.cook?.id == userModel.id);

        if (cookItems.isNotEmpty) {
          return cookItems.toList();
        }

        return const <OrderItemResponse>[];
    }
  }
}
