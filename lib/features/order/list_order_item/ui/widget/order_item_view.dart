import 'package:bar_client/core/src/enums/order_status.dart';
import 'package:bar_client/core_ui/src/utils/date_formatter.dart';
import 'package:bar_client/service/models/order/order_item_response.dart';
import 'package:bar_client/service/models/order/order_menu_item_response.dart';
import 'package:bar_client/service/models/user/no_role_user_model.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/src/enums/user_type.dart';
import '../../../../../core/src/localization/generated/locale_keys.g.dart';
import '../../../../../core_ui/src/theme/app_text_styles.dart';
import '../../../../../core_ui/src/widgets/height_spacer.dart';
import '../../../../../core_ui/src/widgets/role_widget.dart';
import '../../../../../core_ui/src/widgets/width_spacer.dart';
import '../../cubit/list_order_item_cubit.dart';

class OrderItemView extends StatelessWidget {
  final OrderItemResponse orderItem;
  final List<NoRoleUserModel> cooks;
  final void Function(NoRoleUserModel? cook) selectCookCallback;
  final NoRoleUserModel? selectedCook;

  const OrderItemView({
    required this.orderItem,
    required this.cooks,
    required this.selectCookCallback,
    this.selectedCook,
    super.key,
  });

  bool showCookButton() {
    return orderItem.status == OrderStatus.taken || orderItem.status == OrderStatus.inCooking;
  }

  bool get cookIsSelected => orderItem.cook != null;

  @override
  Widget build(BuildContext context) {
    final ListOrderItemCubit cubit = context.read<ListOrderItemCubit>();

    return Card(
      child: Row(
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Text(
                      '${LocaleKeys.order_orderStatus.tr()}: ${orderItem.status.localeKey.tr()}',
                      style: AppTextStyles.s18W500H24Regular,
                    ),
                    const HeightSpacer(),
                    Text(
                      '${LocaleKeys.order_orderCreatedAt.tr()}\n${DateFormatter.getDateTimeString(
                        orderItem.createdAt,
                      )}',
                    ),
                    const HeightSpacer(),
                    Text(
                      '${LocaleKeys.roles_cook.tr()}: ${orderItem.cook?.email ?? LocaleKeys.order_notDefined.tr()}',
                      overflow: TextOverflow.ellipsis,
                      maxLines: 4,
                    ),
                    const HeightSpacer(),
                    for (final OrderMenuItemResponse menuItem in orderItem.orderMenuItems)
                      Text('${menuItem.menuItem.name} : ${menuItem.count}'),
                    const HeightSpacer(),
                    Row(
                      children: <Widget>[
                        RoleWidget(
                          allowedRoles: const <UserType>[UserType.cook],
                          child: !showCookButton()
                              ? const SizedBox()
                              : Row(
                                  children: <Widget>[
                                    IconButton(
                                      onPressed: () {
                                        switch (orderItem.status) {
                                          case OrderStatus.taken:
                                            cubit.setCookTookOrderStatus(orderItem.id);
                                            break;
                                          case OrderStatus.inCooking:
                                            cubit.setCookFinishedOrderStatus(orderItem);
                                            break;
                                          case OrderStatus.pendingPayment || OrderStatus.complete:
                                        }
                                      },
                                      icon: const Icon(Icons.arrow_circle_right_outlined),
                                    ),
                                    const WidthSpacer(),
                                  ],
                                ),
                        ),
                        RoleWidget(
                          allowedRoles: const <UserType>[UserType.manager],
                          child: Row(
                            children: <Widget>[
                              IconButton(
                                onPressed: switch (orderItem.status) {
                                  OrderStatus.taken => selectedCook == null
                                      ? null
                                      : () => cubit.advanceManagerStatus(
                                            orderItem: orderItem,
                                            cook: selectedCook,
                                          ),
                                  OrderStatus.complete => null,
                                  _ => () => cubit.advanceManagerStatus(orderItem: orderItem),
                                },
                                icon: const Icon(Icons.arrow_circle_right_outlined),
                              ),
                              const WidthSpacer(),
                              if (!cookIsSelected)
                                SizedBox(
                                  width: 200,
                                  child: DropdownButtonFormField<NoRoleUserModel>(
                                    value: selectedCook,
                                    onChanged: selectCookCallback,
                                    items: List<DropdownMenuItem<NoRoleUserModel>>.generate(
                                      cooks.length,
                                      (int index) => DropdownMenuItem<NoRoleUserModel>(
                                        value: cooks[index],
                                        child: Text(cooks[index].email),
                                      ),
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
