import 'package:bar_client/features/broadcast/add_image/ui/add_image_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/src/di/app_di.dart';
import '../cubit/add_image_cubit.dart';

class AddImageScreen extends StatelessWidget {
  const AddImageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AddImageCubit>(
      create: (_) => AddImageCubit(
        broadcastService: appLocator(),
        filePickerService: appLocator(),
        broadcastImageService: appLocator(),
        appRouter: appLocator(),
      )..init(),
      child: const AddImageForm(),
    );
  }
}
