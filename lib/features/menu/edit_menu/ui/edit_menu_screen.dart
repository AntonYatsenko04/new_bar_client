import 'package:bar_client/core/src/di/app_di.dart';
import 'package:bar_client/features/menu/edit_menu/cubit/edit_menu_cubit.dart';
import 'package:bar_client/features/menu/edit_menu/ui/edit_menu_form.dart';
import 'package:bar_client/service/models/menu/menu_item_response.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditMenuScreen extends StatelessWidget {
  final MenuItemResponse? menuItem;
  const EditMenuScreen({
    super.key,
    this.menuItem,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider<EditMenuCubit>(
      create: (_) => EditMenuCubit(
        menuItem: menuItem,
        appRouter: appLocator(),
        menuService: appLocator(),
      ),
      child: EditMenuForm(
        menuItem: menuItem,
      ),
    );
  }
}
