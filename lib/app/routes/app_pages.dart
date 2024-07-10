import 'package:get/get.dart';

import 'package:mynewpackage/app/modules/cart/bindings/cart_binding.dart';
import 'package:mynewpackage/app/modules/cart/views/cart_view.dart';

import '../modules/add_cash_to_wallet/bindings/add_cash_to_wallet_binding.dart';
import '../modules/add_cash_to_wallet/views/add_cash_to_wallet_view.dart';
import '../modules/history/bindings/history_binding.dart';
import '../modules/history/views/history_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/promo_code_listing/bindings/promo_code_listing_binding.dart';
import '../modules/promo_code_listing/views/promo_code_listing_view.dart';
import '../modules/restaurants_and_dishes_listing/bindings/restaurants_and_dishes_listing_binding.dart';
import '../modules/restaurants_and_dishes_listing/views/restaurants_and_dishes_listing_view.dart';
import '../modules/restaurants_details/bindings/restaurants_details_binding.dart';
import '../modules/restaurants_details/views/restaurants_details_view.dart';
import '../modules/trip_rating/bindings/trip_rating_binding.dart';
import '../modules/trip_rating/views/trip_rating_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
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
      page: () => AddCashToWalletView(),
      binding: AddCashToWalletBinding(),
    ),
    GetPage(
      name: _Paths.PROMO_CODE_LISTING,
      page: () => const PromoCodeListingView(),
      binding: PromoCodeListingBinding(),
    ),
    GetPage(
      name: _Paths.TRIP_RATING,
      page: () => TripRatingView(0),
      binding: TripRatingBinding(),
    ),
    GetPage(
      name: _Paths.HISTORY,
      page: () => const HistoryView(),
      binding: HistoryBinding(),
    ),
    GetPage(
      name: _Paths.CART,
      page: () => CartView(),
      binding: CartBinding(),
    ),
  ];
}
