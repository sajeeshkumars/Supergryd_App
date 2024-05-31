library mynewpackage;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mynewpackage/app/modules/home/views/home_view.dart';
import 'package:mynewpackage/app/modules/restaurants_and_dishes_listing/views/restaurants_and_dishes_listing_view.dart';
import 'package:mynewpackage/app/routes/app_pages.dart';
import 'package:mynewpackage/constants.dart';

import 'app/modules/home/controllers/home_controller.dart';
import 'app/modules/restaurants_and_dishes_listing/controllers/restaurants_and_dishes_listing_controller.dart';
import 'dependecy.dart';

export 'package:mynewpackage/app/routes/app_pages.dart';

class MyPackage extends StatefulWidget {
  final String? route;
  final String clientId;
  final String clientSecrete;
  final String name;
  final String mobile;

  const MyPackage(
      {super.key,
      this.route,
      required this.clientId,
      required this.clientSecrete,
        required this.name,
        required this.mobile
      });

  @override
  State<MyPackage> createState() => _MyPackageState();
}

class _MyPackageState extends State<MyPackage> {
  @override
  void initState() {
    DependencyCreator.init();

    HomeController homeController = Get.put(HomeController());
    Constants.name = widget.name;
    homeController.authenticate(
        clientId: widget.clientId, clientSecrete: widget.clientSecrete,name:widget.name,mobile:widget.mobile);

    debugPrint("clientid ${widget.clientId}");

    Get.lazyPut(() => RestaurantsAndDishesListingController());
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return switch (widget.route) {
      Routes.RESTAURANTS_AND_DISHES_LISTING =>
        RestaurantsAndDishesListingView(),
      _ => const HomeView(),
    };
  }
}
