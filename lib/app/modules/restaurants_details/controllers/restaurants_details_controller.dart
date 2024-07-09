import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mynewpackage/app/modules/restaurants_details/data/restaurant_details_repository.dart';

import '../data/get_restaurant_details_response.dart';

class RestaurantsDetailsController extends GetxController {
  RxBool isLoading = false.obs;
  int page = 0;
  int limit = 0;
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

  RxInt selectedFilter = 3.obs;
  RxBool isSelected = false.obs;
  RxString searchQuery = ''.obs;


  RestaurantDetailsRepository restaurantDetailsRepository =
  Get.put(RestaurantDetailsRepository());
  RxList<Restaurant> restaurantDishList = <Restaurant>[].obs;
  RxList<Restaurant> restaurantDishListForApi = <Restaurant>[].obs;

  Future<bool> getRestaurantDetails(
      {required String restaurantId, required bool initial,BuildContext? context}) async {
    // if (initial) {
    //   page = 0;
    //   limit = 0;
      isLoading(true);
    //   restaurantDetails.clear();
    // }
      restaurantDishListForApi.clear();


      await restaurantDetailsRepository.getRestaurantDetails({
      "page": page,
      "limit": limit,
      "filter": {
        "isVeg": null
        // selectedFilter.value == 0
        //     ? 1
        //     : selectedFilter.value == 1
        //         ? 2
        //         : null
      },
      "restaurant_id": restaurantId
    }).then((value) {
      if ((value.data != null) && (value.status == 200)) {

        // if (initial) {
        //
        //   restaurantDetails.value = value.data?.restaurant ?? [];
        //   isLoading(false);
        // }
        // else {
        restaurantDishListForApi.addAll(value.data?.restaurant ?? []);
        restaurantDishFilter();
        // }
        // if ((value.data?.restaurant ?? []).isNotEmpty) {
        //   isLoadingMore.value = false;
        //   haveRestaurantDetails = true;
        // } else {
        //   haveRestaurantDetails = false;
        //   isLoadingMore.value = false;
        // }
        // restaurantDetails.addAll(value.data?.restaurant ?? []);
        isLoading(false);
        return true;
      } else {
        isLoading(false);
        ScaffoldMessenger.of(context!).showSnackBar(SnackBar(
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

  // void restaurantDishFilter(){
  //     List<Restaurant> filteredList = [];
  //
  //     if (selectedFilter.value == 0) {
  //       debugPrint("selected category 0");
  //       // Filter for vegetarian dishes
  //       filteredList = restaurantDishListForApi.where((dish) => dish.isVeg == 1).toList();
  //       debugPrint("selected category 0 count ${filteredList.length}");
  //
  //     } else if (selectedFilter.value == 1) {
  //       debugPrint("selected category 1");
  //
  //       // Filter for non-vegetarian dishes
  //       filteredList = restaurantDishListForApi.where((dish) => dish.isVeg == 2).toList();
  //       debugPrint("selected category 1 count ${filteredList.length}");
  //     } else {
  //       // No filter, keep all dishes
  //       filteredList = List.from(restaurantDishListForApi);
  //     }
  //
  //     restaurantDishList.clear();
  //     restaurantDishList.addAll(filteredList);
  //     debugPrint("inside all ${restaurantDishList.length}");
  //   }


  void restaurantDishFilter() {
    List<Restaurant> filteredList = [];

    // Apply the selected filter
    if (selectedFilter.value == 0) {
      filteredList =
          restaurantDishListForApi.where((dish) => dish.isVeg == 1).toList();
    } else if (selectedFilter.value == 1) {
      filteredList =
          restaurantDishListForApi.where((dish) => dish.isVeg == 2).toList();
    } else {
      filteredList = List.from(restaurantDishListForApi);
    }

    // Apply the search filter
    if (searchQuery.value.isNotEmpty) {
      String normalizedSearchQuery = searchQuery.value.toLowerCase().trim();
      filteredList = filteredList.where((dish) {
        String dishName = dish.name?.toLowerCase().trim() ?? '';
        return dishName.contains(normalizedSearchQuery);
      }).toList();
    }

    restaurantDishList.clear();
    restaurantDishList.addAll(filteredList);
    debugPrint("Filtered list length: ${restaurantDishList.length}");
  }

}


// bool onScrollOngoing(ScrollNotification scrollInfo,
  //     {required String restaurantId}) {
  //   if (!isLoadingMore.value &&
  //       scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent &&
  //       haveRestaurantDetails) {
  //     page = page + 1;
  //     if (haveRestaurantDetails) {
  //       isLoadingMore.value = true;
  //       getRestaurantDetails(restaurantId: restaurantId, initial: false);
  //     } else {
  //       isLoadingMore.value = false;
  //     }
  //   }
  //   return false;
  // }

