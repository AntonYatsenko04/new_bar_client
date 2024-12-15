import 'package:freezed_annotation/freezed_annotation.dart';

part 'search_menu_request.freezed.dart';
part 'search_menu_request.g.dart';

@freezed
class SearchMenuRequest with _$SearchMenuRequest {
  const factory SearchMenuRequest({
    required String token,
    required String searchRequest,
  }) = _SearchMenuRequest;

  factory SearchMenuRequest.fromJson(Map<String, dynamic> json) =>
      _$SearchMenuRequestFromJson(json);
}
