part of '../dio_config.dart';

class ResponseInterceptor extends Interceptor {
  final Dio dio;

  ResponseInterceptor(this.dio);

  @override
  Future<void> onResponse(
    Response<dynamic> response,
    ResponseInterceptorHandler handler,
  ) async {
    return handler.next(response);
  }
}
