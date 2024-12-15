import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../core/src/enums/order_status.dart';
import '../user/no_role_user_model.dart';

part 'patch_order_item_request.freezed.dart';
part 'patch_order_item_request.g.dart';

@freezed
class PatchOrderItemRequest with _$PatchOrderItemRequest {
  const factory PatchOrderItemRequest({
    required int orderItemId,
    required OrderStatus status,
    int? cookId,
  }) = _PatchOrderItemRequest;

  factory PatchOrderItemRequest.fromJson(Map<String, dynamic> json) =>
      _$PatchOrderItemRequestFromJson(json);
}
