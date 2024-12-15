import 'package:bar_client/service/models/has_price.dart';
import 'package:bar_client/service/models/menu/menu_item_response.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'order_menu_item_response.freezed.dart';
part 'order_menu_item_response.g.dart';

@freezed
class OrderMenuItemResponse with _$OrderMenuItemResponse implements HasPrice {
  const factory OrderMenuItemResponse({
    required int id,
    required int count,
    required MenuItemResponse menuItem,
  }) = _OrderMenuItemResponse;

  factory OrderMenuItemResponse.fromJson(Map<String, dynamic> json) =>
      _$OrderMenuItemResponseFromJson(json);

  const OrderMenuItemResponse._();

  @override
  int get price => menuItem.price * count;
}
