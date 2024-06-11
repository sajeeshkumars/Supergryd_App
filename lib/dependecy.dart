import 'package:get/get.dart';
import 'package:mynewpackage/app/modules/add_cash_to_wallet/controllers/add_cash_to_wallet_controller.dart';
import 'package:mynewpackage/app/modules/home/controllers/color_controller.dart';
import 'package:mynewpackage/app/modules/restaurants_and_dishes_listing/controllers/restaurants_and_dishes_listing_controller.dart';
import 'package:mynewpackage/services/api_service.dart';
import 'package:mynewpackage/services/config.dart';

import 'app/authentication/authentication_repo.dart';
import 'app/authentication/authentication_service.dart';
import 'app/modules/home/controllers/home_controller.dart';
import 'app/modules/promo_code_listing/controllers/promo_code_listing_controller.dart';

class DependencyCreator {
  static init() {
    Get.lazyPut<ApiService>(
          () => ApiService(
          baseUrl: ConfigEnvironments.getEnvironments()['url'] ?? ""),
    );

    Get.lazyPut<HomeController>(
          () => HomeController(),fenix: true
    );

    Get.lazyPut<RestaurantsAndDishesListingController>(()=>RestaurantsAndDishesListingController(),fenix: true);
    Get.lazyPut<AddCashToWalletController>(()=>AddCashToWalletController(),fenix: true);
    Get.lazyPut<ColorController>(()=>ColorController(),fenix: true);
    Get.lazyPut<PromoCodeListingController>(()=>PromoCodeListingController(),fenix: true);


    Get.lazyPut<AuthService>(() => AuthRepository(), fenix: true);
    // Get.lazyPut<AppStorage>(() => AppStorage(), fenix: true);

  }
}
