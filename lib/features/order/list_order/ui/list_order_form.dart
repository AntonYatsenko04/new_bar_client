import 'dart:async';

import 'package:bar_client/core/src/constants/num_constants.dart';
import 'package:bar_client/core/src/enums/user_type.dart';
import 'package:bar_client/core/src/localization/generated/locale_keys.g.dart';
import 'package:bar_client/core_ui/src/widgets/app_scaffold.dart';
import 'package:bar_client/core_ui/src/widgets/error_view.dart';
import 'package:bar_client/core_ui/src/widgets/role_widget.dart';
import 'package:bar_client/features/order/add_order_item/ui/add_order_item_screen.dart';
import 'package:bar_client/features/order/list_order/cubit/list_order_cubit.dart';
import 'package:bar_client/features/order/list_order/ui/widget/order_view.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ListOrderForm extends StatelessWidget {
  const ListOrderForm({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ListOrderCubit, ListOrderState>(
      builder: (BuildContext context, ListOrderState state) {
        final ListOrderCubit cubit = context.read<ListOrderCubit>();

        switch (state) {
          case DataState():
            return AppScaffold(
              title: LocaleKeys.order_orders.tr(),
              leading: RoleWidget(
                allowedRoles: const <UserType>[
                  UserType.manager,
                  UserType.waiter,
                ],
                child: IconButton(
                  onPressed: () async {
                    await showAdaptiveDialog(
                      context: context,
                      builder: (_) {
                        return const AddOrderItemScreen();
                      },
                    );
                    unawaited(cubit.getOrders());
                  },
                  icon: const Icon(Icons.add),
                ),
              ),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: NumConstants.maxCrossAxisExtent,
                ),
                itemCount: state.orders.length,
                itemBuilder: (BuildContext context, int index) {
                  return OrderView(order: state.orders[index]);
                },
              ),
            );
          case ErrorState():
            return AppScaffold(
              title: LocaleKeys.order_orders.tr(),
              child: Center(
                child: ErrorView(message: state.errorMessage.tr()),
              ),
            );
          case LoadingState():
            return AppScaffold(
              title: LocaleKeys.order_orders.tr(),
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            );
        }
      },
    );
  }
}
