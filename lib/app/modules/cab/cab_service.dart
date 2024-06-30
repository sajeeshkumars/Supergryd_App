import 'package:mynewpackage/app/modules/cab/model/ride_details_response.dart';
import 'package:mynewpackage/app/modules/cab/ride_track_response.dart';

abstract class CabService {
  Future<RideTrackResponse> trackRide({required int requestId,int? otp});
  Future<RideDetailsResponse> rideDetails({required int requestId});
}
