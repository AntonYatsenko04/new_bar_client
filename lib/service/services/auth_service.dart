import 'package:bar_client/core/src/enums/user_type.dart';
import 'package:bar_client/service/models/auth/sign_in_model.dart';
import 'package:bar_client/service/models/auth/sign_up_model.dart';
import 'package:bar_client/service/models/auth/token_model.dart';
import 'package:bar_client/service/providers/auth_provider.dart';
import 'package:bar_client/service/providers/shared_preferences_provider.dart';
import 'package:bar_client/service/safe_request/safe_request.dart';

class AuthService {
  final AuthProvider _authProvider;
  final SharedPreferencesProvider _sharedPreferencesProvider;

  int? _currentUserId;
  UserType? _currentUserType;

  int? get currentUserId => _currentUserId;
  UserType? get currentUserType => _currentUserType;

  AuthService({
    required AuthProvider authProvider,
    required SharedPreferencesProvider sharedPreferencesProvider,
  })  : _authProvider = authProvider,
        _sharedPreferencesProvider = sharedPreferencesProvider;

  Future<void> signIn({required SignInModel signInModel}) async {
    final TokenModel token =
        await safeRequest<TokenModel>(() => _authProvider.signIn(signInModel));
    await _sharedPreferencesProvider.saveToken(token.token);
    // final UserModel userModel = await safeRequest(getCurrentUserInfo);
    // _currentUserId = userModel.id;
    // _currentUserType = userModel.userType;
  }

  Future<void> signUp({required SignUpModel signUpModel}) async {
    await safeRequest(() => _authProvider.signUpWithRole(signUpModel));
  }

  Future<void> signOut() {
    return _sharedPreferencesProvider.clearToken();
  }
}
