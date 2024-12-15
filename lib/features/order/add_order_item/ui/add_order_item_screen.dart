import 'package:auto_route/auto_route.dart';
import 'package:bar_client/core/src/di/app_di.dart';
import 'package:bar_client/features/order/add_order_item/cubit/add_order_item_cubit.dart';
import 'package:bar_client/features/order/add_order_item/ui/add_order_item_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class AddOrderItemScreen extends StatelessWidget {
  const AddOrderItemScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AddOrderItemCubit>(
      create: (_) => AddOrderItemCubit(
        menuService: appLocator(),
        orderService: appLocator(),
        tableService: appLocator(),
        userService: appLocator(),
        appRouter: appLocator(),
      ),
      child: const AddOrderItemForm(),
    );
  }
}
