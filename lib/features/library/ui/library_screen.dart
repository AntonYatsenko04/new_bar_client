import 'package:auto_route/annotations.dart';
import 'package:bar_client/core/src/di/app_di.dart';
import 'package:bar_client/features/library/cubit/library_cubit.dart';
import 'package:bar_client/features/library/ui/library_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class LibraryScreen extends StatelessWidget {
  const LibraryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LibraryCubit>(
      create: (_) => LibraryCubit(
        libraryService: appLocator(),
      ),
      child: const LibraryForm(),
    );
  }
}
