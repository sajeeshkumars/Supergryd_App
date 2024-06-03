import 'package:get/get.dart';

import '../modules/add_cash_to_wallet/bindings/add_cash_to_wallet_binding.dart';
import '../modules/add_cash_to_wallet/views/add_cash_to_wallet_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/restaurants_and_dishes_listing/bindings/restaurants_and_dishes_listing_binding.dart';
import '../modules/restaurants_and_dishes_listing/views/restaurants_and_dishes_listing_view.dart';
import '../modules/restaurants_details/bindings/restaurants_details_binding.dart';
import '../modules/restaurants_details/views/restaurants_details_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.RESTAURANTS_AND_DISHES_LISTING,
      page: () => RestaurantsAndDishesListingView(),
      binding: RestaurantsAndDishesListingBinding(),
    ),
    GetPage(
      name: _Paths.RESTAURANTS_DETAILS,
      page: () => RestaurantsDetailsView(
        restaurantId: '',
        distance: 0,
      ),
      binding: RestaurantsDetailsBinding(),
    ),
    GetPage(
      name: _Paths.ADD_CASH_TO_WALLET,
      page: () =>  AddCashToWalletView(),
      binding: AddCashToWalletBinding(),
    ),
  ];
}
