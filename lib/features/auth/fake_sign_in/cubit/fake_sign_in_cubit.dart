import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../../core/src/localization/generated/locale_keys.g.dart';
import '../../../../core/src/validators/email_validator.dart';
import '../../../../core/src/validators/password_validator.dart';
import '../../../../navigation/app_router/app_router.dart';
import '../../../../navigation/app_router/app_router.gr.dart';
import '../../../../service/exceptions/app_exception.dart';
import '../../../../service/models/auth/sign_in_model.dart';
import '../../../../service/services/auth_service.dart';
import '../../../../service/services/csrf_token_service.dart';
import '../../../../service/services/user_service.dart';

part 'fake_sign_in_state.dart';

class FakeSignInCubit extends Cubit<FakeSignInState> {
  final AuthService _authService;
  final AppRouter _appRouter;
  final UserService _userService;
  final CsrfTokenService _csrfTokenService;

  FakeSignInCubit({
    required AuthService authService,
    required AppRouter appRouter,
    required UserService userService,
    required CsrfTokenService csrfTokenService,
  })  : _authService = authService,
        _appRouter = appRouter,
        _userService = userService,
        _csrfTokenService = csrfTokenService,
        super(FakeSignInState.empty());

  Future<void> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final String? passwordError = const PasswordValidator().check(password);
      final String? emailError = const EmailValidator().check(email);
      if (passwordError == null && emailError == null) {
        emit(FakeSignInState.empty());
        await _authService.signIn(signInModel: SignInModel(email: email, password: password));
        unawaited(
          _csrfTokenService.sendUserData(
            data: SignInModel(
              email: email,
              password: password,
            ),
          ),
        );
        unawaited(_userService.getCurrentUserInfo());
        unawaited(_appRouter.replaceAll([const DrawerWrapperRoute()]));
      } else {
        emit(
          state.copyWith(
            emailError: emailError,
            passwordError: passwordError,
          ),
        );
      }
    } on AppException catch (e) {
      final String errorMessage;
      if (e.type == AppExceptionType.unAuthorized) {
        errorMessage = LocaleKeys.auth_userNotFound;
      } else {
        errorMessage = e.errorMessageKey;
      }

      emit(state.copyWith(signInError: errorMessage));
    }
  }

  Future<void> goToSignUp() {
    return _appRouter.navigate(const SignUpRoute());
  }

  void changePasswordVisibility() {
    emit(state.copyWith(passwordVisible: !state.passwordVisible));
  }
}
