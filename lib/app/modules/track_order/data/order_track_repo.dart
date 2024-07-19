import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:mynewpackage/app/modules/track_order/data/models/order_track_response.dart';

import '../../../../services/api_service.dart';
import 'order_track_service.dart';

class OrderTrackRepository implements OrderTrackService {
  ApiService apiServiceExternal = Get.find();

  Future<OrderTrackResponse> trackOrder(
      {required int orderId, required String deviceId}) async {
    OrderTrackResponse orderTrackResponse;
    Response response = await apiServiceExternal.reqst(
        url:
            'behrouzbiryani/v1/api/order-status-update?order_id=$orderId&device_id=$deviceId',
        method: Method.GET);
    try {
      orderTrackResponse = OrderTrackResponse.fromJson(response.body);
      return orderTrackResponse;
    } catch (e, s) {
      debugPrint(s.toString());
      debugPrint(e.toString());
      return OrderTrackResponse(message: "Server Error", status: 401);
    }
  }
}
