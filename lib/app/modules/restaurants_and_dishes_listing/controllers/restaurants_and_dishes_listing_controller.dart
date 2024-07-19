import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mynewpackage/app/modules/restaurants_and_dishes_listing/data/dish_listing_request.dart';
import 'package:mynewpackage/app/modules/restaurants_and_dishes_listing/data/restaurant_and_dish_listing_repo.dart';
import 'package:mynewpackage/constants.dart';

import '../../../../generated/assets.dart';
import '../../home/controllers/home_controller.dart';
import '../data/dish_listing_response.dart';
import '../data/restaurant_listing_request.dart' as restaurant_request;
import '../data/restaurant_listing_response.dart';

class RestaurantsAndDishesListingController extends GetxController {
  List filters = ["Veg", "Non Veg"];
  List filterImages = [
    Assets.iconsVeg,
    // Assets.iconsEgg,
    Assets.iconsNonVeg
  ];
  RxInt selectedCategory = 3.obs;
  RxBool isSelected = false.obs;
  RxBool isLoading = false.obs;
  RxBool isLoadingDishes = false.obs;

  // AppStorage appStorage = Get.find();
  RestaurantAndDishRepository restaurantAndDishRepository =
      RestaurantAndDishRepository();
  RestaurantListingResult? restaurantListingResult;
  DishListingRequest? dishListingRequest;
  RxList<RestaurantData> restaurantList = <RestaurantData>[].obs;
  RxList<Dishes> dishList = <Dishes>[].obs;

  // RxList<Dishes> dishListForApi = <Dishes>[].obs;
  RxBool isRestaurantsLoadingMore = false.obs;
  RxBool isDishesLoadingMore = false.obs;
  bool isHaveRestaurantData = false;
  bool isHaveDishes = false;
  final HomeController homeController = Get.find();

  int limit = 10;
  int page = 1;

  @override
  void onInit() {
    // WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    getRestaurants(
      initial: true,
    );

    // });
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> getRestaurants(
      {required bool initial, BuildContext? context}) async {
    debugPrint("userId ${Constants.userId}");
    if (initial) {
      page = 1;
      limit = 10;
      isLoading(true);
      restaurantList.clear();
    }

    restaurant_request.RestaurantListingRequest request =
        restaurant_request.RestaurantListingRequest(
            location: homeController.selectedLocationCoordinates.isEmpty
                ? restaurant_request.Location(lat: 13.094478, long: 77.720049)
                : restaurant_request.Location(
                    lat: double.parse(homeController
                        .selectedLocationCoordinates['lat']
                        .toString()),
                    long: double.parse(homeController
                        .selectedLocationCoordinates['long']
                        .toString()),
                  ),
            page: page,
            limit: limit,
            // userId: appStorage.getUserId(),
            userId: Constants.userId,
            serviceCategoryId: '6646f17c6538869d3399af45');
    await restaurantAndDishRepository
        .getRestaurants(request.toJson())
        .then((value) {
      if (value.status == 200) {
        getDishes(initial: true);

        if (initial) {
          restaurantList.value = value.data?.restaurantData ?? [];
          debugPrint("restaurant list ${restaurantList.length}");
          isLoading(false);
        } else {
          restaurantList.addAll(value.data?.restaurantData ?? []);
        }
        if ((value.data?.restaurantData ?? []).isNotEmpty) {
          isRestaurantsLoadingMore.value = false;
          isHaveRestaurantData = true;
        } else {
          isHaveRestaurantData = false;
          isRestaurantsLoadingMore.value = false;
        }
        // isLoading(false);
        // restaurantListingResult = value.data;
      } else {
        isLoading(false);

        ScaffoldMessenger.of(context!).showSnackBar(SnackBar(
          content: Text(
            value.message.toString(),
          ),
          backgroundColor: Colors.red,
        ));
      }
    });
  }

  Future<void> getDishes({required bool initial, BuildContext? context}) async {
    if (initial) {
      page = 1;
      limit = 10;
      isLoadingDishes(true);
      dishList.clear();
    }

    await restaurantAndDishRepository.getDishes({
      "location": homeController.selectedLocationCoordinates.isEmpty
          ? {"lat": 13.094478, "long": 77.720049}
          : {
              "lat": homeController.selectedLocationCoordinates['lat'],
              "long": homeController.selectedLocationCoordinates['long']
            },
      // "user_id": appStorage.getUserId(),
      "user_id": Constants.userId,
      "page": page,
      "limit": limit,
      "service_category_id": "6646f17c6538869d3399af45",
      "filter": {
        "isVeg": selectedCategory.value == 0
            ? 1
            : selectedCategory.value == 1
                ? 2
                : null
      }
    }).then((value) {
      if (value.status == 200) {
        if (initial) {
          dishList.value = value.data?.dishes ?? [];

          isLoadingDishes(false);
        } else {
          dishList.addAll(value.data?.dishes ?? []);
        }
        if ((value.data?.dishes ?? []).isNotEmpty) {
          isDishesLoadingMore.value = false;
          isHaveDishes = true;
        } else {
          isHaveDishes = false;
          isDishesLoadingMore.value = false;
        }
      } else {
        isLoadingDishes(false);

        ScaffoldMessenger.of(context!).showSnackBar(SnackBar(
          content: Text(
            value.message.toString(),
          ),
          backgroundColor: Colors.red,
        ));
      }
    });
  }

  // void getDishes({required bool initial}) async {
  //   if (initial) {
  //     page = 1;
  //     isLoadingDishes(true);
  //     dishListForApi.clear();
  //     dishList.clear(); // Clear the display list when loading new data
  //   }
  //
  //   await restaurantAndDishRepository.getDishes({
  //     "location": homeController.selectedLocationCoordinates.isEmpty
  //         ? {"lat": 13.094478, "long": 77.720049}
  //         : {
  //       "lat": homeController.selectedLocationCoordinates['lat'],
  //       "long": homeController.selectedLocationCoordinates['long']
  //     },
  //     "user_id": Constants.userId,
  //     "page": page,
  //     "limit": limit,
  //     "service_category_id": "6646f17c6538869d3399af45",
  //     "filter": {"isVeg": selectedCategory.value == 0 ? 1 : selectedCategory.value == 1 ? 2 : null}
  //   }).then((value) {
  //     if (value.status == 200) {
  //       if (initial) {
  //         dishListForApi.value = value.data?.dishes ?? [];
  //         isLoadingDishes(false);
  //       } else {
  //         dishListForApi.addAll(value.data?.dishes ?? []);
  //         isLoadingDishes(false);
  //
  //       }
  //
  //       dishFilter();
  //
  //       if ((value.data?.dishes ?? []).isNotEmpty) {
  //         isDishesLoadingMore.value = false;
  //         isHaveDishes = true;
  //       } else {
  //         isHaveDishes = false;
  //         isDishesLoadingMore.value = false;
  //       }
  //     } else {
  //       isLoadingDishes(false);
  //
  //       ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(
  //         content: Text(value.message.toString() ?? ""),
  //         backgroundColor: Colors.red,
  //       ));
  //     }
  //   });
  // }

  bool onScrollOngoing(ScrollNotification scrollInfo) {
    if (!isRestaurantsLoadingMore.value &&
        scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent &&
        isHaveRestaurantData) {
      page = page + 1;
      if (isHaveRestaurantData) {
        isRestaurantsLoadingMore.value = true;
        getRestaurants(
          initial: false,
        );
      } else {
        isRestaurantsLoadingMore.value = false;
      }
    }
    return false;
  }

  bool onScrollDishes(ScrollNotification scrollInfo) {
    if (!isDishesLoadingMore.value &&
        scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent &&
        isHaveDishes) {
      page = page + 1;
      if (isHaveDishes) {
        isDishesLoadingMore.value = true;
        getDishes(initial: false);
      } else {
        isDishesLoadingMore.value = false;
      }
    }
    return false;
  }

// bool onScrollDishes(ScrollNotification scrollInfo) {
//   if (!isDishesLoadingMore.value &&
//       scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent &&
//       isHaveDishes) {
//     page++;
//     if (isHaveDishes) {
//       isDishesLoadingMore.value = true;
//       getDishes(initial: false);
//     } else {
//       isDishesLoadingMore.value = false;
//     }
//   }
//   return false;
// }

// void dishFilter() {
//   debugPrint("inside filter");
//   List<Dishes> filteredList = [];
//
//   if (selectedCategory.value == 0) {
//     debugPrint("selected category 0");
//     // Filter for vegetarian dishes
//     filteredList = dishListForApi.where((dish) => dish.storeProducts?.isVeg == 1).toList();
//     debugPrint("selected category 0 count ${filteredList.length}");
//
//   } else if (selectedCategory.value == 1) {
//     debugPrint("selected category 1");
//
//     // Filter for non-vegetarian dishes
//     filteredList = dishListForApi.where((dish) => dish.storeProducts?.isVeg == 2).toList();
//     debugPrint("selected category 1 count ${filteredList.length}");
//   } else {
//     // No filter, keep all dishes
//     filteredList = List.from(dishListForApi);
//   }
//
//   dishList.clear();
//   dishList.addAll(filteredList);
//   debugPrint("inside all ${dishList.length}");
// }
}
