import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:mynewpackage/app/modules/restaurants_and_dishes_listing/views/restaurants_and_dishes_listing_view.dart';
import 'package:mynewpackage/app_colors.dart';
import 'package:mynewpackage/constants.dart';
import 'package:mynewpackage/generated/assets.dart';
import 'package:mynewpackage/widgets/common_Image_view.dart';
import 'package:mynewpackage/widgets/loading_view.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  HomeView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return LoadingView(
      isAsyncCall: controller.isLoading,
      showBackGroundData: false,
      authenticated: false.obs,
      child: Scaffold(
          backgroundColor: AppColors.backgroundColor,
          appBar: AppBar(
            backgroundColor: AppColors.backgroundColor,
            title: InkWell(
              onTap: () {
                controller.showAddressSelectionBottomSheet(context: context);
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
                  SizedBox(
                    height: 10,
                  ),
                  Obx(() {
                    return Row(
                      children: [
                        SvgPicture.asset(
                          "packages/mynewpackage/${Assets.iconsLocation}",
                          color: controller.colorController.primaryColor.value,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Expanded(
                            child: Text(controller.address.value,
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
            leading: InkWell(
                onTap: () {
                  Get.back();
                },
                child: const Icon(Icons.arrow_back_rounded)),
            actions: [
              Obx(() {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    height: 42,
                    width: 42,
                    child: CircleAvatar(
                      backgroundColor:
                          controller.colorController.primaryColor.value,
                      radius: 50,
                      child: Text(
                        Constants.nameFirstLetter,
                        style: TextStyle(color: Colors.white),
                      ), // Radius of the circle
                    ),
                  ),
                );
              }),
            ],
            centerTitle: true,
          ),
          body: RefreshIndicator(
            onRefresh: () async {
              await controller.getServices();
            },
            child: ListView(
              children:[
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 160,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: controller.specialOfferTitle.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: InkWell(
                                splashColor: Colors.transparent,
                                onTap: () {
                                  // Get.to(()=> AddCashToWalletView());
                                },
                                child: Column(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: CommonImageView(
                                        height: 100,
                                        width: 100,
                                        imagePath:
                                        "packages/mynewpackage/${controller.specialOfferImages[index]}",
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      controller.specialOfferTitle[index],
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(fontSize: 12),
                                    )
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      Text(
                        "Hi ${Constants.name.toUpperCase().capitalizeFirst},",
                        style:
                        TextStyle(fontSize: 26, fontWeight: FontWeight.w800),
                      ),
                      const Text("Explore The Popular Categories",
                          style: TextStyle(
                            fontSize: 22,
                          )),
                      const SizedBox(
                        height: 10,
                      ),
                      LayoutBuilder(builder: (context, constraints) {
                        double itemWidth = (constraints.maxWidth);
                        double itemHeight = itemWidth +
                            MediaQuery.of(context).size.height *
                                .15; // Make items square
                        return Obx(() {
                          return controller.isLoadingServices.value
                              ? SizedBox.shrink()
                          // CircularProgressIndicator(
                          //     color: AppColors.primaryColor)
                              : controller.serviceList.isEmpty
                              ? Column(
                            children: [
                              SizedBox(
                                height:
                                MediaQuery.of(context).size.height *
                                    .05,
                              ),

                              ColorFiltered(
                                colorFilter: ColorFilter.mode(AppColors.primaryColor, BlendMode.modulate),
                                child: SvgPicture.asset(
                                    height: 300,
                                    width: 300,
                                    'packages/mynewpackage/${Assets.iconsStaytuned2}'),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 25),
                                child: const Text(
                                  "Hold your horses!   We're not quite there yet, but we're bringing our service to your area soon. Stay tuned!",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w800),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          )
                              : GridView.builder(
                              physics:
                              const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                mainAxisSpacing: 10,
                                crossAxisSpacing: 10,
                                childAspectRatio: itemWidth / itemHeight,
                                crossAxisCount: 3,
                              ),
                              itemCount: controller.serviceList.length,
                              itemBuilder:
                                  (BuildContext context, int index) {
                                return InkWell(
                                  onTap: () {
                                    controller.serviceList[index]
                                        .categoryName ==
                                        "Food"
                                        ? Get.to(() =>
                                        RestaurantsAndDishesListingView())
                                        : null;
                                  },
                                  child: Card(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                        BorderRadius.circular(10.0),
                                        side: BorderSide(
                                          color:
                                          // controller.serviceList[index]
                                          //             .categoryName ==
                                          //         "Gifts"
                                          //     ? AppColors.green
                                          //     :
                                          AppColors.white,
                                          width: 2.0,
                                        )),
                                    elevation: 0,
                                    color: AppColors.white,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment:
                                        MainAxisAlignment.center,
                                        children: [
                                          ColorFiltered(
                                              colorFilter:
                                              ColorFilter.mode(
                                                  AppColors
                                                      .accentColor,
                                                  BlendMode.modulate),
                                              child: CommonImageView(
                                                svgPath: controller
                                                    .serviceList[
                                                index]
                                                    .images
                                                    ?.first
                                                    .primary ??
                                                    "",
                                              )),
                                          SizedBox(
                                            height: 8,
                                          ),
                                          Flexible(
                                            child: Text(
                                              controller
                                                  .serviceList[index]
                                                  .categoryName ??
                                                  "",
                                              style: const TextStyle(
                                                  fontSize: 13,
                                                  fontWeight:
                                                  FontWeight.w800),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              });
                        });
                      }),
                    ],
                  ),
                ),
              ]

            ),
          )),
    );
  }
}
