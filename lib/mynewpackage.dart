library mynewpackage;


import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mynewpackage/app/modules/food/views/food_view.dart';
import 'package:mynewpackage/app/modules/home/views/home_view.dart';
import 'package:mynewpackage/app/routes/app_pages.dart';

import 'app/modules/home/controllers/home_controller.dart';
import 'app/modules/restaurants_and_dishes_listing/controllers/restaurants_and_dishes_listing_controller.dart';

export 'package:mynewpackage/app/routes/app_pages.dart';


class MyPackage extends StatefulWidget {
  final String? route;
  const MyPackage({super.key,  this.route});

  @override
  State<MyPackage> createState() => _MyPackageState();
}

class _MyPackageState extends State<MyPackage> {

  @override
  void initState() {
    Get.lazyPut<HomeController>(
          () => HomeController(),
    );
    Get.lazyPut(()=>RestaurantsAndDishesListingController());
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    return switch(widget.route){
      Routes.FOOD =>  const FoodView(),
      // TODO: Handle this case.
      _ => const HomeView(),
    };


      }

  }

