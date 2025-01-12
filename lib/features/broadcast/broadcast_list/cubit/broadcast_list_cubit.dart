import 'dart:typed_data';

import 'package:auto_route/src/route/page_route_info.dart';
import 'package:bar_client/navigation/app_router/app_router.dart';
import 'package:bar_client/navigation/app_router/app_router.gr.dart';
import 'package:bar_client/service/exceptions/app_exception.dart';
import 'package:bar_client/service/models/broadcast/broadcast_model_response.dart';
import 'package:bar_client/service/services/auth_service.dart';
import 'package:bar_client/service/services/broadcast_image_service.dart';
import 'package:bar_client/service/services/broadcast_service.dart';
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../service/models/broadcast/broadcast_image_ui_model.dart';

part 'broadcast_list_cubit.freezed.dart';
part 'broadcast_list_state.dart';

class BroadcastListCubit extends Cubit<BroadcastListState> {
  final BroadcastService _broadcastService;
  final BroadcastImageService _broadcastImageService;
  final AppRouter _appRouter;
  final AuthService _authService;

  BroadcastListCubit({
    required BroadcastService broadcastService,
    required BroadcastImageService broadcastImageService,
    required AppRouter appRouter,
    required AuthService authService,
  })  : _broadcastService = broadcastService,
        _broadcastImageService = broadcastImageService,
        _appRouter = appRouter,
        _authService = authService,
        super(LoadingState());

  Future<void> getBroadcasts() async {
    try {
      final List<BroadcastModelResponse> broadcasts = await _broadcastService.getBroadcasts();
      final List<BroadcastImageUiModel> broadcastImages =
          await _broadcastImageService.getBroadcastImages();

      emit(
        DataState(
          broadcasts: broadcasts,
          broadcastImages: broadcastImages,
        ),
      );
    } on AppException catch (e) {
      emit(ErrorState(errorMessage: e.errorMessageKey));
    }
  }

  Future<void> deleteBroadcast(int id) async {
    try {
      emit(LoadingState());
      await _broadcastService.deleteBroadcast(id);
      await getBroadcasts();
    } on AppException catch (e) {
      emit(ErrorState(errorMessage: e.errorMessageKey));
    }
  }

  void setSearchString(String? searchString) {
    final BroadcastListState currentState = state;
    if (currentState is! DataState) {
      return;
    }

    emit(
      currentState.copyWith(
        searchString: searchString,
      ),
    );
  }

  Future<void> updateSearch(String? input) async {
    final BroadcastListState currentState = state;
    if (currentState is DataState) {
      emit(currentState.copyWith(searchString: null));
    }
  }

  Future<void> logout() async {
    await _authService.signOut();
    await _appRouter.replaceAll(<PageRouteInfo>[const SignInRoute()]);
  }
}
