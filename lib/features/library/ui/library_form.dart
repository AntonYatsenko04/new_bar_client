import 'package:bar_client/core/src/localization/generated/locale_keys.g.dart';
import 'package:bar_client/core_ui/src/widgets/app_scaffold.dart';
import 'package:bar_client/core_ui/src/widgets/error_view.dart';
import 'package:bar_client/core_ui/src/widgets/height_spacer.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../service/models/library/library_model.dart';
import '../cubit/library_cubit.dart';

class LibraryForm extends StatelessWidget {
  const LibraryForm({super.key});

  @override
  Widget build(BuildContext context) {
    final LibraryCubit cubit = context.read<LibraryCubit>();
    return AppScaffold(
      title: LocaleKeys.library_library.tr(),
      child: Center(
        child: BlocBuilder<LibraryCubit, LibraryState>(
          builder: (BuildContext context, LibraryState state) => switch (state) {
            LoadingState() => const CircularProgressIndicator(),
            DataState() => SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    FilledButton(
                      onPressed: cubit.getDbLibrary,
                      child: Text(
                        LocaleKeys.library_getDbLibrary.tr(),
                      ),
                    ),
                    const HeightSpacer(),
                    FilledButton(
                      onPressed: cubit.getCodeLibrary,
                      child: Text(
                        LocaleKeys.library_getCodeLibrary.tr(),
                      ),
                    ),
                    if (state.libraryModel case final LibraryModel libraryModel) ...<Widget>[
                      const HeightSpacer(),
                      Text('${LocaleKeys.library_timeToProcess.tr()} ${libraryModel.time} мс'),
                      const HeightSpacer(),
                      Text('${LocaleKeys.library_requiredMemory.tr()} ${libraryModel.memory} байт'),
                      const HeightSpacer(),
                      Text(
                          '${LocaleKeys.library_booksCount.tr()} ${libraryModel.data.length} штуки'),
                      const HeightSpacer(),
                      Text(
                        '${LocaleKeys.library_library.tr()} \n ${state.books}',
                      ),
                    ]
                  ],
                ),
              ),
            ErrorState() => ErrorView(
                message: state.errorMessage.tr(),
              ),
          },
        ),
      ),
    );
  }
}
