import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:mynewpackage/app/modules/cab/ride_track_response.dart';
import 'package:mynewpackage/services/api_service_external.dart';


import 'cab_service.dart';


class CabRepository implements CabService {
  ApiServiceExternal apiService = Get.find();

  Future<RideTrackResponse> trackRide({required int requestId}) async {
    RideTrackResponse rideTrackResponse;
    Response response = await apiService.reqst(
        url: '/booking/track-ride?request_id=$requestId&otp=1234', method: Method.GET);
    debugPrint(response.statusCode.toString());
    try {
      debugPrint("response at try ${response.body}");
      rideTrackResponse = RideTrackResponse.fromJson(response.body);
      debugPrint("inside cab repo ${rideTrackResponse.status}");
      return rideTrackResponse;
    } catch (e, s) {
      debugPrint(s.toString());
      debugPrint(e.toString());
      return RideTrackResponse(message: "Server Error", status: 401.toString());
    }
  }

}
