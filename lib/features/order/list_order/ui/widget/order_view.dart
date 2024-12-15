import 'package:bar_client/core/src/enums/user_type.dart';
import 'package:bar_client/core/src/localization/generated/locale_keys.g.dart';
import 'package:bar_client/core_ui/src/theme/app_text_styles.dart';
import 'package:bar_client/core_ui/src/utils/number_formatters.dart';
import 'package:bar_client/core_ui/src/widgets/height_spacer.dart';
import 'package:bar_client/core_ui/src/widgets/role_widget.dart';
import 'package:bar_client/core_ui/src/widgets/width_spacer.dart';
import 'package:bar_client/features/order/list_order/cubit/list_order_cubit.dart';
import 'package:bar_client/service/models/order/order_item_response.dart';
import 'package:bar_client/service/models/order/order_response.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core_ui/src/utils/date_formatter.dart';
import '../../../../../service/models/order/order_menu_item_response.dart';

class OrderView extends StatelessWidget {
  final OrderResponse order;

  const OrderView({
    required this.order,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final ListOrderCubit cubit = context.read<ListOrderCubit>();

    final List<OrderMenuItemResponse> menus = <OrderMenuItemResponse>[
      for (final OrderItemResponse list in order.orderItems) ...list.orderMenuItems,
    ];
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
                      '${LocaleKeys.order_tableNumber.tr()} ${order.tableModel.id}',
                      style: AppTextStyles.s18W500H24Regular,
                    ),
                    const HeightSpacer(),
                    Text(
                      order.waiter.email,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 4,
                    ),
                    const HeightSpacer(),
                    Text(
                      '${LocaleKeys.order_orderCreatedAt.tr()}\n${DateFormatter.getDateTimeString(
                        order.createdAt,
                      )}',
                    ),
                    const HeightSpacer(),
                    for (final OrderMenuItemResponse menuItem in menus)
                      Text('${menuItem.menuItem.name} : ${menuItem.count}'),
                    const HeightSpacer(),
                    Center(
                      child: Text(
                        '${LocaleKeys.order_orderSum.tr()} ${NumberFormatters.formatCurrency(order.price)}',
                      ),
                    ),
                    const HeightSpacer(),
                    Row(
                      children: <Widget>[
                        RoleWidget(
                          allowedRoles: const <UserType>[UserType.manager],
                          child: IconButton(
                            onPressed: () => cubit.deleteOrders(order.id),
                            icon: const Icon(Icons.delete),
                          ),
                        ),
                        const WidthSpacer(),
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
