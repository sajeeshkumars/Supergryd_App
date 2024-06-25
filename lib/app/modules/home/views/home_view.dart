import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:mynewpackage/app/modules/restaurants_and_dishes_listing/views/restaurants_and_dishes_listing_view.dart';
import 'package:mynewpackage/app_colors.dart';
import 'package:mynewpackage/constants.dart';
import 'package:mynewpackage/l10n/lang_extensions.dart';
import 'package:mynewpackage/widgets/loading_view.dart';

import '../../../../generated/assets.dart';
import '../../../../widgets/common_Image_view.dart';
import '../../../../widgets/common_text.dart';
import '../controllers/home_controller.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

HomeController controller = Get.find();

class _HomeViewState extends State<HomeView> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (ModalRoute.of(context)?.isCurrent == true &&
          controller.count.value == 0) {
        controller.showAddressSelectionBottomSheet(
          context: context,
        );
      }
    });
  }

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
                    // mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      CommonText(
                        fontSize: 14,
                        textColor: AppColors.textLightColor,
                        text: "Your Location",
                      ),
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
                          color: controller.colorController.primaryColor.value,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Expanded(
                            child: CommonText(
                          fontSize: 14,
                          maxLines: 2,
                          fontWeight: FontWeight.w800,
                          textOverflow: TextOverflow.ellipsis,
                          text: controller.address.value,
                        )),
                      ],
                    );
                  }),
                ],
              ),
            ),
            leading: InkWell(
                onTap: () {
                  Navigator.of(context).pop;
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
                      child: CommonText(
                        textColor: AppColors.white,
                        text: Constants.nameFirstLetter,
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
            child: ListView(children: [
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
                                // Get.to(() => AddCashToWalletView());
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
                                  CommonText(
                                    fontSize: 12,
                                    textAlign: TextAlign.center,
                                    text: controller.specialOfferTitle[index],
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    CommonText(
                      fontSize: 26,
                      fontWeight: FontWeight.w800,
                      text:
                          "Hi ${Constants.name.toUpperCase().capitalizeFirst},",
                    ),
                    CommonText(
                      fontSize: 22,
                      text: context.loc.explore_the_popular_category,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    LayoutBuilder(builder: (context, constraints) {
                      double itemWidth = (MediaQuery.of(context).size.width);
                      double itemHeight = itemWidth +
                          MediaQuery.of(context).size.height *
                              .3; // Make items square
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
                                        colorFilter: ColorFilter.mode(
                                            AppColors.primaryColor,
                                            BlendMode.modulate),
                                        child: SvgPicture.asset(
                                            height: 300,
                                            width: 300,
                                            'packages/mynewpackage/${Assets.iconsStaytuned2}'),
                                      ),
                                      const Padding(
                                        padding: EdgeInsets.only(bottom: 25),
                                        child: CommonText(
                                          fontWeight: FontWeight.w800,
                                          textAlign: TextAlign.center,
                                          text:
                                              "Hold your horses!   We're not quite there yet, but we're bringing our service to your area soon. Stay tuned!",
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
                                          controller.serviceList[index].id ==
                                                  "6646f17c6538869d3399af45"
                                              ? Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          RestaurantsAndDishesListingView()))

                                              // Get.to(() =>
                                              //     RestaurantsAndDishesListingView())
                                              : controller.serviceList[index]
                                                          .id ==
                                                      "6646f2196538869d3399af46"
                                                  ? controller
                                                      .requestLocationPermission(
                                                          context)
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
                                                  child: CommonText(
                                                    text: controller
                                                            .serviceList[index]
                                                            .categoryName ??
                                                        "",
                                                    fontSize: 13,
                                                    fontWeight: FontWeight.w800,
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
            ]),
          )),
    );
  }
}
