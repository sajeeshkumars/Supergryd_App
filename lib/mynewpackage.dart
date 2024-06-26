library mynewpackage;

import 'dart:convert';
import 'dart:developer';

import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mynewpackage/app/modules/home/controllers/font_controller.dart';
import 'package:mynewpackage/app/modules/home/views/home_view.dart';
import 'package:mynewpackage/app/modules/restaurants_and_dishes_listing/views/restaurants_and_dishes_listing_view.dart';
import 'package:mynewpackage/app/routes/app_pages.dart';
import 'package:mynewpackage/app_colors.dart';
import 'package:mynewpackage/constants.dart';

import 'app/modules/home/controllers/home_controller.dart';
import 'app/modules/restaurants_and_dishes_listing/controllers/restaurants_and_dishes_listing_controller.dart';
import 'dependecy.dart';

export 'package:mynewpackage/app/routes/app_pages.dart';

class MyPackage extends StatelessWidget {
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
      required this.mobile});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<FontController>();
    return Obx(() {
      log("rebuilded with newFont ${controller.fontText.value} called",
          name: "MYNEWPACKAGE");
      // return MainPage(
      //     clientId: clientId,
      //     clientSecrete: clientSecrete,
      //     name: name,
      //     mobile: mobile);
      return Theme(
          data: ThemeData(
              fontFamily: controller.fontText.value,
              textTheme: controller.font.value),
          child: MainPage(
              clientId: clientId,
              clientSecrete: clientSecrete,
              name: name,
              mobile: mobile));
    });
  }
}

class MainPage extends StatefulWidget {
  final String? route;
  final String clientId;
  final String clientSecrete;
  final String name;
  final String mobile;

  const MainPage(
      {super.key,
      this.route,
      required this.clientId,
      required this.clientSecrete,
      required this.name,
      required this.mobile});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  void initState() {
    var apiKey = widget.clientId;
    var apiSecret = widget.clientSecrete;
    debugPrint("initial secrete $apiSecret");

    String generateSignature(String apiSecret, String key) {
      // Convert secret and key to bytes
      final secretBytes = utf8.encode(apiSecret);
      final keyBytes = utf8.encode(key);

      // Create HMAC-SHA256 signer using the secret
      final hmacSha256 = Hmac(sha256, secretBytes);

      // Get the signature and encode in Base64
      final signature = hmacSha256.convert(keyBytes);
      return base64.encode(signature.bytes);
    }
    var now = DateTime.now().millisecondsSinceEpoch;
    var utz = (now / 1000 / 300).floor();
    var key = '$utz:$apiSecret';


    var signature = generateSignature(apiSecret, key);

    // var now = DateTime.now().millisecondsSinceEpoch;
    // var utz = (now ~/ 1000 ~/ 300).toInt();
    // var key = '$utz:$apiSecret';
    //
    // var hmacSha256 = Hmac(sha256, utf8.encode(apiSecret));
    // var signature = base64Encode(hmacSha256.convert(utf8.encode(key)).bytes);
    //
    Constants.key = apiKey;
    Constants.secrete = signature;
    // Constants.secrete = apiSecret;

    debugPrint("api key ${Constants.key}");
    debugPrint("api secrete ${Constants.secrete}");

    DependencyCreator.init();
    HomeController homeController = Get.put(HomeController());
    Constants.name = widget.name;
    Constants.nameFirstLetter = getFirstLetter(widget.name).toUpperCase();
    debugPrint("name letter ${Constants.nameFirstLetter}");

      homeController.authenticate(
          clientId: widget.clientId,
          clientSecrete: widget.clientSecrete,
          name: widget.name,
          mobile: widget.mobile,
          context: context);
    debugPrint("primary color ${AppColors.primaryColor}");
    debugPrint("clientid ${widget.clientId}");
    Get.lazyPut(() => RestaurantsAndDishesListingController());
    // TODO: implement initState
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
