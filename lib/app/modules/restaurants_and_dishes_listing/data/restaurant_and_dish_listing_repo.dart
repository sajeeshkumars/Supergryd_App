import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:mynewpackage/app/modules/restaurants_and_dishes_listing/data/restaurant_and_dish_listing_service.dart';
import 'package:mynewpackage/app/modules/restaurants_and_dishes_listing/data/restaurant_listing_response.dart';

import '../../../../services/api_service.dart';
import 'dish_listing_response.dart';

class RestaurantAndDishRepository implements RestaurantService {
  ApiService apiService = Get.find();

  @override
  Future<RestaurantListingResponse> getRestaurants(
      Map<String, dynamic>? params) async {
    RestaurantListingResponse restaurantListingResponse;
    Response response = await apiService.reqst(
        url: 'food/get-near-by-restaurant', params: params);
    debugPrint(response.statusCode.toString());
    try {
      restaurantListingResponse =
          RestaurantListingResponse.fromJson(response.body);
      debugPrint('inside repo ${restaurantListingResponse.status}');
      return restaurantListingResponse;
    } catch (e, s) {
      debugPrint(s.toString());
      return RestaurantListingResponse(message: "Server Error", status: 401);
    }
  }

  @override
  Future<DishListingResponse> getDishes(Map<String, dynamic>? params) async {
    DishListingResponse dishListingResponse;
    Response response = await apiService.reqst(
        url: 'food/get-all-restaurant-dishes', params: params);
    debugPrint(response.statusCode.toString());
    try {
      dishListingResponse = DishListingResponse.fromJson(response.body);
      return dishListingResponse;
    } catch (e, s) {
      debugPrint(e.toString()+s.toString());
      return DishListingResponse(message: "Server Error", status: 401);
    }
  }
}
