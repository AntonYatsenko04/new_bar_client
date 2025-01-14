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
      final List<String> searchSuggestions = await _broadcastService.getSearchRequests();

      emit(
        DataState(
          broadcasts: broadcasts,
          broadcastImages: broadcastImages,
          searchSuggestions: searchSuggestions,
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

  Future<void> searchBroadcasts(String? searchString) async {
    final BroadcastListState currentState = state;
    if (currentState is! DataState) {
      return;
    }

    final List<BroadcastModelResponse> broadcasts;

    if (searchString == null || searchString.isEmpty) {
      broadcasts = currentState.broadcasts;
    } else {
      broadcasts = currentState.broadcasts
          .where(
            (BroadcastModelResponse e) => e.name.trim().toLowerCase().contains(
                  searchString.trim().toLowerCase(),
                ),
          )
          .toList();
      try {
        await _broadcastService.addSearchRequest(searchRequest: searchString);
      } on AppException catch (e) {
        emit(ErrorState(errorMessage: e.errorMessageKey));
        return;
      }
    }
    final List<String> searchSuggestions;

    try {
      searchSuggestions = await _broadcastService.getSearchRequests();
    } on AppException catch (e) {
      emit(ErrorState(errorMessage: e.errorMessageKey));
      return;
    }

    emit(
      currentState.copyWith(
        searchSuggestions: searchSuggestions,
        filteredBroadcasts: broadcasts,
      ),
    );
  }

  Future<void> logout() async {
    await _authService.signOut();
    await _appRouter.replaceAll(<PageRouteInfo>[const SignInRoute()]);
  }
}
