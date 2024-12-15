part of 'sign_in_cubit.dart';

final class SignInState {
  final String? emailError;
  final String? passwordError;
  final String? signInError;
  final bool showLoading;
  final bool passwordVisible;

  const SignInState({
    required this.showLoading,
    required this.passwordVisible,
    this.emailError,
    this.passwordError,
    this.signInError,
  });

  SignInState.empty()
      : showLoading = false,
        passwordVisible = false,
        emailError = null,
        passwordError = null,
        signInError = null;

  SignInState copyWith({
    String? emailError,
    String? passwordError,
    String? signInError,
    bool? showLoading,
    bool? passwordVisible,
  }) {
    return SignInState(
      emailError: emailError ?? this.emailError,
      passwordError: passwordError ?? this.passwordError,
      signInError: signInError ?? this.signInError,
      showLoading: showLoading ?? this.showLoading,
      passwordVisible: passwordVisible ?? this.passwordVisible,
    );
  }
}
