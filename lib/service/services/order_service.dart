import 'package:bar_client/core/src/utils/filter_order_util.dart';
import 'package:bar_client/service/models/auth/token_model.dart';
import 'package:bar_client/service/models/auth/user_model.dart';
import 'package:bar_client/service/models/common/array_model.dart';
import 'package:bar_client/service/models/id_model.dart';
import 'package:bar_client/service/models/order/order_item_response.dart';
import 'package:bar_client/service/models/order/order_menu_item_request.dart';
import 'package:bar_client/service/models/order/patch_order_item_request.dart';
import 'package:bar_client/service/providers/order_provider.dart';
import 'package:bar_client/service/providers/shared_preferences_provider.dart';
import 'package:bar_client/service/providers/user_provider.dart';
import 'package:bar_client/service/safe_request/safe_request.dart';

import '../../core/src/enums/order_status.dart';
import '../models/order/create_order_model.dart';
import '../models/order/order_item_request.dart';
import '../models/order/order_response.dart';

class OrderService {
  final OrderProvider _orderProvider;
  final UserProvider _userProvider;
  final SharedPreferencesProvider _sharedPreferencesProvider;

  OrderService({
    required OrderProvider orderProvider,
    required UserProvider userProvider,
    required SharedPreferencesProvider sharedPreferencesProvider,
  })  : _orderProvider = orderProvider,
        _userProvider = userProvider,
        _sharedPreferencesProvider = sharedPreferencesProvider;

  Future<List<OrderResponse>> getOrders() async {
    final List<OrderResponse> allOrders = await safeRequest(_orderProvider.getOrders);
    final UserModel userModel = await safeRequest(
      () => _userProvider.getUserInfo(
        TokenModel(
          token: _sharedPreferencesProvider.getToken() ?? '',
        ),
      ),
    );

    return FilterOrderUtil.filterOrders(
      orders: allOrders,
      userModel: userModel,
    );
  }

  Future<List<OrderItemResponse>> getOrderItems() async {
    final List<OrderItemResponse> allOrderItems = await safeRequest(_orderProvider.getOrderItems);

    final UserModel userModel = await safeRequest(
      () => _userProvider.getUserInfo(
        TokenModel(
          token: _sharedPreferencesProvider.getToken() ?? '',
        ),
      ),
    );

    return FilterOrderUtil.filterOrderItems(
      orderItems: allOrderItems,
      userModel: userModel,
    );
  }

  Future<void> createOrder(CreateOrderModel order) async {
    final IdModel orderId = await safeRequest<IdModel>(
      () => _orderProvider.createOrder(order.orderRequest),
    );

    final IdModel orderItemId = await safeRequest<IdModel>(
      () => _orderProvider.createOrderItem(
        OrderItemRequest(
          orderId: orderId.id,
          status: OrderStatus.taken,
        ),
      ),
    );

    final List<OrderMenuItemRequest> orderMenuItems = order.menuToCount.entries
        .map(
          (MapEntry<int, int> e) => OrderMenuItemRequest(
            menuItemId: e.key,
            orderItemId: orderItemId.id,
            count: e.value,
          ),
        )
        .toList();

    await safeRequest(
      () => _orderProvider.createOrderMenuItems(
        ArrayModel<OrderMenuItemRequest>(array: orderMenuItems),
      ),
    );
  }

  Future<void> deleteOrder(int id) async {
    await safeRequest(() => _orderProvider.deleteOrder(id));
  }

  Future<void> setCookTookOrder({
    required int orderItemId,
    int? cookId,
  }) async {
    const OrderStatus status = OrderStatus.inCooking;
    final UserModel userModel = await safeRequest(
      () => _userProvider.getUserInfo(
        TokenModel(
          token: _sharedPreferencesProvider.getToken() ?? '',
        ),
      ),
    );

    final int finalCookId = cookId ?? userModel.id;

    final PatchOrderItemRequest patchOrderItemRequest = PatchOrderItemRequest(
      orderItemId: orderItemId,
      status: status,
      cookId: finalCookId,
    );

    await safeRequest(
      () => _orderProvider.patchOrderItem(
        request: patchOrderItemRequest,
      ),
    );
  }

  Future<void> setOrderStatus({
    required OrderItemResponse orderItem,
    required OrderStatus status,
  }) async {
    final PatchOrderItemRequest patchOrderItemRequest = PatchOrderItemRequest(
      orderItemId: orderItem.id,
      status: status,
    );

    await safeRequest(
      () => _orderProvider.patchOrderItem(
        request: patchOrderItemRequest,
      ),
    );
  }
}
