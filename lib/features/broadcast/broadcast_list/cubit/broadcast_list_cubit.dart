import 'package:auto_route/src/route/page_route_info.dart';
import 'package:bar_client/navigation/app_router/app_router.dart';
import 'package:bar_client/navigation/app_router/app_router.gr.dart';
import 'package:bar_client/service/exceptions/app_exception.dart';
import 'package:bar_client/service/models/broadcast/broadcast_model_response.dart';
import 'package:bar_client/service/services/auth_service.dart';
import 'package:bar_client/service/services/broadcast_service.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'broadcast_list_state.dart';

class BroadcastListCubit extends Cubit<BroadcastListState> {
  final BroadcastService _broadcastService;
  final AppRouter _appRouter;
  final AuthService _authService;

  BroadcastListCubit({
    required BroadcastService broadcastService,
    required AppRouter appRouter,
    required AuthService authService,
  })  : _broadcastService = broadcastService,
        _appRouter = appRouter,
        _authService = authService,
        super(LoadingState()) {
    getBroadcasts();
  }

  Future<void> getBroadcasts() async {
    try {
      final List<BroadcastModelResponse> broadcasts =
          await _broadcastService.getBroadcasts();

      emit(DataState(broadcasts: broadcasts));
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
