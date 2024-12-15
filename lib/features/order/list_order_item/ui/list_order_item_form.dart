import 'package:bar_client/features/order/list_order_item/ui/widget/order_item_view.dart';
import 'package:bar_client/service/models/user/no_role_user_model.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/src/constants/num_constants.dart';
import '../../../../core/src/localization/generated/locale_keys.g.dart';
import '../../../../core_ui/src/widgets/app_scaffold.dart';
import '../../../../core_ui/src/widgets/error_view.dart';
import '../cubit/list_order_item_cubit.dart';

class ListOrderItemForm extends StatelessWidget {
  const ListOrderItemForm({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ListOrderItemCubit, ListOrderItemState>(
      builder: (BuildContext context, ListOrderItemState state) {
        final ListOrderItemCubit cubit = context.read<ListOrderItemCubit>();

        switch (state) {
          case DataState():
            return AppScaffold(
              title: LocaleKeys.order_orderItems.tr(),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: NumConstants.maxCrossAxisExtent * 1.5,
                ),
                itemCount: state.orderItems.length,
                itemBuilder: (BuildContext context, int index) {
                  return OrderItemView(
                    orderItem: state.orderItems[index],
                    cooks: state.cooks,
                    selectedCook: state.cooksForOrderItems[index],
                    selectCookCallback: (NoRoleUserModel? cook) => cubit.selectCookForOrder(
                      orderIndex: index,
                      cook: cook,
                    ),
                  );
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
