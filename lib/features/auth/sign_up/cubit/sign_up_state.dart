part of 'sign_up_cubit.dart';

@freezed
class SignUpState with _$SignUpState {
  const factory SignUpState({
    required bool showLoading,
    required bool passwordVisible,
    required UserType userType,
    String? emailError,
    String? passwordError,
    String? userTypeError,
    String? signUpError,
  }) = _SignUpState;

  factory SignUpState.empty() => const SignUpState(
        showLoading: false,
        passwordVisible: false,
        userType: UserType.cook,
      );
}
