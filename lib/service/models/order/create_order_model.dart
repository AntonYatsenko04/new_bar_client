import 'package:freezed_annotation/freezed_annotation.dart';

import 'order_request.dart';

part 'create_order_model.freezed.dart';
part 'create_order_model.g.dart';

@freezed
class CreateOrderModel with _$CreateOrderModel {
  const factory CreateOrderModel({
    required OrderRequest orderRequest,
    required Map<int, int> menuToCount,
  }) = _CreateOrderModel;

  factory CreateOrderModel.fromJson(Map<String, dynamic> json) =>
      _$CreateOrderModelFromJson(json);
}
