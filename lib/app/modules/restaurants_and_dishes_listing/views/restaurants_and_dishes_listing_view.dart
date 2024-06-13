import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:mynewpackage/app/core/theme_extension.dart';
import 'package:mynewpackage/app/core/utility.dart';
import 'package:mynewpackage/app/modules/home/controllers/home_controller.dart';
import 'package:mynewpackage/app/modules/restaurants_details/controllers/restaurants_details_controller.dart';
import 'package:mynewpackage/app/modules/restaurants_details/views/restaurants_details_view.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../app_colors.dart';
import '../../../../constants.dart';
import '../../../../generated/assets.dart';
import '../../../../widgets/common_Image_view.dart';
import '../../../../widgets/common_text.dart';
import '../../home/controllers/font_controller.dart';
import '../../restaurants_details/data/get_restaurant_details_response.dart';
import '../controllers/restaurants_and_dishes_listing_controller.dart';
import '../data/dish_listing_response.dart';

class RestaurantsAndDishesListingView extends StatefulWidget {
  const RestaurantsAndDishesListingView({super.key});

  @override
  State<RestaurantsAndDishesListingView> createState() =>
      _RestaurantsAndDishesListingViewState();
}

class _RestaurantsAndDishesListingViewState
    extends State<RestaurantsAndDishesListingView> {
  final HomeController homeController = Get.put(HomeController());

  final RestaurantsAndDishesListingController controller =
      Get.put(RestaurantsAndDishesListingController());

  @override
  Widget build(BuildContext context) {
    final cont = Get.find<FontController>();

    return Theme(
        data: ThemeData(
            fontFamily: cont.fontText.value, textTheme: cont.font.value),
        child: DefaultTabController(
          length: 2,
          child: Scaffold(
            backgroundColor: AppColors.backgroundColor,
            appBar: AppBar(
              backgroundColor: AppColors.backgroundColor,
              title: InkWell(
                onTap: () {
                  homeController.showAddressSelectionBottomSheet(
                      context: context, controller: controller);
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        CommonText(
                            text: 'Your Location',
                            fontSize: 14,
                            textColor: AppColors.textLightColor),
                        const Icon(
                          Icons.keyboard_arrow_down_sharp,
                          size: 14,
                        )
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Obx(() {
                      return Row(
                        children: [
                          SvgPicture.asset(
                            "packages/mynewpackage/${Assets.iconsLocation}",
                            color: AppColors.primaryColor,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Expanded(
                              child: CommonText(
                                  text: homeController.address.value,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  textOverflow: TextOverflow.ellipsis))
                        ],
                      );
                    }),
                  ],
                ),
              ),
              centerTitle: true,
              bottom: TabBar(
                padding: const EdgeInsets.only(left: 20),
                isScrollable: true,
                tabAlignment: TabAlignment.start,
                splashFactory: NoSplash.splashFactory,
                indicatorColor: AppColors.primaryColor,
                labelColor: AppColors.primaryColor,
                labelStyle: context.myTextTheme.headlineMedium?.copyWith(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
                // const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
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
                  ? buildShimmerRestaurant()
                  // Center(
                  //         child: CircularProgressIndicator(
                  //         color: AppColors.primaryColor,
                  //       )
                  // )
                  : controller.restaurantList.isEmpty
                      ? Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SvgPicture.asset(
                                  'packages/mynewpackage/lib/assets/icons/not_available_at_location.svg'),
                              const SizedBox(
                                height: 20,
                              ),
                              CommonText(
                                  text: "Hi ${Constants.name},",
                                  fontWeight: FontWeight.w700,
                                  fontSize: 20),
                              SizedBox(
                                height: 10,
                              ),
                              const CommonText(
                                  text:
                                      "Currently we are not serviceable in your location.\nWe are on a process of increasing our service area.",
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14),
                              SizedBox(
                                height: 10,
                              ),
                              const CommonText(
                                  text:
                                      "We will notify you once we start our service in your area",
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                  textColor: Color(0xff2C9649)),
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
                                          controller.isSelected.value =
                                              !controller.isSelected.value;
                                          if (controller.isSelected.value) {
                                            controller.selectedCategory.value =
                                                index;
                                            controller.getDishes(initial: true);
                                          } else {
                                            controller.selectedCategory.value =
                                                2;
                                            controller.getDishes(initial: true);
                                          }

                                          // controller. dishFilter();
                                        },
                                        child: Obx(() {
                                          return Container(
                                            height: 35,
                                            width: 110,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  const BorderRadius.all(
                                                Radius.circular(40),
                                              ),
                                              border: Border.all(
                                                color: controller
                                                            .selectedCategory
                                                            .value ==
                                                        index
                                                    ? AppColors.primaryColor
                                                    : AppColors.borderColor,
                                                style: BorderStyle.solid,
                                                width: controller
                                                            .selectedCategory
                                                            .value ==
                                                        index
                                                    ? 1.5
                                                    : 1,
                                              ),
                                            ),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 5,
                                                      vertical: 5),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  SvgPicture.asset(
                                                      "packages/mynewpackage/${controller.filterImages[index]}"),
                                                  CommonText(
                                                      text: controller
                                                          .filters[index],
                                                      fontSize: 12,
                                                      textColor: Colors.black),
                                                  // SizedBox(width: 10,),
                                                  controller.selectedCategory
                                                              .value ==
                                                          index
                                                      ? Spacer()
                                                      : SizedBox.shrink(),
                                                  controller.selectedCategory
                                                              .value ==
                                                          index
                                                      ? InkWell(
                                                          onTap: () {
                                                            controller
                                                                    .isSelected
                                                                    .value =
                                                                !controller
                                                                    .isSelected
                                                                    .value;
                                                            if (controller
                                                                .isSelected
                                                                .value) {
                                                              controller
                                                                  .selectedCategory
                                                                  .value = index;
                                                              controller.getDishes(
                                                                  initial: true,
                                                                  context:
                                                                      context);
                                                            } else {
                                                              controller
                                                                  .selectedCategory
                                                                  .value = 2;
                                                              controller.getDishes(
                                                                  initial: true,
                                                                  context:
                                                                      context);
                                                            }

                                                            // controller.dishFilter();
                                                          },
                                                          child: const Icon(
                                                            Icons.close_rounded,
                                                            size: 20,
                                                          ))
                                                      : const SizedBox.shrink(),
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
                                        ? shimmerDishes()
                                        : controller.dishList.isNotEmpty
                                            ? Expanded(
                                                child: RefreshIndicator(
                                                  onRefresh: () async {
                                                    await controller.getDishes(
                                                        initial: true,
                                                        context: context);
                                                  },
                                                  child: ListView.builder(
                                                    itemCount: controller
                                                        .dishList.length,
                                                    itemBuilder:
                                                        (context, index) {
                                                      return Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: InkWell(
                                                          onTap: () {},
                                                          child: DishCard(
                                                            restaurantsAndDishesListingController:
                                                                controller,
                                                            dish: controller
                                                                    .dishList[
                                                                index],
                                                            index: index,
                                                            isDishes: true,
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                  ),
                                                ),
                                              )
                                            : SizedBox(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height /
                                                    2,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Column(
                                                    children: [
                                                      SizedBox(
                                                        height: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .height /
                                                            5,
                                                      ),
                                                      ColorFiltered(
                                                        colorFilter:
                                                            ColorFilter.mode(
                                                                AppColors
                                                                    .primaryColor,
                                                                BlendMode
                                                                    .modulate),
                                                        child: Image.asset(
                                                          height: 120,
                                                          width: 120,
                                                          'packages/mynewpackage/${Assets.iconsNoFood6}',
                                                          //  height: 100,
                                                          //  width: 100,
                                                          //  color: Colors.red,
                                                          // imagePath: :
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: 10,
                                                      ),
                                                      CommonText(
                                                        text:
                                                            "We're currently out of ${controller.selectedCategory.value == 0 ? "Veg" : "Non Veg"} items, but our ${controller.selectedCategory.value == 1 ? "Veg" : "Non Veg"} selection is sizzling! Take a look!",
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        textAlign:
                                                            TextAlign.center,
                                                      ),
                                                    ],
                                                  ),
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
        ));
  }
}

class DishCard extends StatefulWidget {
  final int index;

  const DishCard(
      {super.key,
      required this.index,
      this.dish,
      this.restaurant,
      required this.isDishes,
      this.restaurantsAndDishesListingController,
      this.restaurantsDetailsController});

  final Dishes? dish;
  final Restaurant? restaurant;
  final bool isDishes;
  final RestaurantsAndDishesListingController?
      restaurantsAndDishesListingController;
  final RestaurantsDetailsController? restaurantsDetailsController;

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
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                ),
                child: CommonImageView(
                  cacheKey: widget.isDishes
                      ? widget.dish?.storeProducts?.id
                      : widget.restaurant?.id,
                  height: widget.isDishes ? 178 : 198,
                  width: 150,
                  fit: BoxFit.cover,
                  url: widget.isDishes
                      ? widget.dish?.storeProducts?.images?.productImageUrl
                      : widget.restaurant?.images?.imageMobile,
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Name at the top

                      CommonText(
                        text: (widget.isDishes
                                ? widget.dish?.storeProducts?.name
                                : widget.restaurant?.name) ??
                            "",
                        maxLines: widget.isDishes ? 2 : 3,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        textOverflow: TextOverflow.ellipsis,
                      ),
                      //         Shimmer.fromColors(
                      // baseColor: Colors.grey[300]!,
                      //   highlightColor: Colors.grey[100]!,
                      //   child: Container(
                      //     width: 200.0,
                      //     height: 200.0,
                      //     color: Colors.white,
                      //   ),
                      // ),
                      const SizedBox(height: 8),
                      // Price
                      CommonText(
                        text:
                            "₹ ${(widget.isDishes ? widget.dish?.storeProducts?.price : widget.restaurant?.price)}",
                        fontWeight: FontWeight.w500,
                      ),
                      const SizedBox(height: 8),
                      // Rating
                      Chip(
                        label: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SvgPicture.asset(
                              "packages/mynewpackage/${Assets.iconsStar}",
                            ),
                            CommonText(
                              text:
                                  "${(widget.isDishes ? widget.dish?.storeProducts?.rating : widget.restaurant?.rating)}(${Utility.countConverter(widget.isDishes ? widget.dish?.storeProducts?.productDetails?.countOfRating ?? 0 : widget.restaurant?.productDetails?.countOfRating ?? 0)})",
                              fontWeight: FontWeight.w500,
                              fontSize: 12,
                            ),
                          ],
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                        side: BorderSide(
                          color: AppColors.borderColor,
                        ),
                      ),
                      Spacer(),
                      // Add icon at the bottom
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          if (widget.isDishes)
                            ColorFiltered(
                              colorFilter: ColorFilter.mode(
                                  AppColors.accentColor, BlendMode.modulate),
                              child: SvgPicture.asset(
                                "packages/mynewpackage/${Assets.iconsShopIcon}",
                              ),
                            ),
                          const SizedBox(width: 5),
                          if (widget.isDishes)
                            Expanded(
                              child: CommonText(
                                  text:
                                      "${widget.dish?.restaurantDetails?.first.name}",
                                  textOverflow: TextOverflow.ellipsis,
                                  textColor: AppColors.textLightColor),
                            ),
                          const SizedBox(width: 3),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              if (_count == 0)
                                InkWell(
                                  onTap: _incrementCount,
                                  child: SvgPicture.asset(
                                    "packages/mynewpackage/${Assets.iconsAddIcon}",
                                    color: AppColors.primaryColor,
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
                                          onTap: _decrementCount,
                                          child: const Icon(
                                              size: 20,
                                              Icons.remove,
                                              color: Colors.white),
                                        ),
                                        const SizedBox(width: 8),
                                        CommonText(
                                            text: '$_count',
                                            textColor: Colors.white),
                                        const SizedBox(width: 8),
                                        InkWell(
                                          onTap: _incrementCount,
                                          child: const Icon(
                                              size: 20,
                                              Icons.add,
                                              color: Colors.white),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
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
    return RefreshIndicator(
      onRefresh: () async {
        await controller.getRestaurants(initial: true, context: context);
      },
      child: ListView.builder(
        itemCount: controller.restaurantList.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => RestaurantsDetailsView(
                        restaurantId:
                            controller.restaurantList[index].id.toString(),
                        distance: controller
                                .restaurantList[index].distanceInKilometer ??
                            0,
                        restaurantData: controller.restaurantList[index])));

                // Get.to(RestaurantsDetailsView(
                //     restaurantId:
                //         controller.restaurantList[index].id.toString(),
                //     distance:
                //         controller.restaurantList[index].distanceInKilometer ??
                //             0,
                //     restaurantData: controller.restaurantList[index]));
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
                          borderRadius: const BorderRadius.only(
                              topRight: Radius.circular(15),
                              topLeft: Radius.circular(15)),
                          child: controller.restaurantList[index].offers?.first
                                      .offer !=
                                  ""
                              ? Stack(children: [
                                  controller.restaurantList[index]
                                              .isAvailable ==
                                          2
                                      ? ImageFiltered(
                                          imageFilter: ImageFilter.blur(
                                              sigmaX: 4.0, sigmaY: 4.0),
                                          child: CommonImageView(
                                            cacheKey: controller
                                                .restaurantList[index].id,
                                            url: controller
                                                .restaurantList[index]
                                                .images
                                                ?.first
                                                .image,
                                            fit: BoxFit.cover,
                                            height: 175,
                                            width: 400,
                                          ),
                                        )
                                      : CommonImageView(
                                          cacheKey: controller
                                              .restaurantList[index].id,
                                          url: controller.restaurantList[index]
                                              .images?.first.image,
                                          height: 175,
                                          width: 400,
                                        ),
                                  controller.restaurantList[index]
                                              .isAvailable ==
                                          1
                                      ? ColorFiltered(
                                          colorFilter: ColorFilter.mode(
                                              AppColors.accentColor,
                                              BlendMode.modulate),
                                          child: SvgPicture.asset(
                                            "packages/mynewpackage/${Assets.iconsOffer}",
                                          ),
                                        )
                                      : ImageFiltered(
                                          imageFilter: ImageFilter.blur(
                                              sigmaX: 4.0, sigmaY: 4.0),
                                          child: ColorFiltered(
                                            colorFilter: ColorFilter.mode(
                                                AppColors.accentColor,
                                                BlendMode.modulate),
                                            child: SvgPicture.asset(
                                              "packages/mynewpackage/${Assets.iconsOffer}",
                                              fit: BoxFit.cover,
                                            ),
                                          )),
                                  Padding(
                                    padding: EdgeInsets.all(5.0),
                                    child: CommonText(
                                        text: controller.restaurantList[index]
                                                .offers?.first.offer ??
                                            "",
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        textColor: AppColors.white),
                                  ),
                                  Positioned(
                                      top: 30,
                                      left: 5,
                                      child: CommonText(
                                          text: "Upto ₹75",
                                          fontSize: 14,
                                          textColor: AppColors.white)),
                                ])
                              : controller.restaurantList[index].isAvailable !=
                                      2
                                  ? CommonImageView(
                                      cacheKey:
                                          controller.restaurantList[index].id,
                                      height: 175,
                                      width: 400,
                                      url: controller.restaurantList[index]
                                          .images?.first.image)
                                  : ImageFiltered(
                                      imageFilter: ImageFilter.blur(
                                          sigmaX: 4.0, sigmaY: 4.0),
                                      child: CommonImageView(
                                        cacheKey:
                                            controller.restaurantList[index].id,
                                        height: 175,
                                        width: 400,
                                        url: controller.restaurantList[index]
                                            .images?.first.image,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 5),
                          child: CommonText(
                            text: (controller.restaurantList[index]
                                    .restaurantDetails?.first.name)! +
                                (' , ${controller.restaurantList[index].branchName.toString()}'),
                            fontSize: 16,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                          ),
                          child: Row(
                            children: [
                              Chip(
                                label: Row(
                                  children: [
                                    SvgPicture.asset(
                                        "packages/mynewpackage/${Assets.iconsStar}"),
                                    CommonText(
                                        text:
                                            "${controller.restaurantList[index].rating}(${Utility.countConverter(controller.restaurantList[index].totalRating)})",
                                        fontWeight: FontWeight.w500,
                                        fontSize: 10),
                                  ],
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(25),
                                ),
                                side: BorderSide(color: AppColors.borderColor),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Chip(
                                label: CommonText(
                                  text:
                                      "${controller.restaurantList[index].distanceInKilometer?.toStringAsFixed(1)} km",
                                  fontWeight: FontWeight.w500,
                                  fontSize: 10,
                                ),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25),
                                    side: BorderSide(
                                        color: AppColors.borderColor)),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 15,
                          ),
                          child: CommonText(
                            text: controller.restaurantList[index].images?.first
                                    .description ??
                                "",
                            fontSize: 14,
                            textColor: AppColors.textColor,
                            textOverflow: TextOverflow.ellipsis,
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        controller.restaurantList[index].isAvailable == 2
                            ? const Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 20),
                                child: CommonText(
                                  text: "Currently Unavailable",
                                  fontSize: 14,
                                  textColor: Colors.red,
                                  fontWeight: FontWeight.w500,
                                ),
                              )
                            : const SizedBox.shrink()
                      ],
                    ),
                  )),
            ),
          );
        },
      ),
    );
  }
}

Widget buildShimmerRestaurant() {
  return ListView.builder(
    itemCount: 10,
    itemBuilder: (context, index) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          color: AppColors.white,
          surfaceTintColor: AppColors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Shimmer for image
              Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(15),
                    topLeft: Radius.circular(15),
                  ),
                  child: Container(
                    height: 175,
                    width: 400,
                    color: Colors.grey[200],
                  ),
                ),
              ),
              const SizedBox(height: 5), // Spacing between elements

              // Shimmer for restaurant name and details
              Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 5,
                  ),
                  child: Container(
                    height: 15,
                    color: Colors.grey[200],
                  ),
                ),
              ),
              const SizedBox(height: 5), // Spacing between elements

              // Shimmer for rating & distance chips
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                  child: Row(
                    children: [
                      Container(
                        height: 20,
                        width: 50,
                        color: Colors.grey[200],
                      ),
                      const SizedBox(width: 10),
                      Container(
                        height: 20,
                        width: 70,
                        color: Colors.grey[200],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 5), // Spacing between elements

              // Shimmer for description
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 15,
                    ),
                    child: Container(
                      height: 10,
                      color: Colors.grey[200],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}

Widget shimmerDishes() {
  return Expanded(
    child: ListView.builder(
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return Container(
            color: AppColors.backgroundColor,
            child: Card(
              color: AppColors.white,
              surfaceTintColor: AppColors.white,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[100]!,
                    child: ClipRRect(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(10),
                          bottomLeft: Radius.circular(10),
                        ),
                        child: Container(
                          height: 200,
                          width: 150,
                          color: Colors.grey[200],
                        )),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Shimmer.fromColors(
                          child: Container(
                            height: 10,
                            width: 150,
                            color: Colors.grey[200],
                          ),
                          baseColor: Colors.grey[300]!,
                          highlightColor: Colors.grey[100]!,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Shimmer.fromColors(
                          child: Container(
                            height: 10,
                            width: 100,
                            color: Colors.grey[200],
                          ),
                          baseColor: Colors.grey[300]!,
                          highlightColor: Colors.grey[100]!,
                        ),
                        SizedBox(
                          height: 50,
                        ),
                        Shimmer.fromColors(
                          child: Container(
                            height: 30,
                            width: 100,
                            color: Colors.grey[200],
                          ),
                          baseColor: Colors.grey[300]!,
                          highlightColor: Colors.grey[100]!,
                        ),
                      ],
                    ),
                  ),

                  // Rating
                ],
              ),
            ),
          );
        },
        itemCount: 10),
  );
}
