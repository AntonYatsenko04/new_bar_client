import 'package:bar_client/service/models/common/array_model.dart';
import 'package:bar_client/service/models/id_model.dart';
import 'package:bar_client/service/models/order/order_menu_item_request.dart';
import 'package:bar_client/service/models/order/order_request.dart';
import 'package:bar_client/service/models/order/order_response.dart';
import 'package:bar_client/service/models/order/patch_order_item_request.dart';
import 'package:bar_client/service/models/order/update_order_request.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../core/src/constants/api_constants.dart';
import '../models/order/order_item_request.dart';
import '../models/order/order_item_response.dart';

part 'order_provider.g.dart';

@RestApi()
abstract class OrderProvider {
  factory OrderProvider(Dio dio, {String baseUrl}) = _OrderProvider;

  @GET(ApiConstants.order)
  Future<List<OrderResponse>> getOrders();

  @GET(ApiConstants.orderItemEntities)
  Future<List<OrderItemResponse>> getOrderItems();

  @PATCH(ApiConstants.orderItem)
  Future<void> patchOrderItem({
    @Body() required PatchOrderItemRequest request,
  });

  @POST(ApiConstants.order)
  Future<IdModel> createOrder(@Body() OrderRequest request);

  @POST(ApiConstants.orderItem)
  Future<IdModel> createOrderItem(@Body() OrderItemRequest request);

  @POST(ApiConstants.orderMenuItem)
  Future<void> createOrderMenuItems(
    @Body() ArrayModel<OrderMenuItemRequest> request,
  );

  @DELETE('${ApiConstants.orderEntities}/{id}')
  Future<void> deleteOrder(@Path() int id);

  @PATCH('${ApiConstants.order}/{id}')
  Future<void> updateOrder(
    @Body() UpdateOrderRequest request,
    @Path() int id,
  );
}
