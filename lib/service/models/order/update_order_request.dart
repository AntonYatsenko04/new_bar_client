import 'package:bar_client/service/models/order/order_item_request.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'order_item_response.dart';

part 'update_order_request.freezed.dart';
part 'update_order_request.g.dart';

@freezed
class UpdateOrderRequest with _$UpdateOrderRequest {
  const factory UpdateOrderRequest({
    required List<OrderItemResponse> updatedExistingOrders,
    required List<OrderItemRequest> newOrders,
  }) = _UpdateOrderRequest;

  factory UpdateOrderRequest.fromJson(Map<String, dynamic> json) =>
      _$UpdateOrderRequestFromJson(json);
}
