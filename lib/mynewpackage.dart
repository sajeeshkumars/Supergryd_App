library mynewpackage;

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mynewpackage/app/authentication/controller/base_controller.dart';
import 'package:mynewpackage/app/modules/home/controllers/font_controller.dart';
import 'package:mynewpackage/app/modules/home/views/home_view.dart';
import 'package:mynewpackage/app/modules/restaurants_and_dishes_listing/views/restaurants_and_dishes_listing_view.dart';
import 'package:mynewpackage/app/routes/app_pages.dart';

import 'app/modules/home/controllers/home_controller.dart';
import 'app/modules/restaurants_and_dishes_listing/controllers/restaurants_and_dishes_listing_controller.dart';

export 'package:mynewpackage/app/routes/app_pages.dart';

class MyPackage extends StatelessWidget {
  final String? route;
  const MyPackage({
    super.key,
    this.route,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<FontController>();
    return Obx(() {
      log("rebuilded with newFont ${controller.fontText.value} called",
          name: "MYNEWPACKAGE");
      return Theme(
          data: ThemeData(
              fontFamily: controller.fontText.value,
              textTheme: controller.font.value),
          child: MainPage());
    });
  }
}

class MainPage extends StatefulWidget {
  final String? route;

  const MainPage({
    super.key,
    this.route,
  });

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  void initState() {
    HomeController homeController = Get.find<HomeController>();
    BaseController baseController = Get.find();

    if (baseController.isAuthenticated.isFalse &&
        baseController.authenticationLoading.isFalse) {
      homeController.authenticate(context: context);
    } else {
      homeController.createUser(mobile: "", name: "", context: context);
    }
    Get.lazyPut(() => RestaurantsAndDishesListingController());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return switch (widget.route) {
      Routes.RESTAURANTS_AND_DISHES_LISTING =>
        const RestaurantsAndDishesListingView(),
      _ => const HomeView(),
    };
  }

  String getFirstLetter(String input) {
    if (input.isNotEmpty) {
      return input.substring(0, 1);
    } else {
      return ''; // Return an empty string if the input is empty
    }
  }
}
