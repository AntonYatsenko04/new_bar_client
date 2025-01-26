import 'package:auto_route/annotations.dart';
import 'package:bar_client/core/src/di/app_di.dart';
import 'package:bar_client/features/auth/fake_sign_in/cubit/fake_sign_in_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'fake_sign_in_form.dart';

@RoutePage()
class FakeSignInScreen extends StatelessWidget {
  const FakeSignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<FakeSignInCubit>(
      create: (_) => FakeSignInCubit(
        authService: appLocator(),
        appRouter: appLocator(),
        userService: appLocator(),
        csrfTokenService: appLocator(),
      ),
      child: const FakeSignInForm(),
    );
  }
}
