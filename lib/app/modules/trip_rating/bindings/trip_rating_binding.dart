import 'package:get/get.dart';

import '../controllers/trip_rating_controller.dart';

class TripRatingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TripRatingController>(
      () => TripRatingController(),
    );
  }
}
