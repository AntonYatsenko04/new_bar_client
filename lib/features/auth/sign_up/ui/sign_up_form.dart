import 'package:bar_client/core/src/enums/user_type.dart';
import 'package:bar_client/core/src/localization/generated/locale_keys.g.dart';
import 'package:bar_client/core_ui/src/widgets/app_scaffold.dart';
import 'package:bar_client/core_ui/src/widgets/height_spacer.dart';
import 'package:bar_client/features/auth/sign_up/cubit/sign_up_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core_ui/src/widgets/error_view.dart';
import '../../../../core_ui/src/widgets/text_fields/app_text_field_with_label.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({super.key});

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
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
    final SignUpCubit cubit = context.read<SignUpCubit>();

    return AppScaffold(
      title: LocaleKeys.auth_signUp.tr(),
      child: BlocBuilder<SignUpCubit, SignUpState>(
        builder: (BuildContext context, SignUpState state) {
          final String? emailError = state.emailError;
          final String? passwordError = state.passwordError;
          final String? signUpError = state.signUpError;
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              if (signUpError != null) ...<Widget>[
                ErrorView(message: signUpError.tr()),
              ],
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
                suffixIcon: IconButton(
                  onPressed: cubit.changePasswordVisibility,
                  icon: Icon(
                    state.passwordVisible
                        ? Icons.visibility
                        : Icons.visibility_off,
                  ),
                ),
                obscureText: !state.passwordVisible,
              ),
              const HeightSpacer(),
              DropdownButton<UserType>(
                onChanged: (UserType? userType) {
                  // if (userType != null) {
                  //   cubit.changeUserType(userType);
                  // }
                },
                value: state.userType,
                items: List.generate(
                  UserType.values.length,
                  (int index) => DropdownMenuItem<UserType>(
                    value: UserType.values[index],
                    child: Text(UserType.values[index].localeKey.tr()),
                    onTap: () => cubit.changeUserType(UserType.values[index]),
                  ),
                ),
              ),
              const HeightSpacer(),
              FilledButton(
                onPressed: () {
                  cubit.signUp(
                    email: _emailController.text,
                    password: _passwordController.text,
                  );
                },
                child: Text(
                  LocaleKeys.auth_signUpAction.tr(),
                ),
              ),
              const HeightSpacer(),
              FilledButton(
                onPressed: cubit.goToSignIn,
                child: Text(
                  LocaleKeys.auth_signIn.tr(),
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
