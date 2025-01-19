import 'package:bar_client/service/providers/library_provider.dart';
import 'package:bar_client/service/safe_request/safe_request.dart';

import '../models/library/library_model.dart';

class LibraryService {
  final LibraryProvider _libraryProvider;

  LibraryService({
    required LibraryProvider libraryProvider,
  }) : _libraryProvider = libraryProvider;

  Future<LibraryModel> getDbLibrary() {
    return safeRequest(_libraryProvider.getDbLibrary);
  }

  Future<LibraryModel> getCodeLibrary() {
    return safeRequest(_libraryProvider.getCodeLibrary);
  }
}
