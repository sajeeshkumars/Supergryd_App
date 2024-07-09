import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:mynewpackage/app/modules/home/data/home_service.dart';
import 'package:mynewpackage/app/modules/home/data/models/ride_estimation_response.dart';

import '../../../../services/api_service.dart';
import 'models/request_ride_response.dart';
import 'models/service_category_response.dart';

class HomeRepository implements HomeService {
  ApiService apiService = Get.find();

  @override
  Future<ServiceCategoryResponse> getServiceList() async {
    ServiceCategoryResponse serviceCategoryResponse;
    Response response = await apiService.reqst(
        url: 'sdk/get-host-servicecategories', method: Method.GET);
    debugPrint(response.statusCode.toString());
    try {
      serviceCategoryResponse = ServiceCategoryResponse.fromJson(response.body);
      debugPrint("inside repo ${serviceCategoryResponse.status}");
      return serviceCategoryResponse;
    } catch (e, s) {
      debugPrint(s.toString());
      return ServiceCategoryResponse(message: "Server Error", status: 401);
    }
  }

  @override
  Future<RideEstimationResponse> getRideEstimation(
      Map<String, dynamic>? params) async {
    RideEstimationResponse rideEstimationResponse;
    Response response = await apiService.reqst(
        url: 'ride-hail/ride-request-price-estimate', params: params);
    log("response ${response.body}", name: "GETRIDEESTIMATION");
    try {
      rideEstimationResponse = RideEstimationResponse.fromJson(response.body);
      debugPrint('inside repo ${rideEstimationResponse.toJson()}');
      return rideEstimationResponse;
    } catch (e, s) {
      debugPrint(s.toString());
      return RideEstimationResponse(message: 'Server Error', status: 401);
    }
  }

  @override
  Future<RequestRideResponse> requestRide(Map<String, dynamic>? params) async {
    RequestRideResponse requestRideResponse;
    Response response =
        await apiService.reqst(url: 'ride-hail/ride-booking', params: params);
    debugPrint(response.statusCode.toString());
    try {
      requestRideResponse = RequestRideResponse.fromJson(response.body);
      debugPrint('inside repo ${requestRideResponse.status}');
      return requestRideResponse;
    } catch (e, s) {
      debugPrint(s.toString());
      debugPrint(e.toString());
      return RequestRideResponse(message: 'Server Error', status: 401);
    }
  }
}
