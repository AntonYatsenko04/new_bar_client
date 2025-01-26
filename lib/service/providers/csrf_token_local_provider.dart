import 'package:session_storage/session_storage.dart';

class CsrfTokenLocalProvider {
  final String _tokenKey = 'csrfToken';
  SessionStorage get _sessionStorage => SessionStorage();

  String? getToken() {
    return _sessionStorage[_tokenKey];
  }

  Future<void> saveToken(String token) async {
    _sessionStorage[_tokenKey] = token;
  }
}
