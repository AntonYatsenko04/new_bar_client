import 'package:auto_route/auto_route.dart';
import 'package:bar_client/core/src/di/app_di.dart';
import 'package:bar_client/features/auth/sign_up/cubit/sign_up_cubit.dart';
import 'package:bar_client/features/auth/sign_up/ui/sign_up_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SignUpCubit>(
      create: (_) => SignUpCubit(
        appRouter: appLocator(),
        authService: appLocator(),
      ),
      child: const SignUpForm(),
    );
  }
}
