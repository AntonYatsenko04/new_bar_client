import 'package:bar_client/service/models/auth/user_model.dart';

class LocalUserInfoProvider {
  UserModel? _userInfo;
  String? _token;

  UserModel? getSavedUserInfo(String token) {
    if (_token == token) {
      return _userInfo;
    }

    return null;
  }

  void setSavedUserInfo({
    required String token,
    required UserModel userModel,
  }) {
    _token = token;
    _userInfo = userModel;
  }
}
