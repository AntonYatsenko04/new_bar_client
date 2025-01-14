import 'package:bar_client/service/providers/shared_preferences_provider.dart';
import 'package:session_storage/session_storage.dart';

class SessionTokenProvider implements SharedPreferencesProvider {
  SessionStorage get _sessionStorage => SessionStorage();

  final String _tokenKey = 'token';
  @override
  Future<void> clearPrefs() async {
    _sessionStorage.clear();
  }

  @override
  Future<void> clearToken() async {
    _sessionStorage.remove(_tokenKey);
  }

  @override
  String? getToken() {
    return _sessionStorage[_tokenKey];
  }

  @override
  Future<void> saveToken(String token) async {
    _sessionStorage[_tokenKey] = token;
  }
}
