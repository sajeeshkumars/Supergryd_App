import 'package:mynewpackage/app/modules/cab/ride_track_response.dart';

abstract class CabService {
  Future<RideTrackResponse> trackRide({required int requestId});
}
