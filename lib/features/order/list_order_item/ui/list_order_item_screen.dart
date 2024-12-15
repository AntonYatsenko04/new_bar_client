import 'package:auto_route/annotations.dart';
import 'package:bar_client/core/src/di/app_di.dart';
import 'package:bar_client/features/order/list_order_item/cubit/list_order_item_cubit.dart';
import 'package:bar_client/features/order/list_order_item/ui/list_order_item_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class ListOrderItemScreen extends StatelessWidget {
  const ListOrderItemScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ListOrderItemCubit>(
      create: (_) => ListOrderItemCubit(
        orderService: appLocator(),
        userService: appLocator(),
      ),
      child: const ListOrderItemForm(),
    );
  }
}
