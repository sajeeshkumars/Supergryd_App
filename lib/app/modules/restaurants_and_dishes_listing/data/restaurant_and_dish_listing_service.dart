

import 'package:mynewpackage/app/modules/restaurants_and_dishes_listing/data/restaurant_listing_response.dart';

import 'dish_listing_response.dart';


abstract class RestaurantService {
  Future<RestaurantListingResponse> getRestaurants(Map<String, dynamic>? params);
  Future<DishListingResponse> getDishes(Map<String, dynamic>? params);


}
