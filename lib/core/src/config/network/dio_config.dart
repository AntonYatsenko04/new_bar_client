import 'dart:async';

import 'package:bar_client/core/src/config/app_config.dart';
import 'package:bar_client/core/src/config/network/interceptors/dio_log_interceptor.dart';
import 'package:bar_client/core/src/di/app_di.dart';
import 'package:bar_client/service/providers/shared_preferences_provider.dart';
import 'package:dio/dio.dart';

part 'interceptors/request_interceptor.dart';
part 'interceptors/response_interceptor.dart';

class DioConfig {
  final AppConfig _appConfig;

  late final Dio _dio = Dio();

  Dio get dio => _dio;

  DioConfig({
    required AppConfig appConfig,
  }) : _appConfig = appConfig {
    _dio
      ..options.receiveTimeout = const Duration(seconds: 3)
      //..options.extra['withCredentials'] = true
      ..options.baseUrl = _appConfig.baseUrl
      // ..options.receiveDataWhenStatusError = true
      // ..options.responseType = ResponseType.json
      ..options.headers.addAll(
        <String, dynamic>{
          // 'Access-Control-Allow-Origin': '*',
          // 'Access-Control-Allow-Methods': 'GET,PUT,PATCH,POST,DELETE',
          // 'Access-Control-Allow-Headers': 'Origin, X-Requested-With, Content-Type, Accept',
          'Content-Type': 'application/json; charset=UTF-8',
          Headers.acceptHeader: Headers.jsonContentType,
        },
      )
      ..interceptors.addAll(
        <Interceptor>[
          RequestInterceptor(
            dio: dio,
          ),
          ResponseInterceptor(dio),
          dioLoggerInterceptor,
        ],
      );
  }
}
