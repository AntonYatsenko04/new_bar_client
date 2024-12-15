import 'package:bar_client/core/src/localization/generated/locale_keys.g.dart';

class AppException implements Exception {
  final AppExceptionType type;

  String get errorMessageKey => type.errorMessageKey;

  AppException({required this.type});
}

const int _clientError = 400;
const int _unAuthError = 401;

const int _notFoundError = 404;
const int _resourceExists = 409;
const int _invalidInput = 422;
const int _serverError = 500;

enum AppExceptionType {
  unknown(errorMessageKey: LocaleKeys.commonErrors_unknown),
  noInternet(errorMessageKey: LocaleKeys.commonErrors_noInternet),
  serverError(
    errorMessageKey: LocaleKeys.commonErrors_serverUnavailable,
    errorCode: _serverError,
  ),
  clientError(
    errorMessageKey: LocaleKeys.commonErrors_clientError,
    errorCode: _clientError,
  ),
  unAuthorized(
    errorMessageKey: LocaleKeys.commonErrors_unAuthorized,
    errorCode: _unAuthError,
  ),
  notFound(
    errorMessageKey: LocaleKeys.commonErrors_notFound,
    errorCode: _notFoundError,
  ),
  resourceAlreadyExists(
    errorMessageKey: LocaleKeys.commonErrors_resourceAlreadyExists,
    errorCode: _resourceExists,
  ),
  invalidInput(
    errorMessageKey: LocaleKeys.commonErrors_invalidInput,
    errorCode: _invalidInput,
  );

  final String errorMessageKey;
  final int? errorCode;

  const AppExceptionType({
    required this.errorMessageKey,
    this.errorCode,
  });

  static AppExceptionType? fromCode(int code) {
    for (final AppExceptionType value in AppExceptionType.values) {
      if (value.errorCode == code) {
        return value;
      }
    }
    return null;
  }
}
