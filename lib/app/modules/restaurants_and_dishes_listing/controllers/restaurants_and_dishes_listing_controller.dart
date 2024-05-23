import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:mynewpackage/app/modules/restaurants_and_dishes_listing/data/restaurant_and_dish_listing_repo.dart';
import 'package:mynewpackage/storage/storage.dart';

import '../../../../generated/assets.dart';
import '../data/restaurant_listing_request.dart' as restaurant_request;
import '../data/restaurant_listing_response.dart';

class RestaurantsAndDishesListingController extends GetxController {
  //TODO: Implement RestaurantsAndDishesListingController


  List restaurantImages = [Assets.imagesImage1,Assets.imagesImage2,Assets.imagesImage3];
  List nonVegImages = [Assets.imagesChickenBiriyani,Assets.imagesChickenBiriyani,Assets.imagesChickenBiriyani,Assets.imagesChickenBiriyani];
  List vegImages = [Assets.imagesMasalaDosa,Assets.imagesMasalaDosa,Assets.imagesMasalaDosa,Assets.imagesMasalaDosa];
  List eggImages = [Assets.imagesEggChilly,Assets.imagesEggChilly,Assets.imagesEggChilly,Assets.imagesEggChilly];
  List vegNames = ["Panner Biriyani","veg Biriyani","Vegitable Noodles","Masala Dosa"];
  List eggNames = ['Egg fried Rice',"Egg fried Rice","Egg fried Rice","Egg fried Rice"];
  List nonVegNames = ['Chicken Biriyani',"Chicken Biriyani","Chicken Biriyani","Chicken Biriyani"];
  List ratings = ['4.1(10k+)','4.5(7k+)'];
  List filters = ["Veg","Egg","Non Veg"];
  List filterImages = [Assets.iconsVeg,Assets.iconsEgg,Assets.iconsNonVeg];
  List descriptions = ["Biriyani, Kebabs, South Indian,Kammanahalli/Kalyan Na...","Biriyani, Kebabs, South Indian,Kammanahalli/Kalyan Na..."];
  List<RxBool> hasOffer = [true.obs,false.obs];
  List<RxBool> isUnavailable = [false.obs,true.obs,];
  RxInt selectedCategory = 0.obs;
  RxBool isLoading = false.obs;
  AppStorage appStorage = Get.find();
  RestaurantAndDishRepository restaurantAndDishRepository = RestaurantAndDishRepository();
  RestaurantListingResult? restaurantListingResult;
  RxList<RestaurantData> restaurantList = <RestaurantData>[].obs;
  RxBool isLoadingMore = false.obs;
  bool isHaveRestaurantData = false;




  int limit = 10;
  int page = 1;


  @override
  void onInit() {
    getRestaurants(initial: true);
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

    restaurant_request.RestaurantListingRequest request = restaurant_request.RestaurantListingRequest(
      location:restaurant_request.Location(lat: 13.094478,long: 77.720049),
      page: page,
      limit: limit,
      userId: appStorage.getUserId(),
      serviceCategoryId:"6646f17c6538869d3399af45"
    );
    await restaurantAndDishRepository.getRestaurants(request.toJson()).then((value) {
      if (value.status == 200) {
        if (initial) {
          restaurantList.value = value.data?.restaurantData ?? [];
          isLoading(false);
        } else {
          restaurantList.addAll(value.data?.restaurantData ?? []);
        }
        if ((value.data?.restaurantData ?? []).isNotEmpty) {
          isLoadingMore.value = false;
          isHaveRestaurantData = true;
        } else {
          isHaveRestaurantData = false;
          isLoadingMore.value = false;
        }
        // isLoading(false);
        // restaurantListingResult = value.data;

      } else {


        ScaffoldMessenger.of(Get.context!).showSnackBar(
            SnackBar(content: Text(value.message.toString() ?? "",),backgroundColor: Colors.red,));
      }
    });
  }


  bool onScrollOngoing(ScrollNotification scrollInfo) {
    if (!isLoadingMore.value &&
        scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent &&
        isHaveRestaurantData) {
      page = page + 1;
      if (isHaveRestaurantData) {
        isLoadingMore.value = true;
        getRestaurants(
          initial: false,
        );
      } else {
        isLoadingMore.value = false;
      }
    }
    return false;
  }





}
