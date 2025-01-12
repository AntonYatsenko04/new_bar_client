import 'dart:typed_data';

import 'package:bar_client/features/broadcast/add_image/cubit/add_image_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/src/localization/generated/locale_keys.g.dart';
import '../../../../core_ui/src/widgets/app_scaffold.dart';
import '../../../../core_ui/src/widgets/error_view.dart';
import '../../../../core_ui/src/widgets/height_spacer.dart';
import '../../../../core_ui/src/widgets/width_spacer.dart';
import '../../../../service/models/broadcast/broadcast_model_response.dart';

class AddImageForm extends StatelessWidget {
  const AddImageForm({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: LocaleKeys.broadcast_addPhoto.tr(),
      child: BlocBuilder<AddImageCubit, AddImageState>(
        builder: (
          BuildContext context,
          AddImageState state,
        ) {
          final AddImageCubit cubit = context.read<AddImageCubit>();
          switch (state) {
            case LoadingState():
              return const Center(
                child: CircularProgressIndicator(),
              );
            case DataState():
              return CustomScrollView(slivers: <Widget>[
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: Column(
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
                      SizedBox(
                        width: 300,
                        child: DropdownButtonFormField<BroadcastModelResponse>(
                          items: List<DropdownMenuItem<BroadcastModelResponse>>.generate(
                            state.broadcasts.length,
                            (int index) {
                              final BroadcastModelResponse broadcast = state.broadcasts[index];
                              return DropdownMenuItem<BroadcastModelResponse>(
                                value: broadcast,
                                child: Text('${broadcast.name}, id: ${broadcast.id}'),
                              );
                            },
                          ),
                          onChanged: cubit.selectBroadcastForUpdate,
                        ),
                      ),
                      const HeightSpacer(),
                      if (state.imageBytes case final Uint8List imageBytes)
                        Image.memory(
                          imageBytes,
                          height: 300,
                        ),
                      const HeightSpacer(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          ElevatedButton(
                            onPressed: cubit.pickImage,
                            child: Text(
                              LocaleKeys.broadcast_addPhoto.tr(),
                            ),
                          ),
                          const WidthSpacer(),
                          Column(
                            children: <Widget>[
                              Text(LocaleKeys.broadcast_saveToSeparateFile.tr()),
                              Switch(
                                value: state.saveToSeparateFile,
                                onChanged: (_) {
                                  cubit.toggleSaveToSeparateFile();
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                      const HeightSpacer(),
                      ElevatedButton(
                        onPressed: state.canSendImage ? cubit.saveImage : null,
                        child: Text(
                          LocaleKeys.broadcast_attachPhotoToBroadcast.tr(),
                        ),
                      ),
                    ],
                  ),
                ),
              ]);
            case ErrorState():
              return Center(
                child: ErrorView(message: state.errorMessage),
              );
          }
        },
      ),
    );
  }
}
