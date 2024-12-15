import 'package:bar_client/service/models/table/table_model.dart';
import 'package:bar_client/service/providers/table_provider.dart';
import 'package:bar_client/service/safe_request/safe_request.dart';

class TableService {
  final TableProvider _tableProvider;

  TableService({
    required TableProvider tableProvider,
  }) : _tableProvider = tableProvider;

  Future<List<TableModel>> getTables() {
    return safeRequest<List<TableModel>>(_tableProvider.getTables);
  }
}
