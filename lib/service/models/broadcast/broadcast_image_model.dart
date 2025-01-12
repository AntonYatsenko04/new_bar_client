import 'package:freezed_annotation/freezed_annotation.dart';

part 'broadcast_image_model.freezed.dart';
part 'broadcast_image_model.g.dart';

@freezed
class BroadcastImageModel with _$BroadcastImageModel {
  const factory BroadcastImageModel({
    required String image,
    required int broadcastId,
  }) = _BroadcastImageModel;

  factory BroadcastImageModel.fromJson(Map<String, dynamic> json) =>
      _$BroadcastImageModelFromJson(json);
}
