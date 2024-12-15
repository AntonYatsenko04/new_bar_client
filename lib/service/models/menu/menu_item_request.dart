import 'package:freezed_annotation/freezed_annotation.dart';

part 'menu_item_request.freezed.dart';
part 'menu_item_request.g.dart';

@freezed
class MenuItemRequest with _$MenuItemRequest {
  factory MenuItemRequest({
    required String name,
    required String description,
    required int price,
  }) = _MenuItemRequest;

  factory MenuItemRequest.fromJson(Map<String, dynamic> json) => _$MenuItemRequestFromJson(json);
}
