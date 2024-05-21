import 'package:get/get.dart';

import '../controllers/restaurants_details_controller.dart';

class RestaurantsDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RestaurantsDetailsController>(
      () => RestaurantsDetailsController(),
    );
  }
}
