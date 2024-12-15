import 'package:json_annotation/json_annotation.dart';

part 'broadcast_model_response.g.dart';

@JsonSerializable()
class BroadcastModelResponse {
  final int id;
  final String name;
  @JsonKey(name: 'datetime')
  final DateTime dateTime;
  final String description;

  const BroadcastModelResponse({
    required this.id,
    required this.name,
    required this.dateTime,
    required this.description,
  });

  factory BroadcastModelResponse.fromJson(Map<String, dynamic> json) =>
      _$BroadcastModelResponseFromJson(json);

  Map<String, dynamic> toJson() => _$BroadcastModelResponseToJson(this);

  @override
  String toString() {
    return 'BroadcastModelResponse{id: $id, name: $name, dateTime: $dateTime, description: $description}';
  }
}
