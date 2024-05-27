import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:mynewpackage/app/modules/restaurants_and_dishes_listing/data/restaurant_and_dish_listing_repo.dart';
import 'package:mynewpackage/storage/storage.dart';

import '../../../../generated/assets.dart';
import '../../home/controllers/home_controller.dart';
import '../data/dish_listing_response.dart';
import '../data/restaurant_listing_request.dart' as restaurant_request;
import '../data/restaurant_listing_response.dart';

class RestaurantsAndDishesListingController extends GetxController {
  //TODO: Implement RestaurantsAndDishesListingController


  List restaurantImages = [Assets.imagesImage1,Assets.imagesImage2,Assets.imagesImage3];
  List ratings = ['4.1(10k+)','4.5(7k+)'];
  List filters = ["Veg","Egg","Non Veg"];
  List filterImages = [Assets.iconsVeg,Assets.iconsEgg,Assets.iconsNonVeg];
  List descriptions = ["Biriyani, Kebabs, South Indian,Kammanahalli/Kalyan Na...","Biriyani, Kebabs, South Indian,Kammanahalli/Kalyan Na..."];
  List<RxBool> hasOffer = [true.obs,false.obs];
  List<RxBool> isUnavailable = [false.obs,true.obs,];
  RxInt selectedCategory = 0.obs;
  RxBool isLoading = false.obs;
  RxBool isLoadingDishes = false.obs;
  AppStorage appStorage = Get.find();
  RestaurantAndDishRepository restaurantAndDishRepository = RestaurantAndDishRepository();
  RestaurantListingResult? restaurantListingResult;
  RxList<RestaurantData> restaurantList = <RestaurantData>[].obs;
  RxList<Dishes> dishList = <Dishes>[].obs;
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
      getRestaurants(initial: true);

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


  void getRestaurants({required bool initial}) async {

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
          lat: homeController.selectedLocationCoordinates['lat'],
          long: homeController.selectedLocationCoordinates['long'],
        ),
      page: page,
      limit: limit,
      userId: appStorage.getUserId(),
      serviceCategoryId:"6646f17c6538869d3399af45"
    );
    await restaurantAndDishRepository.getRestaurants(request.toJson()).then((value) {
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


        ScaffoldMessenger.of(Get.context!).showSnackBar(
            SnackBar(content: Text(value.message.toString() ?? "",),backgroundColor: Colors.red,));
      }
    });
  }

  void getDishes({required bool initial}) async {

    if (initial) {
      page = 1;
      limit = 10;
      isLoadingDishes(true);
      dishList.clear();
    }


    await restaurantAndDishRepository.getDishes(page: page, limit: limit).then((value) {
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


        ScaffoldMessenger.of(Get.context!).showSnackBar(
            SnackBar(content: Text(value.message.toString() ?? "",),backgroundColor: Colors.red,));
      }
    });
  }


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





}
