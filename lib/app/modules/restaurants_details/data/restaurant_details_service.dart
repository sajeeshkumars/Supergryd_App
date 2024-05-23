
import 'get_restaurant_details_response.dart';

abstract class RestaurantDetailsService {
  Future<GetRestaurantDetailsResponse> getRestaurantDetails(String restaurantId, int page, int limit);
}