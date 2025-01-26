part of 'fake_sign_in_cubit.dart';

@immutable
final class FakeSignInState {
  final String? emailError;
  final String? passwordError;
  final String? signInError;
  final bool showLoading;
  final bool passwordVisible;

  const FakeSignInState({
    required this.showLoading,
    required this.passwordVisible,
    this.emailError,
    this.passwordError,
    this.signInError,
  });

  FakeSignInState.empty()
      : showLoading = false,
        passwordVisible = false,
        emailError = null,
        passwordError = null,
        signInError = null;

  FakeSignInState copyWith({
    String? emailError,
    String? passwordError,
    String? signInError,
    bool? showLoading,
    bool? passwordVisible,
  }) {
    return FakeSignInState(
      emailError: emailError ?? this.emailError,
      passwordError: passwordError ?? this.passwordError,
      signInError: signInError ?? this.signInError,
      showLoading: showLoading ?? this.showLoading,
      passwordVisible: passwordVisible ?? this.passwordVisible,
    );
  }
}
