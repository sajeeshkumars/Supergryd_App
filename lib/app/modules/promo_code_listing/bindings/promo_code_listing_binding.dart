import 'package:get/get.dart';

import '../controllers/promo_code_listing_controller.dart';

class PromoCodeListingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PromoCodeListingController>(
      () => PromoCodeListingController(),
    );
  }
}
