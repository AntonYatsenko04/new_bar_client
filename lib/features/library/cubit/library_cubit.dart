import 'package:bar_client/service/exceptions/app_exception.dart';
import 'package:bar_client/service/models/library/library_model.dart';
import 'package:bar_client/service/services/library_service.dart';
import 'package:bloc/bloc.dart';

import '../../../core/src/logger/logger.dart';

part 'library_state.dart';

class LibraryCubit extends Cubit<LibraryState> {
  final LibraryService _libraryService;

  LibraryCubit({required LibraryService libraryService})
      : _libraryService = libraryService,
        super(DataState());

  Future<void> getCodeLibrary() async {
    try {
      emit(LoadingState());
      final LibraryModel libraryModel = await _libraryService.getCodeLibrary();
      emit(DataState(libraryModel: libraryModel));
    } on AppException catch (e, st) {
      AppLogger().error(error: e, stackTrace: st);
      emit(
        ErrorState(
          errorMessage: e.errorMessageKey,
        ),
      );
    }
  }

  Future<void> getDbLibrary() async {
    try {
      emit(LoadingState());
      final LibraryModel libraryModel = await _libraryService.getDbLibrary();
      emit(DataState(libraryModel: libraryModel));
    } on AppException catch (e, st) {
      AppLogger().error(error: e, stackTrace: st);
      emit(
        ErrorState(
          errorMessage: e.errorMessageKey,
        ),
      );
    }
  }
}
