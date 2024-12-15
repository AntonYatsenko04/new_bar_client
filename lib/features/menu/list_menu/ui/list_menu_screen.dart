import 'package:auto_route/auto_route.dart';
import 'package:bar_client/core/src/di/app_di.dart';
import 'package:bar_client/features/menu/list_menu/cubit/list_menu_cubit.dart';
import 'package:bar_client/features/menu/list_menu/ui/list_menu_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class ListMenuScreen extends StatelessWidget {
  const ListMenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ListMenuCubit>(
      create: (_) => ListMenuCubit(
        menuService: appLocator(),
      ),
      child: const ListMenuForm(),
    );
  }
}
