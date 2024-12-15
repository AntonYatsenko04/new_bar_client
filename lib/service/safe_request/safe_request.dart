import 'dart:async';
import 'dart:developer';

import 'package:bar_client/service/exceptions/app_exception.dart';
import 'package:dio/dio.dart';

Future<T> safeRequest<T>(Future<T> Function() request) async {
  try {
    return await request();
  } on DioException catch (error) {
    log(error.toString());
    final Response<dynamic>? response = error.response;
    log(response.toString());

    if (response == null) {
      throw AppException(
        type: AppExceptionType.noInternet,
      );
    } else {
      final int? statusCode = response.statusCode;
      if (statusCode != null) {
        final AppExceptionType? type = AppExceptionType.fromCode(statusCode);
        if (type != null) {
          throw AppException(type: type);
        }
      }
      throw AppException(type: AppExceptionType.unknown);
    }
  } catch (error, stackTrace) {
    log(error.toString(), stackTrace: stackTrace);
    throw Exception(error.toString());
  }
}
