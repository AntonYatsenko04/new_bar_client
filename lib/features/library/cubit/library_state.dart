part of 'library_cubit.dart';

sealed class LibraryState {}

final class LoadingState extends LibraryState {}

final class DataState extends LibraryState {
  final LibraryModel? libraryModel;

  DataState({this.libraryModel});

  String? get books => libraryModel?.data.sublist(0, 100).map(datumToString).join(',\n');
}

final class ErrorState extends LibraryState {
  final String errorMessage;

  ErrorState({required this.errorMessage});
}
