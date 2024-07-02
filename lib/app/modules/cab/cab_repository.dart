import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:mynewpackage/app/modules/cab/model/cance_reasons_response.dart';
import 'package:mynewpackage/app/modules/cab/model/ride_details_response.dart';
import 'package:mynewpackage/app/modules/cab/ride_track_response.dart';
import 'package:mynewpackage/services/api_service.dart';
import 'package:mynewpackage/services/api_service_external.dart' as externalApi;


import 'cab_service.dart';


class CabRepository implements CabService {
  externalApi. ApiServiceExternal apiServiceExternal = Get.find();
  ApiService apiService = Get.find();

  Future<RideTrackResponse> trackRide({required int requestId,int? otp}) async {
    RideTrackResponse rideTrackResponse;
    Response response = await apiServiceExternal.reqst(
        url: '/booking/track-ride?request_id=$requestId&otp=$otp', method: externalApi.Method.GET);
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


  Future<RideDetailsResponse> rideDetails({required int requestId}) async {
    RideDetailsResponse rideDetailsResponse;
    Response response = await apiService.reqst(
        url: 'ride-hail/booking-deatils/$requestId', method: Method.GET);
    debugPrint(response.statusCode.toString());
    try {
      debugPrint("response at try ${response.body}");
      rideDetailsResponse = RideDetailsResponse.fromJson(response.body);
      return rideDetailsResponse;
    } catch (e, s) {
      debugPrint(s.toString());
      debugPrint(e.toString());
      return RideDetailsResponse(message: "Server Error", status: 401);
    }
  }

  Future<CancelReasonsResponse> rideCancelReasons() async {
    CancelReasonsResponse cancelReasonsResponse;
    Response response = await apiServiceExternal.reqst(
        url: '/booking/cancel/reasons/rider', method: externalApi.Method.GET);
    debugPrint(response.statusCode.toString());
    try {
      debugPrint("response at try ${response.body}");
      cancelReasonsResponse = CancelReasonsResponse.fromJson(response.body);
      return cancelReasonsResponse;
    } catch (e, s) {
      debugPrint(s.toString());
      debugPrint(e.toString());
      return CancelReasonsResponse();
    }
  }

}
