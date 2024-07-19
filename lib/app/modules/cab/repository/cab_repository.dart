import 'dart:developer';

import 'package:get/get.dart';
import 'package:mynewpackage/app/modules/cab/model/cancel_response.dart';
import 'package:mynewpackage/app/modules/cab/model/ride_track_response.dart';
import 'package:mynewpackage/services/api_service.dart';
import 'package:mynewpackage/services/config.dart';

// import 'package:mynewpackage/services/api_service_external.dart' as externalApi;

import '../model/Ride_details_response.dart';
import '../model/cancel_reasons_response.dart';
import '../service/cab_service.dart';

class CabRepository implements CabService {
  // externalApi.ApiServiceExternal apiServiceExternal = Get.find();
  ApiService apiService = Get.find();

  Future<RideTrackResponse> trackRide(
      {required int requestId, int? otp}) async {
    RideTrackResponse rideTrackResponse;
    Response response = await apiService.reqst(
        urlType: UrlType.cab,
        url: '/booking/track-ride?request_id=$requestId&otp=$otp',
        method: Method.GET);
    log("trackRide ${response.statusCode}", name: "CABREPOSITORY");

    try {
      rideTrackResponse = RideTrackResponse.fromJson(response.body);

      return rideTrackResponse;
    } catch (e, s) {
      log("trackRide Exception:$e,stack:$s", name: "CABREPOSITORY");

      return RideTrackResponse(message: "Server Error", status: 401.toString());
    }
  }

  Future<RideDetailsResponse> rideDetails({required int requestId}) async {
    RideDetailsResponse rideDetailsResponse;
    Response response = await apiService.reqst(
        url: 'ride-hail/booking-deatils/$requestId', method: Method.GET);
    log("rideDetails ${response.statusCode}", name: "CABREPOSITORY");

    try {
      rideDetailsResponse = RideDetailsResponse.fromJson(response.body);
      return rideDetailsResponse;
    } catch (e, s) {
      log("rideDetails Exception:$e,stack:$s", name: "CABREPOSITORY");

      return RideDetailsResponse(message: "Server Error", status: 401);
    }
  }

  Future<CancelReasonsResponse> rideCancelReasons() async {
    CancelReasonsResponse cancelReasonsResponse;
    Response response = await apiService.reqst(
        urlType: UrlType.cab,
        url: 'uber/v1/booking/cancel/reasons/rider',
        method: Method.GET);
    log("rideCancelReasons ${response.statusCode}", name: "CABREPOSITORY");

    try {
      cancelReasonsResponse = CancelReasonsResponse.fromJson(response.body);
      return cancelReasonsResponse;
    } catch (e, s) {
      log("rideCancelReasons exception occurred:$e,$s", name: "CABREPOSITORY");
      return CancelReasonsResponse();
    }
  }

  Future<CancelResponse> cancelRide(Map<String, dynamic>? params) async {
    CancelResponse cancelResponse;
    Response response =
        await apiService.reqst(url: 'ride-hail/ride-cancel', params: params);
    log("cancelRide ${response.statusCode}", name: "CABREPOSITORY");

    try {
      cancelResponse = CancelResponse.fromJson(response.body);
      return cancelResponse;
    } catch (e, s) {
      log("cancelRide Exception:$e,stack:$s", name: "CABREPOSITORY");

      return CancelResponse();
    }
  }
}
