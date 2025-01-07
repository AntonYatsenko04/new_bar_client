import 'package:freezed_annotation/freezed_annotation.dart';

part 'weights_model.freezed.dart';
part 'weights_model.g.dart';

@freezed
class WeightsModel with _$WeightsModel {
  const factory WeightsModel({
    required int itemQuantity,
    required int orderQuantity,
    required int pricePercentage,
  }) = _WeightsModel;

  factory WeightsModel.fromJson(Map<String, dynamic> json) => _$WeightsModelFromJson(json);
}
