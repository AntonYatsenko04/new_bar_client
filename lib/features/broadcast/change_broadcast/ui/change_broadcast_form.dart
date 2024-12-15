import 'package:bar_client/core/src/localization/generated/locale_keys.g.dart';
import 'package:bar_client/core/src/validators/empty_field_validator.dart';
import 'package:bar_client/core_ui/src/widgets/app_scaffold.dart';
import 'package:bar_client/core_ui/src/widgets/error_view.dart';
import 'package:bar_client/core_ui/src/widgets/height_spacer.dart';
import 'package:bar_client/core_ui/src/widgets/text_fields/app_text_field_with_label.dart';
import 'package:bar_client/features/broadcast/change_broadcast/cubit/change_broadcast_cubit.dart';
import 'package:bar_client/service/models/broadcast/broadcast_model_response.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core_ui/src/utils/date_formatter.dart';

class ChangeBroadcastForm extends StatefulWidget {
  final BroadcastModelResponse? broadcast;

  const ChangeBroadcastForm({
    super.key,
    this.broadcast,
  });

  @override
  State<ChangeBroadcastForm> createState() => _ChangeBroadcastFormState();
}

class _ChangeBroadcastFormState extends State<ChangeBroadcastForm> {
  late final TextEditingController nameController;
  late final TextEditingController descriptionController;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.broadcast?.name);
    descriptionController = TextEditingController(text: widget.broadcast?.description);
  }

  @override
  Widget build(BuildContext context) {
    final ChangeBroadcastCubit cubit = context.read<ChangeBroadcastCubit>();

    return AppScaffold(
      title: (cubit.broadcast == null
              ? LocaleKeys.broadcast_createBroadcast
              : LocaleKeys.broadcast_editBroadcast)
          .tr(),
      child: Form(
        key: _formKey,
        child: BlocBuilder<ChangeBroadcastCubit, ChangeBroadcastState>(
          builder: (BuildContext context, ChangeBroadcastState state) {
            return Column(
              children: <Widget>[
                Builder(
                  builder: (_) {
                    final String? text = state.commonError;
                    if (text != null) {
                      return ErrorView(
                        message: text.tr(),
                      );
                    }
                    return const SizedBox();
                  },
                ),
                AppTextFieldWithLabel(
                  label: LocaleKeys.broadcast_title.tr(),
                  validator: const EmptyFieldValidator().check,
                  controller: nameController,
                ),
                const HeightSpacer(),
                Text(state.dateTimeString),
                const HeightSpacer(),
                Text(LocaleKeys.broadcast_allowedDateTimeRange.tr()),
                Text(
                  '${DateFormatter.getDateString(DateTime.now())} - ${DateFormatter.getDateString(DateTime(2100))}',
                ),
                const HeightSpacer(),
                ElevatedButton(
                  onPressed: () async {
                    final DateTime? dateTime = await showDatePicker(
                      context: context,
                      firstDate: DateTime.now(),
                      lastDate: DateTime(2100),
                    );
                    cubit.setDateTime(date: dateTime);
                  },
                  child: Text(LocaleKeys.commonTitles_changeDate.tr()),
                ),
                const HeightSpacer(),
                ElevatedButton(
                  onPressed: () async {
                    final DateTime initialDateTime = widget.broadcast?.dateTime ?? DateTime.now();
                    final TimeOfDay? time = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.fromDateTime(initialDateTime),
                    );

                    cubit.setDateTime(time: time);
                  },
                  child: Text(LocaleKeys.commonTitles_changeTime.tr()),
                ),
                const HeightSpacer(),
                AppTextFieldWithLabel(
                  label: LocaleKeys.broadcast_description.tr(),
                  validator: const EmptyFieldValidator().check,
                  controller: descriptionController,
                ),
                const HeightSpacer(),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      cubit.acceptChanges(
                        name: nameController.text.trim(),
                        description: descriptionController.text.trim(),
                      );
                    }
                  },
                  child: Text(
                    (cubit.broadcast == null
                            ? LocaleKeys.broadcast_createBroadcast
                            : LocaleKeys.broadcast_editBroadcast)
                        .tr(),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    nameController.dispose();
    descriptionController.dispose();
    super.dispose();
  }
}
