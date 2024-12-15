import 'package:freezed_annotation/freezed_annotation.dart';

part 'order_menu_item_request.freezed.dart';
part 'order_menu_item_request.g.dart';

@freezed
class OrderMenuItemRequest with _$OrderMenuItemRequest {
  const factory OrderMenuItemRequest({
    required int menuItemId,
    required int orderItemId,
    required int count,
  }) = _OrderMenuItemRequest;

  factory OrderMenuItemRequest.fromJson(Map<String, dynamic> json) =>
      _$OrderMenuItemRequestFromJson(json);
}
