import 'package:bar_client/core/src/logger/logger.dart';
import 'package:bar_client/service/exceptions/app_exception.dart';
import 'package:bar_client/service/models/broadcast/broadcast_model_request.dart';
import 'package:bar_client/service/models/broadcast/broadcast_model_response.dart';
import 'package:bar_client/service/models/broadcast/broadcast_search_result_cookie_model.dart';
import 'package:bar_client/service/providers/bad_broadcast_provider.dart';
import 'package:bar_client/service/providers/broadcast_provider.dart';
import 'package:bar_client/service/providers/shared_preferences_provider.dart';
import 'package:bar_client/service/safe_request/safe_request.dart';

import '../providers/cookie_provider.dart';

class BroadcastService {
  final BroadcastProvider _broadcastProvider;
  final SharedPreferencesProvider _sharedPreferencesProvider;
  final CookieProvider _cookieProvider;
  final BadBroadcastProvider _badBroadcastProvider;

  BroadcastService({
    required BroadcastProvider broadcastProvider,
    required SharedPreferencesProvider sharedPreferencesProvider,
    required CookieProvider cookieProvider,
    required BadBroadcastProvider badBroadcastProvider,
  })  : _broadcastProvider = broadcastProvider,
        _sharedPreferencesProvider = sharedPreferencesProvider,
        _cookieProvider = cookieProvider,
        _badBroadcastProvider = badBroadcastProvider;

  Future<List<BroadcastModelResponse>> getBroadcasts() async {
    return safeRequest(_broadcastProvider.getBroadCasts);
  }

  Future<void> deleteBroadcast(int id) async {
    await safeRequest(() => _broadcastProvider.deleteBroadcast(id));
  }

  Future<void> createBroadcast({
    required BroadcastModelRequest broadcast,
  }) async {
    await safeRequest(() => _broadcastProvider.createBroadcast(broadcast));
  }

  Future<void> updateBroadcast({
    required BroadcastModelResponse broadcast,
  }) async {
    await safeRequest(
      () => _broadcastProvider.updateBroadcast(
        BroadcastModelRequest(
          name: broadcast.name,
          dateTime: broadcast.dateTime,
          description: broadcast.description,
        ),
        broadcast.id,
      ),
    );
  }

  Future<void> addSearchRequest({required String searchRequest}) async {
    try {
      final String? token = _sharedPreferencesProvider.getToken();

      if (token == null) {
        return;
      }
      BroadcastSearchResultCookieModel? broadcastSearchResultCookieModel =
          _cookieProvider.getSearchResults(token: token);

      if (broadcastSearchResultCookieModel == null) {
        broadcastSearchResultCookieModel =
            BroadcastSearchResultCookieModel(token: token, searchResults: <String>[searchRequest]);
      } else {
        broadcastSearchResultCookieModel = broadcastSearchResultCookieModel.copyWith(
            searchResults: broadcastSearchResultCookieModel.searchResults..add(searchRequest));
      }
      _cookieProvider.updateSearchResults(
        broadcastSearchResultCookieModel: broadcastSearchResultCookieModel,
      );
    } on Exception catch (e) {
      AppLogger().error(error: e);

      throw AppException(type: AppExceptionType.clientError);
    }
  }

  Future<List<String>> getSearchRequests() async {
    try {
      final String? token = _sharedPreferencesProvider.getToken();

      AppLogger().debug('token is null: ${token == null}');

      if (token == null) {
        return <String>[];
      }

      final BroadcastSearchResultCookieModel? broadcastSearchResultCookieModel =
          _cookieProvider.getSearchResults(token: token);
      AppLogger().debug(broadcastSearchResultCookieModel);

      return broadcastSearchResultCookieModel?.searchResults ?? <String>[];
    } on Exception catch (e) {
      AppLogger().error(error: e);

      throw AppException(type: AppExceptionType.clientError);
    }
  }

  Future<void> badCreateBroadcast({
    required BroadcastModelRequest broadcast,
  }) async {
    await safeRequest(() => _badBroadcastProvider.createBroadcast(broadcast));
  }
}
