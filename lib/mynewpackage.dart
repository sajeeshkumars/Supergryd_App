library mynewpackage;

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mynewpackage/app/authentication/controller/base_controller.dart';
import 'package:mynewpackage/app/modules/home/controllers/font_controller.dart';
import 'package:mynewpackage/app/modules/home/views/home_view.dart';
import 'package:mynewpackage/app/modules/restaurants_and_dishes_listing/views/restaurants_and_dishes_listing_view.dart';
import 'package:mynewpackage/app/routes/app_pages.dart';
import 'package:mynewpackage/app/routes/super_gryd_routes.dart';

import 'app/modules/home/controllers/home_controller.dart';

export 'package:mynewpackage/app/routes/app_pages.dart';

class MyPackage extends StatelessWidget {
  ///[route] provide route to directly access the page.
  final SuperGrydRoutes? route;
  const MyPackage({
    super.key,
    this.route,
  });

  @override
  Widget build(BuildContext context) {
    final baseController = Get.find<BaseController>();
    var authenticationResponse2 = baseController.authenticationResponse;
    return Obx(() {
      if (baseController.isAuthenticated.isTrue) {
        final controller = Get.find<FontController>();
        if (authenticationResponse2 != null) {
          if (authenticationResponse2.data?.themes?.firstOrNull?.font != null) {
            controller.setFont(
                authenticationResponse2.data!.themes!.firstOrNull!.font!);
          }
        }
        return Theme(
            data: ThemeData(
                fontFamily: controller.fontText.value,
                textTheme: controller.font.value),
            child: MainPage(
                route: switch (route) {
              SuperGrydRoutes.cab => Routes.TRIP_RATING,
              null => null,
              SuperGrydRoutes.home => null,
              SuperGrydRoutes.restaurants =>
                Routes.RESTAURANTS_AND_DISHES_LISTING,
            }));
      } else {
        WidgetsBinding.instance.addPostFrameCallback((c) {
          log("myPackage called");

          if (Navigator.canPop(context)) {
            Navigator.of(context).pop();
          }
        });
        return Scaffold(
          body: Container(
            child: Center(child: Text("Unauthenticated")),
          ),
        );
      }
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
      // homeController.createUser(
      //     mobile: "9537212345", name: "Michael", context: context);
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    log("widget route is ${widget.route}");
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
