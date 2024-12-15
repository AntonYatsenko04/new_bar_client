import 'package:bar_client/core/src/enums/order_status.dart';
import 'package:bar_client/service/models/has_price.dart';
import 'package:bar_client/service/models/order/order_menu_item_response.dart';
import 'package:bar_client/service/models/user/no_role_user_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'order_item_response.freezed.dart';
part 'order_item_response.g.dart';

@freezed
class OrderItemResponse with _$OrderItemResponse implements HasPrice {
  const factory OrderItemResponse({
    required int id,
    required List<OrderMenuItemResponse> orderMenuItems,
    required OrderStatus status,
    required DateTime createdAt,
    NoRoleUserModel? cook,
  }) = _OrderItemResponse;

  factory OrderItemResponse.fromJson(Map<String, dynamic> json) =>
      _$OrderItemResponseFromJson(json);

  const OrderItemResponse._();

  @override
  int get price {
    final Iterable<int> prices = orderMenuItems.map((OrderMenuItemResponse e) => e.price);
    if (prices.isNotEmpty) {
      return prices.reduce((int e1, int e2) => e1 + e2);
    }
    return 0;
  }
}
