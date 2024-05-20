import 'package:get/get.dart';

import '../controllers/restaurants_and_dishes_listing_controller.dart';

class RestaurantsAndDishesListingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RestaurantsAndDishesListingController>(
      () => RestaurantsAndDishesListingController(),
    );
  }
}
