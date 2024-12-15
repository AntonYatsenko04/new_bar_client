import 'dart:math';

import 'package:bar_client/service/models/has_price.dart';
import 'package:bar_client/service/models/order/order_item_response.dart';
import 'package:bar_client/service/models/table/table_model.dart';
import 'package:bar_client/service/models/user/no_role_user_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'order_response.freezed.dart';
part 'order_response.g.dart';

@freezed
class OrderResponse with _$OrderResponse implements HasPrice {
  const factory OrderResponse({
    required int id,
    @JsonKey(name: 'tableEntity') required TableModel tableModel,
    required NoRoleUserModel waiter,
    required List<OrderItemResponse> orderItems,
  }) = _OrderResponse;

  factory OrderResponse.fromJson(Map<String, dynamic> json) => _$OrderResponseFromJson(json);

  const OrderResponse._();

  @override
  int get price {
    final Iterable<int> prices = orderItems.map((OrderItemResponse e) => e.price);
    if (prices.isNotEmpty) {
      return prices.reduce((int e1, int e2) => e1 + e2);
    }
    return 0;
  }

  DateTime get createdAt => orderItems.map((OrderItemResponse e) => e.createdAt).reduce(
        (DateTime e1, DateTime e2) => DateTime.fromMicrosecondsSinceEpoch(
          min(e2.microsecondsSinceEpoch, e1.microsecondsSinceEpoch),
        ),
      );
}
