import 'package:bar_client/service/models/auth/user_model.dart';
import 'package:bar_client/service/models/user/no_role_user_model.dart';
import 'package:bar_client/service/providers/local_user_info_provider.dart';
import 'package:bar_client/service/providers/shared_preferences_provider.dart';
import 'package:bar_client/service/providers/user_provider.dart';

import '../models/auth/token_model.dart';
import '../safe_request/safe_request.dart';

class UserService {
  final UserProvider _userProvider;
  final SharedPreferencesProvider _sharedPreferencesProvider;
  final LocalUserInfoProvider _localUserInfoProvider;

  UserService({
    required UserProvider userProvider,
    required SharedPreferencesProvider sharedPreferencesProvider,
    required LocalUserInfoProvider localUserInfoProvider,
  })  : _userProvider = userProvider,
        _sharedPreferencesProvider = sharedPreferencesProvider,
        _localUserInfoProvider = localUserInfoProvider;

  Future<UserModel> getCurrentUserInfo() async {
    final String token = _sharedPreferencesProvider.getToken() ?? '';

    final UserModel? localUserInfo = _localUserInfoProvider.getSavedUserInfo(token);

    if (localUserInfo != null) {
      return localUserInfo;
    }

    final UserModel remoteUserInfo = await safeRequest<UserModel>(
      () => _userProvider.getUserInfo(
        TokenModel(token: token),
      ),
    );

    _localUserInfoProvider.setSavedUserInfo(
      token: token,
      userModel: remoteUserInfo,
    );

    return remoteUserInfo;
  }

  Future<List<NoRoleUserModel>> getWaiters() async {
    return safeRequest(_userProvider.getWaiters);
  }

  Future<List<NoRoleUserModel>> getCooks() async {
    return safeRequest(_userProvider.getCooks);
  }
}
