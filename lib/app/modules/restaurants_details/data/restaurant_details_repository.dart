import 'dart:developer';

import 'package:get/get.dart';
import 'package:mynewpackage/app/modules/restaurants_details/data/restaurant_details_service.dart';

import 'package:mynewpackage/services/api_service.dart';

import 'get_restaurant_details_response.dart';

class RestaurantDetailsRepository implements RestaurantDetailsService {
  ApiService apiService = Get.find();

  @override
  Future<GetRestaurantDetailsResponse> getRestaurantDetails(Map<String, dynamic>? params) async {
    GetRestaurantDetailsResponse getRestaurantDetailsResponse;
    Response response = await apiService.reqst(
        url: 'food/get-restaurant-by-id',params: params);
    log(response.statusCode.toString());
    try {
      getRestaurantDetailsResponse = GetRestaurantDetailsResponse.fromJson(response.body);
      log("inside repo ${getRestaurantDetailsResponse.status}");
      return getRestaurantDetailsResponse;
    } catch (e, s) {
      log(s.toString());
      return GetRestaurantDetailsResponse(message: "Server Error", status: 401);
    }
  }
}