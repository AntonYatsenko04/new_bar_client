import 'package:bar_client/core/src/enums/order_status.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'order_item_request.freezed.dart';
part 'order_item_request.g.dart';

@freezed
class OrderItemRequest with _$OrderItemRequest {
  const factory OrderItemRequest({
    required int orderId,
    required OrderStatus status,
    int? cookId,
  }) = _OrderItemRequest;

  factory OrderItemRequest.fromJson(Map<String, dynamic> json) => _$OrderItemRequestFromJson(json);
}
