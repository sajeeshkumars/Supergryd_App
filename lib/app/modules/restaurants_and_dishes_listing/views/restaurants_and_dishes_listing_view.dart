import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:mynewpackage/app/core/utility.dart';
import 'package:mynewpackage/app/modules/home/controllers/home_controller.dart';
import 'package:mynewpackage/app/modules/restaurants_details/views/restaurants_details_view.dart';

import '../../../../app_colors.dart';
import '../../../../generated/assets.dart';
import '../../../../widgets/common_Image_view.dart';
import '../../restaurants_details/data/get_restaurant_details_response.dart';
import '../controllers/restaurants_and_dishes_listing_controller.dart';
import '../data/dish_listing_response.dart';

class RestaurantsAndDishesListingView extends StatelessWidget {
  RestaurantsAndDishesListingView({super.key});

  final HomeController homeController = Get.put(HomeController());

  final RestaurantsAndDishesListingController controller =
      Get.put(RestaurantsAndDishesListingController());

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: AppColors.backgroundColor,
        appBar: AppBar(
          backgroundColor: AppColors.backgroundColor,
          title: InkWell(
            onTap: () {
             homeController.showAddressSelectionBottomSheet(context: context);
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      'Your Location',
                      style: TextStyle(
                          fontSize: 14, color: AppColors.textLightColor),
                    ),
                    const Icon(
                      Icons.keyboard_arrow_down_sharp,
                      size: 14,
                    )
                  ],
                ),
                Obx(() {
                  return Row(
                    children: [
                      CommonImageView(
                          svgPath:
                              "packages/mynewpackage/${Assets.iconsLocation}"),
                      const SizedBox(
                        width: 5,
                      ),
                      Expanded(
                          child: Text(homeController.address.value,
                              style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  overflow: TextOverflow.ellipsis))),
                    ],
                  );
                }),
              ],
            ),
          ),
          centerTitle: true,
          bottom: TabBar(
            splashFactory: NoSplash.splashFactory,
            indicatorColor: AppColors.primaryColor,
            labelColor: AppColors.primaryColor,
            labelStyle:
                const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            tabs: const <Widget>[
              Tab(
                text: "Restaurants",
              ),
              Tab(
                text: "Dishes",
              ),
            ],
          ),
        ),
        body: Obx(() {
          return controller.isLoading.value
              ?  Center(child: CircularProgressIndicator(color: AppColors.primaryColor,))
              : controller.restaurantList.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CommonImageView(
                            svgPath:
                                'packages/mynewpackage/lib/assets/icons/not_available_at_location.svg',
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          const Text(
                            "Hi Sajeesh,",
                            style: TextStyle(
                                fontWeight: FontWeight.w700, fontSize: 20),
                          ),
                          const Text(
                            "Currently we are not serviceable in your location.\nWe are on a process of increasing our service area.",
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 14),
                          ),
                          const Text(
                            "We will notify you once we start our service in your area",
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                                color: Color(0xff2C9649)),
                          ),
                        ],
                      ),
                    )
                  : TabBarView(
                      children: <Widget>[
                        NotificationListener<ScrollNotification>(
                            onNotification: controller.onScrollOngoing,
                            child: RestaurantList(controller: controller)),
                        Column(
                          children: [
                            Row(
                              children: List.generate(
                                controller.filterImages.length,
                                (index) => Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: InkWell(
                                    splashFactory: NoSplash.splashFactory,
                                    onTap: () {
                                      controller.selectedCategory.value = index;
                                    },
                                    child: Obx(() {
                                      return Container(
                                        height: 35,
                                        width: 85,
                                        decoration: BoxDecoration(
                                          color: controller
                                                      .selectedCategory.value ==
                                                  index
                                              ? AppColors.primaryColor
                                              : AppColors.white,
                                          borderRadius: const BorderRadius.all(
                                            Radius.circular(40),
                                          ),
                                          border: Border.all(
                                            color: AppColors.borderColor,
                                            style: BorderStyle.solid,
                                          ),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 5, vertical: 5),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              controller.selectedCategory
                                                          .value ==
                                                      index
                                                  ? CommonImageView(
                                                      svgPath:
                                                          "packages/mynewpackage/${controller.filterImages[index]}",
                                                      color: AppColors.white,
                                                    )
                                                  : CommonImageView(
                                                      svgPath:
                                                          "packages/mynewpackage/${controller.filterImages[index]}"),
                                              Text(
                                                controller.filters[index],
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    color: controller
                                                                .selectedCategory
                                                                .value ==
                                                            index
                                                        ? AppColors.white
                                                        : Colors.black),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    }),
                                  ),
                                ),
                              ),
                            ),
                            NotificationListener<ScrollNotification>(
                              onNotification: controller.onScrollDishes,
                              child: Obx(() {
                                return controller.isLoadingDishes.value
                                    ?  CircularProgressIndicator(color: AppColors.primaryColor)
                                    : Expanded(
                                        child: ListView.builder(
                                          itemCount: controller.dishList.length,
                                          itemBuilder: (context, index) {
                                            return Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: InkWell(
                                                onTap: () {},
                                                child: DishCard(
                                                  dish: controller
                                                      .dishList[index],
                                                  index: index,
                                                  isDishes: true,
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      );
                              }),
                            ),
                          ],
                        ),
                      ],
                    );
        }),
      ),
    );
  }
}

class DishCard extends StatefulWidget {
  final int index;

  const DishCard(
      {super.key,
      required this.index,
      this.dish,
      this.restaurant,
      required this.isDishes});

  final Dishes? dish;
  final Restaurant? restaurant;
  final bool isDishes;

  @override
  State<DishCard> createState() => _DishCardState();
}

class _DishCardState extends State<DishCard> {
  int _count = 0;

  void _incrementCount() {
    setState(() {
      _count++;
    });
  }

  void _decrementCount() {
    setState(() {
      if (_count > 0) _count--;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.backgroundColor,
      child: Card(
        color: AppColors.white,
        surfaceTintColor: AppColors.white,
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(15),
                    bottomLeft: Radius.circular(15),
                  ),
                  child: SizedBox(
                    height: 165,
                    width: 120,
                    child: CommonImageView(
                      fit: BoxFit.fitHeight,
                      url: widget.isDishes
                          ? widget.dish?.storeProducts?.images?.imageMobile
                          : widget
                              .restaurant?.storeProducts?.images?.imageMobile,
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          (widget.isDishes
                                  ? widget.dish?.storeProducts
                                      ?.name
                                  : widget.restaurant?.storeProducts?.name) ??
                              "",
                          style: const TextStyle(
                            fontSize: 16,
                            // overflow: TextOverflow.ellipsis,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                            "₹${(widget.isDishes ? widget.dish?.storeProducts?.price : widget.restaurant?.storeProducts?.price)}"),
                        Chip(
                          label: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              CommonImageView(
                                svgPath:
                                    "packages/mynewpackage/${Assets.iconsStar}",
                              ),
                              Text(
                                "${(widget.isDishes ? widget.dish?.storeProducts?.rating : widget.restaurant?.storeProducts?.rating)}(${Utility.countConverter(widget.isDishes ? widget.dish?.storeProducts?.productDetails?.countOfRating : widget.restaurant?.storeProducts?.productDetails?.countOfRating)})",
                                style: const TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                          side: BorderSide(color: AppColors.borderColor),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CommonImageView(
                              svgPath:
                                  "packages/mynewpackage/${Assets.iconsShopIcon}",
                            ),
                            const SizedBox(width: 5),
                            Expanded(
                              child: Text(
                                "${(widget.isDishes ? widget.dish?.branchName : widget.restaurant?.branchName)}",
                                style: TextStyle(
                                    overflow: TextOverflow.ellipsis,
                                    color: AppColors.textLightColor),
                              ),
                            ),
                            const SizedBox(
                              width: 3,
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                if (_count == 0)
                                  InkWell(
                                    onTap: _incrementCount,
                                    child: CommonImageView(
                                      svgPath:
                                          "packages/mynewpackage/${Assets.iconsAddIcon}",
                                    ),
                                  ),
                                if (_count > 0) ...[
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50),
                                      color: AppColors.primaryColor,
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 15, vertical: 8),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          InkWell(
                                            onTap: _incrementCount,
                                            child: const Icon(
                                                size: 20,
                                                Icons.add,
                                                color: Colors.white),
                                          ),
                                          const SizedBox(
                                            width: 8,
                                          ),
                                          Text(
                                            '$_count',
                                            style: const TextStyle(
                                                color: Colors.white),
                                          ),
                                          const SizedBox(
                                            width: 8,
                                          ),
                                          InkWell(
                                            onTap: _decrementCount,
                                            child: const Icon(
                                                size: 20,
                                                Icons.remove,
                                                color: Colors.white),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class RestaurantList extends StatelessWidget {
  const RestaurantList({
    super.key,
    required this.controller,
  });

  final RestaurantsAndDishesListingController controller;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: controller.restaurantList.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: InkWell(
            onTap: () {
              Get.to(RestaurantsDetailsView(
                restaurantId: controller.restaurantList[index].id.toString(),
                distance:controller.restaurantList[index].distanceInKilometer ?? 0
              ));
            },
            child: Container(
                color: AppColors.backgroundColor,
                child: Card(
                  color: AppColors.white,
                  surfaceTintColor: AppColors.white,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child:
                        // CommonImageView(
                        //   height: 175,
                        //   width: 400,
                        //   url:
                        //       controller.restaurantList[index].images?.first.image,
                        // ),
                        controller.restaurantList[index].offers?.first.offer != ""
                        ? Stack(children: [
                            controller.restaurantList[index].isAvailable == 2
                                ? ImageFiltered(
                                    imageFilter: ImageFilter.blur(
                                        sigmaX: 4.0, sigmaY: 4.0),
                                    child: CommonImageView(
                                      url: controller.restaurantList[index].images?.first.image,
                                      fit: BoxFit.cover,
                                      height: 175,
                                        width: 400,
                                    ),
                                  )
                                : CommonImageView(
                                    url:
                                    controller.restaurantList[index].images?.first.image,
                              height: 175,
                              width: 400,
                                  ),
                          controller.restaurantList[index].isAvailable == 1
                                ? CommonImageView(
                                    svgPath:
                                        "packages/mynewpackage/${Assets.iconsOffer}",
                                  )
                                : ImageFiltered(
                                    imageFilter: ImageFilter.blur(
                                        sigmaX: 4.0, sigmaY: 4.0),
                                    child: SvgPicture.asset(
                                      "packages/mynewpackage/${Assets.iconsOffer}",
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Text(
                                controller.restaurantList[index].offers?.first.offer ?? "",
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.white),
                              ),
                            ),
                            Positioned(
                                top: 30,
                                left: 5,
                                child: Text("Upto ₹75",
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: AppColors.white))),
                          ])
                        : controller.restaurantList[index].isAvailable == 1
                            ? CommonImageView(
                            height: 175,
                            width: 400,
                                url:
                                controller.restaurantList[index].images?.first.image)
                            :
                        ImageFiltered(
                                        imageFilter: ImageFilter.blur(
                                            sigmaX: 4.0, sigmaY: 4.0),
                                        child: CommonImageView(
                                          height: 175,
                                          width: 400,
                                        url:   controller.restaurantList[index].images?.first.image,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 10),
                        child: Text(
                          "${controller.restaurantList[index].branchName}",
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w800),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 5),
                        child: Row(
                          children: [
                            Chip(
                              label: Row(
                                children: [
                                  CommonImageView(
                                      svgPath:
                                          "packages/mynewpackage/${Assets.iconsStar}"),
                                  Text("${controller.ratings[index]}",
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 12)),
                                ],
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25),
                              ),
                              side: BorderSide(color: AppColors.borderColor),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Chip(
                              label: Text(
                                "${controller.restaurantList[index].distanceInKilometer?.toStringAsFixed(1)} km",
                                style: const TextStyle(
                                    fontWeight: FontWeight.w500, fontSize: 12),
                              ),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25),
                                  side:
                                      BorderSide(color: AppColors.borderColor)),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 5),
                        child: Text(
                          controller.restaurantList[index].images?.first.description ?? "",
                          style: TextStyle(
                              fontSize: 14, color: AppColors.textColor),
                        ),
                      ),
                      controller.restaurantList[index].isAvailable == 2
                          ? const Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 5),
                              child: Text(
                                "Currently Unavailable",
                                style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.red,
                                    fontWeight: FontWeight.w500),
                              ),
                            )
                          : const SizedBox.shrink()
                    ],
                  ),
                )),
          ),
        );
      },
    );
  }
}
