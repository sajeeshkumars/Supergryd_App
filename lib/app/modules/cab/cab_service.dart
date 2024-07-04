
import 'package:mynewpackage/app/modules/cab/model/cancel_response.dart';
import 'package:mynewpackage/app/modules/cab/ride_track_response.dart';

import 'model/Ride_details_response.dart';
import 'model/cancel_reasons_response.dart';

abstract class CabService {
  Future<RideTrackResponse> trackRide({required int requestId, int? otp});

  Future<RideDetailsResponse> rideDetails({required int requestId});

  Future<CancelReasonsResponse> rideCancelReasons();
  Future<CancelResponse> cancelRide(Map<String, dynamic>? params);
}
