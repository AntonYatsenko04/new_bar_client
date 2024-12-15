import 'package:bar_client/core/src/localization/generated/locale_keys.g.dart';
import 'package:bar_client/core/src/validators/empty_field_validator.dart';
import 'package:bar_client/core/src/validators/int_number_greater_than_zero_validator.dart';
import 'package:bar_client/core/src/validators/validator.dart';
import 'package:bar_client/core_ui/src/widgets/app_scaffold.dart';
import 'package:bar_client/core_ui/src/widgets/error_view.dart';
import 'package:bar_client/core_ui/src/widgets/height_spacer.dart';
import 'package:bar_client/service/models/menu/menu_item_response.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/src/validators/validator_union.dart';
import '../../../../core_ui/src/widgets/text_fields/app_text_field_with_label.dart';
import '../cubit/edit_menu_cubit.dart';

class EditMenuForm extends StatefulWidget {
  final MenuItemResponse? menuItem;

  const EditMenuForm({
    super.key,
    this.menuItem,
  });

  @override
  State<EditMenuForm> createState() => _EditMenuFormState();
}

class _EditMenuFormState extends State<EditMenuForm> {
  late final TextEditingController nameController;
  late final TextEditingController descriptionController;
  late final TextEditingController priceController;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.menuItem?.name);
    descriptionController = TextEditingController(text: widget.menuItem?.description);
    priceController = TextEditingController(text: widget.menuItem?.price.toString());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EditMenuCubit, EditMenuState>(
      builder: (BuildContext context, EditMenuState state) {
        final EditMenuCubit cubit = context.read<EditMenuCubit>();
        final bool isCreate = cubit.menuItem == null;
        return AppScaffold(
          title: (isCreate ? LocaleKeys.menu_createMenu : LocaleKeys.menu_editMenu).tr(),
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                Builder(
                  builder: (_) {
                    final String? text = state.errorMessage;
                    if (text != null) {
                      return ErrorView(
                        message: text.tr(),
                      );
                    }
                    return const SizedBox();
                  },
                ),
                AppTextFieldWithLabel(
                  label: LocaleKeys.menu_title.tr(),
                  validator: const EmptyFieldValidator().check,
                  controller: nameController,
                ),
                const HeightSpacer(),
                AppTextFieldWithLabel(
                  label: LocaleKeys.menu_description.tr(),
                  validator: const EmptyFieldValidator().check,
                  controller: descriptionController,
                ),
                const HeightSpacer(),
                AppTextFieldWithLabel(
                  label: LocaleKeys.menu_price.tr(),
                  validator: ValidatorUnion(
                    validators: <Validator>[
                      const EmptyFieldValidator(),
                      const IntNumberGreaterThanZeroValidator(),
                    ],
                  ).check,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(6),
                  ],
                  controller: priceController,
                ),
                const HeightSpacer(),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      cubit.acceptChanges(
                        name: nameController.text.trim(),
                        description: descriptionController.text.trim(),
                        priceText: priceController.text,
                      );
                    }
                  },
                  child: Text(
                    (isCreate ? LocaleKeys.menu_createMenu : LocaleKeys.menu_editMenu).tr(),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    nameController.dispose();
    descriptionController.dispose();
    priceController.dispose();
    super.dispose();
  }
}
