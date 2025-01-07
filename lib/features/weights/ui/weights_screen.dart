import 'package:auto_route/annotations.dart';
import 'package:bar_client/core/src/di/app_di.dart';
import 'package:bar_client/features/weights/ui/weights_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/weights_cubit.dart';

@RoutePage()
class WeightsScreen extends StatelessWidget {
  const WeightsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<WeightsCubit>(
      create: (_) => WeightsCubit(
        weightsService: appLocator(),
      )..getWeights(),
      child: const WeightsForm(),
    );
  }
}
