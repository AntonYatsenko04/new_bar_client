import 'package:auto_route/auto_route.dart';
import 'package:bar_client/core/src/di/app_di.dart';
import 'package:bar_client/features/order/list_order/cubit/list_order_cubit.dart';
import 'package:bar_client/features/order/list_order/ui/list_order_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class ListOrderScreen extends StatelessWidget {
  const ListOrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ListOrderCubit>(
      create: (_) => ListOrderCubit(
        orderService: appLocator(),
        appRouter: appLocator(),
      ),
      child: const ListOrderForm(),
    );
  }
}
