import 'package:get/get.dart';
import 'package:mynewpackage/app/modules/cart/controllers/cart_controller.dart';
import 'package:mynewpackage/app/modules/history/controllers/history_controller.dart';
import 'package:mynewpackage/app/modules/home/controllers/home_controller.dart';
import 'package:mynewpackage/app/modules/restaurants_and_dishes_listing/controllers/restaurants_and_dishes_listing_controller.dart';

import 'app/modules/add_cash_to_wallet/controllers/add_cash_to_wallet_controller.dart';
import 'app/modules/home/controllers/font_controller.dart';
import 'app/modules/promo_code_listing/controllers/promo_code_listing_controller.dart';

class DependencyCreator {
  static init() {
    final controller = Get.put(FontController());
    Get.put(HomeController());
    Get.lazyPut<CartController>(() => CartController(), fenix: true);

    controller.registerFontsFromWeb();
    Get.lazyPut<RestaurantsAndDishesListingController>(
      () => RestaurantsAndDishesListingController(),
    );
    Get.lazyPut<AddCashToWalletController>(() => AddCashToWalletController(),
        fenix: true);
    Get.lazyPut<PromoCodeListingController>(() => PromoCodeListingController(),
        fenix: true);
    Get.lazyPut<HistoryController>(() => HistoryController(), fenix: true);

    // Get.lazyPut<AppStorage>(() => AppStorage(), fenix: true);
  }
}
