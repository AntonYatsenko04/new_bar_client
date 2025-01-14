import 'package:freezed_annotation/freezed_annotation.dart';

part 'broadcast_search_result_cookie_model.freezed.dart';
part 'broadcast_search_result_cookie_model.g.dart';

@Freezed(makeCollectionsUnmodifiable: false)
class BroadcastSearchResultCookieModel with _$BroadcastSearchResultCookieModel {
  const factory BroadcastSearchResultCookieModel({
    required String token,
    required List<String> searchResults,
  }) = _BroadcastSearchResultCookieModel;

  factory BroadcastSearchResultCookieModel.fromJson(Map<String, dynamic> json) =>
      _$BroadcastSearchResultCookieModelFromJson(json);
}
