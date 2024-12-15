import 'package:freezed_annotation/freezed_annotation.dart';

part 'menu_item_response.freezed.dart';
part 'menu_item_response.g.dart';

@freezed
class MenuItemResponse with _$MenuItemResponse {
  const factory MenuItemResponse({
    required int id,
    required String name,
    required String description,
    required int price,
  }) = _MenuItemResponse;

  factory MenuItemResponse.fromJson(Map<String, dynamic> json) =>
      _$MenuItemResponseFromJson(json);
}
