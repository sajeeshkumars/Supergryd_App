import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mynewpackage/app/modules/restaurants_details/data/restaurant_details_repository.dart';

import '../data/get_restaurant_details_response.dart';

class RestaurantsDetailsController extends GetxController {
  RxBool isLoading = false.obs;
  int page = 1;
  int limit = 1;
  RxBool isLoadingMore = false.obs;
  bool haveRestaurantDetails = false;
  RxBool showMore = false.obs;
  List<String> chipTitles = [
    "Veg",
    // "Egg",
    "Non Veg",
    // "Rating",
    // "Recommended"
  ];
  List<String> chipImages = [
    "packages/mynewpackage/lib/assets/icons/veg.svg",
    // "packages/mynewpackage/lib/assets/icons/egg.svg",
    "packages/mynewpackage/lib/assets/icons/non-veg.svg",
    // "packages/mynewpackage/lib/assets/icons/Star.svg",
    // ""
  ];

  RxInt selectedFilter = 2.obs;

  RestaurantDetailsRepository restaurantDetailsRepository =
      Get.put(RestaurantDetailsRepository());
  RxList<Restaurant> restaurantDetails = <Restaurant>[].obs;

  Future<bool> getRestaurantDetails(
      {required String restaurantId, required bool initial}) async {
    if (initial) {
      page = 1;
      limit = 10;
      isLoading(true);
      restaurantDetails.clear();
    }

    await restaurantDetailsRepository.getRestaurantDetails({
      "page": page,
      "limit": limit,
      "filter": {
        "isVeg": selectedFilter.value == 0
            ? 1
            : selectedFilter.value == 1
                ? 2
                : null
      },
      "restaurant_id": restaurantId
    }).then((value) {
      if ((value.data != null) && (value.status == 200)) {
        if (initial) {
          restaurantDetails.value = value.data?.restaurant ?? [];
          isLoading(false);
        } else {
          restaurantDetails.addAll(value.data?.restaurant ?? []);
        }
        if ((value.data?.restaurant ?? []).isNotEmpty) {
          isLoadingMore.value = false;
          haveRestaurantDetails = true;
        } else {
          haveRestaurantDetails = false;
          isLoadingMore.value = false;
        }
        restaurantDetails.addAll(value.data?.restaurant ?? []);
        isLoading(false);
        return true;
      } else {
        isLoading(false);
        ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
          content: Text(
            value.message.toString(),
          ),
          backgroundColor: Colors.red,
        ));
        return false;
      }
    });
    return false;
  }

  bool onScrollOngoing(ScrollNotification scrollInfo,
      {required String restaurantId}) {
    if (!isLoadingMore.value &&
        scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent &&
        haveRestaurantDetails) {
      page = page + 1;
      if (haveRestaurantDetails) {
        isLoadingMore.value = true;
        getRestaurantDetails(restaurantId: restaurantId, initial: false);
      } else {
        isLoadingMore.value = false;
      }
    }
    return false;
  }
}
