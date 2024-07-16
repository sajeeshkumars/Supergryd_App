import 'package:mynewpackage/app/modules/track_order/data/models/order_track_response.dart';

abstract class OrderTrackService {
  Future<OrderTrackResponse> trackOrder(
      {required int orderId, required String deviceId});
}
