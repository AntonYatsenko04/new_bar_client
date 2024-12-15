import 'package:bar_client/core/src/constants/api_constants.dart';
import 'package:bar_client/service/models/menu/menu_item_response.dart';
import 'package:bar_client/service/models/menu/search_menu_request.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../models/menu/menu_item_request.dart';

part 'menu_provider.g.dart';

@RestApi()
abstract class MenuProvider {
  factory MenuProvider(Dio dio, {String baseUrl}) = _MenuProvider;

  @GET(ApiConstants.menu)
  Future<List<MenuItemResponse>> getMenuItems();

  @POST(ApiConstants.menuSearch)
  Future<List<MenuItemResponse>> searchMenuItems(@Body() SearchMenuRequest request);

  @POST(ApiConstants.menu)
  Future<void> createMenuItem(@Body() MenuItemRequest request);

  @DELETE('${ApiConstants.menu}/{id}')
  Future<void> deleteMenuItem(@Path() int id);

  @PATCH('${ApiConstants.menu}/{id}')
  Future<void> updateMenuItem(
    @Body() MenuItemRequest request,
    @Path() int id,
  );
}
