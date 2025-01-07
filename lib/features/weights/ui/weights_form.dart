import 'package:bar_client/core/src/localization/generated/locale_keys.g.dart';
import 'package:bar_client/core_ui/src/widgets/app_scaffold.dart';
import 'package:bar_client/core_ui/src/widgets/error_view.dart';
import 'package:bar_client/core_ui/src/widgets/height_spacer.dart';
import 'package:bar_client/core_ui/src/widgets/text_fields/app_text_field_with_label.dart';
import 'package:bar_client/features/weights/cubit/weights_cubit.dart';
import 'package:bar_client/service/models/weights/weights_model.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WeightsForm extends StatefulWidget {
  const WeightsForm({super.key});

  @override
  State<WeightsForm> createState() => _WeightsFormState();
}

class _WeightsFormState extends State<WeightsForm> {
  final TextEditingController menuQuantityInOrdersController = TextEditingController();
  final TextEditingController orderWithThisMenuQuantityController = TextEditingController();
  final TextEditingController menuPricePercentInOrdersController = TextEditingController();

  @override
  void initState() {
    super.initState();

    void setZeroWhenEmpty(TextEditingController controller) {
      if (controller.text.isEmpty) {
        controller.text = '0';
      } else if (controller.text != '0' && controller.text.contains('0')) {
        controller.text = controller.text.replaceAll('0', '');
      }
    }

    menuQuantityInOrdersController
        .addListener(() => setZeroWhenEmpty(menuQuantityInOrdersController));
    orderWithThisMenuQuantityController
        .addListener(() => setZeroWhenEmpty(orderWithThisMenuQuantityController));
    menuPricePercentInOrdersController
        .addListener(() => setZeroWhenEmpty(menuPricePercentInOrdersController));
  }

  @override
  Widget build(BuildContext context) {
    final WeightsCubit cubit = context.read<WeightsCubit>();

    return BlocConsumer<WeightsCubit, WeightsState>(
      listener: (BuildContext context, WeightsState state) {
        if (state is DataState) {
          menuQuantityInOrdersController.text = state.weights.itemQuantity.toString();
          orderWithThisMenuQuantityController.text = state.weights.orderQuantity.toString();
          menuPricePercentInOrdersController.text = state.weights.pricePercentage.toString();
        }
      },
      builder: (BuildContext context, WeightsState state) {
        return AppScaffold(
          title: LocaleKeys.weights_weights.tr(),
          child: switch (state) {
            LoadingState() => const Center(child: CircularProgressIndicator()),
            DataState() => Column(
                children: <Widget>[
                  AppTextFieldWithLabel(
                    label: LocaleKeys.weights_menuQuantityInOrders.tr(),
                    controller: menuQuantityInOrdersController,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(4),
                    ],
                  ),
                  const HeightSpacer(),
                  AppTextFieldWithLabel(
                    label: LocaleKeys.weights_orderWithThisMenuQuantity.tr(),
                    controller: orderWithThisMenuQuantityController,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(4),
                    ],
                  ),
                  const HeightSpacer(),
                  AppTextFieldWithLabel(
                    label: LocaleKeys.weights_menuPricePercentInOrders.tr(),
                    controller: menuPricePercentInOrdersController,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(4),
                    ],
                  ),
                  const HeightSpacer(),
                  ElevatedButton(
                    onPressed: () => cubit.putWeights(
                      weights: WeightsModel(
                        itemQuantity: int.parse(menuQuantityInOrdersController.text),
                        orderQuantity: int.parse(orderWithThisMenuQuantityController.text),
                        pricePercentage: int.parse(menuPricePercentInOrdersController.text),
                      ),
                    ),
                    child: Text(
                      LocaleKeys.weights_editWeight.tr(),
                    ),
                  ),
                ],
              ),
            ErrorState() => Center(
                child: ErrorView(
                  message: state.errorMessage.tr(),
                ),
              ),
          },
        );
      },
    );
  }

  @override
  void dispose() {
    menuQuantityInOrdersController.dispose();
    orderWithThisMenuQuantityController.dispose();
    menuPricePercentInOrdersController.dispose();
    super.dispose();
  }
}
