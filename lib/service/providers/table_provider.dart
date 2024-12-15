import 'package:bar_client/core/src/constants/api_constants.dart';
import 'package:bar_client/service/models/table/table_model.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'table_provider.g.dart';

@RestApi()
abstract class TableProvider {
  factory TableProvider(Dio dio, {String baseUrl}) = _TableProvider;

  @GET(ApiConstants.table)
  Future<List<TableModel>> getTables();
}
