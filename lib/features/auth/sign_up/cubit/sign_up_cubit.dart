import 'package:bar_client/core/src/enums/user_type.dart';
import 'package:bar_client/navigation/app_router/app_router.dart';
import 'package:bar_client/service/services/auth_service.dart';
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/src/localization/generated/locale_keys.g.dart';
import '../../../../core/src/logger/logger.dart';
import '../../../../core/src/validators/email_validator.dart';
import '../../../../core/src/validators/password_validator.dart';
import '../../../../service/exceptions/app_exception.dart';
import '../../../../service/models/auth/sign_up_model.dart';

part 'sign_up_cubit.freezed.dart';
part 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  final AuthService _authService;
  final AppRouter _appRouter;

  SignUpCubit({
    required AuthService authService,
    required AppRouter appRouter,
  })  : _authService = authService,
        _appRouter = appRouter,
        super(
          SignUpState.empty(),
        );

  Future<void> signUp({
    required String email,
    required String password,
  }) async {
    try {
      final String? passwordError = const PasswordValidator().check(password);
      final String? emailError = const EmailValidator().check(email);
      if (passwordError == null && emailError == null) {
        AppLogger().debug(state.userType);

        await _authService.signUp(
          signUpModel: SignUpModel(
            email: email,
            password: password,
            userType: state.userType,
          ),
        );
        emit(
          state.copyWith(
            signUpError: LocaleKeys.auth_userSuccessfullyCreated,
          ),
        );
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
      if (e.type == AppExceptionType.resourceAlreadyExists) {
        errorMessage = LocaleKeys.auth_userWithThisEmailAlreadyExists;
      } else {
        errorMessage = e.errorMessageKey;
      }

      emit(state.copyWith(signUpError: errorMessage));
    }
  }

  void goToSignIn() {
    _appRouter.maybePop();
  }

  void changePasswordVisibility() {
    emit(state.copyWith(passwordVisible: !state.passwordVisible));
  }

  void changeUserType(UserType userType) {
    AppLogger().debug(userType);
    emit(state.copyWith(userType: userType));
  }
}
