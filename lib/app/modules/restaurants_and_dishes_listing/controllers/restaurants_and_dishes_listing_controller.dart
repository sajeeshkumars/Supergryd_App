import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';

import '../../../../generated/assets.dart';

class RestaurantsAndDishesListingController extends GetxController {
  //TODO: Implement RestaurantsAndDishesListingController


  List restaurantImages = [Assets.imagesImage1,Assets.imagesImage2,Assets.imagesImage3,Assets.imagesImage4];
  List nonVegImages = [Assets.imagesChickenBiriyani,Assets.imagesChickenBiriyani,Assets.imagesChickenBiriyani,Assets.imagesChickenBiriyani];
  List vegImages = [Assets.imagesMasalaDosa,Assets.imagesMasalaDosa,Assets.imagesMasalaDosa,Assets.imagesMasalaDosa];
  List eggImages = [Assets.imagesEggChilly,Assets.imagesEggChilly,Assets.imagesEggChilly,Assets.imagesEggChilly];
  List restaurantNames = ['Imperio Restaurant',"Meghna Restaurant","Biriyani Express","Biriyani Hut"];
  List vegNames = ["Panner Biriyani","veg Biriyani","Vegitable Noodles","Masala Dosa"];
  List eggNames = ['Egg fried Rice',"Egg fried Rice","Egg fried Rice","Egg fried Rice"];
  List nonVegNames = ['Chicken Biriyani',"Chicken Biriyani","Chicken Biriyani","Chicken Biriyani"];
  List ratings = ['4.1(10k+)','4.5(7k+)','4(1k+)','3(11k+)'];
  List kilometers = ["1.6","1.8","2","4"];
  List filters = ["Veg","Egg","Non Veg"];
  List filterImages = [Assets.iconsVeg,Assets.iconsEgg,Assets.iconsNonVeg];
  List descriptions = ["Biriyani, Kebabs, South Indian,Kammanahalli/Kalyan Na...","Biriyani, Kebabs, South Indian,Kammanahalli/Kalyan Na...",
  "Biriyani, Kebabs, South Indian,Kammanahalli/Kalyan Na...","Biriyani, Kebabs, South Indian,Kammanahalli/Kalyan Na..."];
  List<RxBool> hasOffer = [true.obs,false.obs,false.obs,false.obs];
  List<RxBool> isUnavailable = [false.obs,true.obs,false.obs,false.obs];
  RxInt selectedCategory = 0.obs;


  @override
  void onInit() {
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

}
