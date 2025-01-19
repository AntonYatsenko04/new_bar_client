import 'package:bar_client/service/models/library/library_model.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../core/src/constants/api_constants.dart';

part 'library_provider.g.dart';

@RestApi(baseUrl: ApiConstants.xamppBaseUrl)
abstract class LibraryProvider {
  factory LibraryProvider(Dio dio, {String baseUrl}) = _LibraryProvider;

  @GET(ApiConstants.xamppDbLibrary)
  Future<LibraryModel> getDbLibrary();

  @GET(ApiConstants.xamppCodeLibrary)
  Future<LibraryModel> getCodeLibrary();
}
