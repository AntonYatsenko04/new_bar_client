import 'package:bar_client/core/src/logger/logger.dart';
import 'package:bar_client/service/models/auth/token_model.dart';
import 'package:bar_client/service/providers/csrf_token_api_provider.dart';
import 'package:bar_client/service/providers/csrf_token_local_provider.dart';
import 'package:bar_client/service/providers/encryption_provider.dart';
import 'package:bar_client/service/providers/library_provider.dart';
import 'package:bar_client/service/safe_request/safe_request.dart';

import '../models/auth/sign_in_model.dart';

class CsrfTokenService {
  final CsrfTokenApiProvider _csrfTokenApiProvider;
  final CsrfTokenLocalProvider _csrfTokenLocalProvider;
  final EncryptionProvider _encryptionProvider;
  final LibraryProvider _libraryProvider;

  CsrfTokenService({
    required CsrfTokenApiProvider csrfTokenApiProvider,
    required CsrfTokenLocalProvider csrfTokenLocalProvider,
    required EncryptionProvider encryptionProvider,
    required LibraryProvider libraryProvider,
  })  : _csrfTokenApiProvider = csrfTokenApiProvider,
        _csrfTokenLocalProvider = csrfTokenLocalProvider,
        _encryptionProvider = encryptionProvider,
        _libraryProvider = libraryProvider;

  Future<void> retrieveToken() async {
    try {
      final TokenModel token = await safeRequest(_csrfTokenApiProvider.getToken);
      final String encryptedToken = _encryptionProvider.encryptText(token.token);
      await _csrfTokenLocalProvider.saveToken(encryptedToken);
    } catch (e, st) {
      AppLogger().error(error: e, stackTrace: st);
    }
  }

  Future<String> getToken() async {
    final String? encryptedToken = _csrfTokenLocalProvider.getToken();
    if (encryptedToken == null) return '';
    try {
      final String token = _encryptionProvider.decryptText(encryptedToken);
      return token;
    } catch (e, st) {
      AppLogger().error(error: e, stackTrace: st);
      return '';
    }
  }

  Future<void> sendUserData({
    required SignInModel data,
  }) async {
    try {
      await _csrfTokenApiProvider.sendUserData(data);
      AppLogger().info('sent data to server');
    } catch (e, st) {
      AppLogger().info('error sending data to server');

      AppLogger().error(error: e, stackTrace: st);
    }
  }
}
