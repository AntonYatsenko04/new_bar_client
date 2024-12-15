import 'package:bar_client/core/src/localization/generated/locale_keys.g.dart';
import 'package:bar_client/core_ui/src/widgets/app_scaffold.dart';
import 'package:bar_client/core_ui/src/widgets/error_view.dart';
import 'package:bar_client/core_ui/src/widgets/height_spacer.dart';
import 'package:bar_client/core_ui/src/widgets/text_fields/app_text_field_with_label.dart';
import 'package:bar_client/features/auth/sign_in/cubit/sign_in_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignInForm extends StatefulWidget {
  const SignInForm({super.key});

  @override
  State<SignInForm> createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    final SignInCubit cubit = context.read<SignInCubit>();

    return AppScaffold(
      title: LocaleKeys.auth_signIn.tr(),
      child: BlocBuilder<SignInCubit, SignInState>(
        builder: (BuildContext context, SignInState state) {
          final String? emailError = state.emailError;
          final String? passwordError = state.passwordError;
          final String? signInError = state.signInError;
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              if (signInError != null) ...<Widget>[ErrorView(message: signInError.tr())],
              const HeightSpacer(),
              AppTextFieldWithLabel(
                label: LocaleKeys.auth_email.tr(),
                controller: _emailController,
                error: emailError != null ? Text(emailError.tr()) : null,
              ),
              const HeightSpacer(),
              AppTextFieldWithLabel(
                label: LocaleKeys.auth_password.tr(),
                controller: _passwordController,
                error: passwordError != null ? Text(passwordError.tr()) : null,
                obscureText: !state.passwordVisible,
                suffixIcon: IconButton(
                  onPressed: cubit.changePasswordVisibility,
                  icon: Icon(
                    state.passwordVisible ? Icons.visibility : Icons.visibility_off,
                  ),
                ),
              ),
              const HeightSpacer(),
              FilledButton(
                onPressed: () {
                  cubit.signIn(
                    email: _emailController.text,
                    password: _passwordController.text,
                  );
                },
                child: Text(
                  LocaleKeys.auth_signInAction.tr(),
                ),
              ),
              const HeightSpacer(),
              FilledButton(
                onPressed: cubit.goToSignUp,
                child: Text(
                  LocaleKeys.auth_signUp.tr(),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
