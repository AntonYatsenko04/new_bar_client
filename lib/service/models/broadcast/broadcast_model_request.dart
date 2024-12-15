import 'package:json_annotation/json_annotation.dart';

part 'broadcast_model_request.g.dart';

@JsonSerializable()
class BroadcastModelRequest {
  final String name;
  @JsonKey(name: 'datetime')
  final DateTime dateTime;
  final String description;

  const BroadcastModelRequest({
    required this.name,
    required this.dateTime,
    required this.description,
  });

  factory BroadcastModelRequest.fromJson(Map<String, dynamic> json) =>
      _$BroadcastModelRequestFromJson(json);

  Map<String, dynamic> toJson() => _$BroadcastModelRequestToJson(this);
}
