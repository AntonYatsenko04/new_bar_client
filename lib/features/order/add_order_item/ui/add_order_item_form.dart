import 'package:bar_client/core/src/enums/user_type.dart';
import 'package:bar_client/core_ui/src/widgets/role_widget.dart';
import 'package:bar_client/features/order/add_order_item/cubit/add_order_item_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/src/constants/num_constants.dart';
import '../../../../core/src/localization/generated/locale_keys.g.dart';
import '../../../../core/src/validators/empty_field_validator.dart';
import '../../../../core_ui/src/widgets/app_scaffold.dart';
import '../../../../core_ui/src/widgets/error_view.dart';
import '../../../../core_ui/src/widgets/menu_card.dart';
import '../../../../core_ui/src/widgets/width_spacer.dart';
import '../../../../service/models/menu/menu_item_response.dart';

class AddOrderItemForm extends StatefulWidget {
  const AddOrderItemForm({super.key});

  @override
  State<AddOrderItemForm> createState() => _AddOrderItemFormState();
}

class _AddOrderItemFormState extends State<AddOrderItemForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddOrderItemCubit, AddOrderItemState>(
      builder: (BuildContext context, AddOrderItemState state) {
        final AddOrderItemCubit cubit = context.read<AddOrderItemCubit>();

        switch (state) {
          case LoadingState():
            return AppScaffold(
              title: LocaleKeys.order_addOrderItem.tr(),
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            );
          case ErrorState():
            return AppScaffold(
              title: LocaleKeys.order_addOrderItem.tr(),
              child: Center(
                child: ErrorView(
                  message: state.errorMessage.tr(),
                ),
              ),
            );
          case DataState():
            return Form(
              key: _formKey,
              child: AppScaffold(
                title: LocaleKeys.order_addOrderItem.tr(),
                floatingActionButton: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      cubit.addSubOrder();
                    }
                  },
                  child: Text(
                    LocaleKeys.order_addOrderItem.tr(),
                  ),
                ),
                actions: <Widget>[
                  RoleWidget(
                    allowedRoles: const <UserType>[UserType.manager],
                    child: Text(
                      LocaleKeys.order_chooseWaiterId.tr(),
                    ),
                  ),
                  const WidthSpacer(),
                  RoleWidget(
                    allowedRoles: const <UserType>[UserType.manager],
                    child: SizedBox(
                      width: 200,
                      child: DropdownButtonFormField<int>(
                        items: List<DropdownMenuItem<int>>.generate(
                          state.waiterIds.length,
                          (int index) => DropdownMenuItem<int>(
                            value: state.waiterIds[index],
                            child: Text(state.waiterIds[index].toString()),
                          ),
                        ),
                        onChanged: cubit.setWaiterId,
                      ),
                    ),
                  ),
                  const WidthSpacer(),
                  Text(LocaleKeys.order_chooseTableNumber.tr()),
                  const WidthSpacer(),
                  SizedBox(
                    width: 100,
                    child: DropdownButtonFormField<int>(
                      validator: (int? value) =>
                          const EmptyFieldValidator().check(value?.toString()),
                      value: state.tableNumber,
                      onChanged: cubit.setTableNumber,
                      items: List<DropdownMenuItem<int>>.generate(
                        state.tableIds.length,
                        (int index) => DropdownMenuItem<int>(
                          value: state.tableIds[index],
                          child: Text(state.tableIds[index].toString()),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 50,
                  ),
                ],
                child: Stack(
                  children: <Widget>[
                    GridView.builder(
                      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: NumConstants.maxCrossAxisExtent + 100,
                      ),
                      itemCount: state.menuToCountMap.length,
                      itemBuilder: (BuildContext context, int index) {
                        final MenuItemResponse item = state.menuToCountMap.keys.toList()[index];

                        return MenuCard(
                          menuItemModel: item,
                          actions: <Widget>[
                            IconButton(
                              onPressed: () {
                                cubit.changeItemCount(item, false);
                              },
                              icon: const Icon(Icons.remove),
                            ),
                            Text(
                              state.menuToCountMap.values.toList()[index].toString(),
                            ),
                            IconButton(
                              onPressed: () {
                                cubit.changeItemCount(item, true);
                              },
                              icon: const Icon(Icons.add),
                            ),
                          ],
                        );
                      },
                    ),
                    if (state.errorMessage != null)
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: ErrorView(
                          message: state.errorMessage!.tr(),
                        ),
                      ),
                  ],
                ),
              ),
            );
        }
      },
    );
  }
}
