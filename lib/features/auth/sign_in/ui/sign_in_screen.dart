import 'package:auto_route/auto_route.dart';
import 'package:bar_client/core/src/di/app_di.dart';
import 'package:bar_client/features/auth/sign_in/cubit/sign_in_cubit.dart';
import 'package:bar_client/features/auth/sign_in/ui/sign_in_form.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SignInCubit>(
      create: (_) => SignInCubit(
        authService: appLocator(),
        appRouter: appLocator(),
        userService: appLocator(),
      ),
      child: const SignInForm(),
    );
  }
}
