part of '../dio_config.dart';

class RequestInterceptor extends Interceptor {
  final Dio _dio;
  late final SharedPreferencesProvider _sharedPreferencesProvider =
      appLocator<SharedPreferencesProvider>();

  RequestInterceptor({
    required Dio dio,
  }) : _dio = dio;

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final String? accessToken = _sharedPreferencesProvider.getToken();

    if (accessToken != null) {
      options.headers['Authorization'] = 'Bearer $accessToken';
    }
    return handler.next(options);
  }
}
