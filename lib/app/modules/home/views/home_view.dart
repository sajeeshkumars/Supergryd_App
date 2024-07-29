import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:mynewpackage/app/modules/restaurants_and_dishes_listing/views/restaurants_and_dishes_listing_view.dart';
import 'package:mynewpackage/app_colors.dart';
import 'package:mynewpackage/constants.dart';
import 'package:mynewpackage/generated/assets.dart';
import 'package:mynewpackage/widgets/common_Image_view.dart';
import 'package:mynewpackage/widgets/loading_view.dart';

import '../../../../model/super_gryd_story.dart';
import '../../../../widgets/common_text.dart';
import '../../../../widgets/story_widget.dart';
import '../controllers/home_controller.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late HomeController controller;
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
  void initState() {
    controller = Get.find<HomeController>();
    getServices();
    super.initState();
  }

  getServices() async {
    await controller.getServices();
  }

  @override
  Widget build(BuildContext context) {
    // controller.createUser(
    //     mobile: "9537212345", name: "Michael", context: context);
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
                      InkWell(
                        onTap: () {
                          SystemNavigator.pop();
                        },
                        child: const Icon(
                          Icons.keyboard_arrow_down_sharp,
                          size: 14,
                        ),
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
                          maxLines: 1,
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
                    StoryWidget(
                      storyData: [
                        // SuperGrydStory(
                        //     storyData: [
                        //       SuperGrydStoryData(
                        //           imageUrl:
                        //               "https://images.pexels.com/photos/1043471/pexels-photo-1043471.jpeg?cs=srgb&dl=pexels-chloekalaartist-1043471.jpg&fm=jpg&w=640&h=960",
                        //           title: "Story 1")
                        //     ],
                        //     thumbUrl:
                        //         "https://images.pexels.com/photos/16715674/pexels-photo-16715674.jpeg?cs=srgb&dl=pexels-stephen-noulton-421904730-16715674.jpg&fm=jpg&w=640&h=640"),
                        // SuperGrydStory(
                        //     storyData: [
                        //       SuperGrydStoryData(
                        //           imageUrl:
                        //               "https://images.pexels.com/photos/1559486/pexels-photo-1559486.jpeg?cs=srgb&dl=pexels-jack-winbow-460463-1559486.jpg&fm=jpg&w=640&h=960",
                        //           title: "Story 2")
                        //     ],
                        //     thumbUrl:
                        //         "https://images.pexels.com/photos/10311994/pexels-photo-10311994.jpeg?cs=srgb&dl=pexels-nurlantortbayev-10311994.jpg&fm=jpg&w=640&h=640"),
                        SuperGrydStory(
                            title: "Special \n Food Menu",
                            storyData: [
                              SuperGrydStoryData(
                                  imageUrl:
                                      "https://img.freepik.com/free-psd/delicious-food-menu-social-media-template_505751-3002.jpg?w=826&t=st=1722234950~exp=1722235550~hmac=55f42baad9a5764755592c04d1c02305a6ae244b888adad9b236fd7202f226a8",
                                  title: "Story 1")
                            ],
                            thumbUrl:
                                "https://img.freepik.com/free-psd/delicious-food-menu-social-media-template_505751-3002.jpg?w=826&t=st=1722234950~exp=1722235550~hmac=55f42baad9a5764755592c04d1c02305a6ae244b888adad9b236fd7202f226a8"),
                        SuperGrydStory(
                            title: "50% off",
                            storyData: [
                              SuperGrydStoryData(
                                  imageUrl:
                                      "https://img.freepik.com/free-psd/food-social-media-promotion-instagram-banner-post-design-template_202595-475.jpg?w=826&t=st=1722235009~exp=1722235609~hmac=c3b5376f60a6b510a3f75d29b40c89092a493f45bf9ea28fa4a53c080becf875",
                                  title: "Story 2")
                            ],
                            thumbUrl:
                                "https://img.freepik.com/free-psd/food-social-media-promotion-instagram-banner-post-design-template_202595-475.jpg?w=826&t=st=1722235009~exp=1722235609~hmac=c3b5376f60a6b510a3f75d29b40c89092a493f45bf9ea28fa4a53c080becf875"),
                      ],
                    ),
                    // SizedBox(
                    //   height: 160,
                    //   child: ListView.builder(
                    //     scrollDirection: Axis.horizontal,
                    //     itemCount: controller.specialOfferTitle.length,
                    //     itemBuilder: (context, index) {
                    //       return Padding(
                    //         padding: const EdgeInsets.all(5.0),
                    //         child: InkWell(
                    //           splashColor: Colors.transparent,
                    //           onTap: () {
                    //             // Get.to(() => AddCashToWalletView());
                    //           },
                    //           child: Column(
                    //             children: [
                    //               ClipRRect(
                    //                 borderRadius: BorderRadius.circular(10),
                    //                 child: CommonImageView(
                    //                   height: 100,
                    //                   width: 100,
                    //                   imagePath:
                    //                       "packages/mynewpackage/${controller.specialOfferImages[index]}",
                    //                 ),
                    //               ),
                    //               const SizedBox(
                    //                 height: 5,
                    //               ),
                    //               CommonText(
                    //                 fontSize: 12,
                    //                 textAlign: TextAlign.center,
                    //                 text: controller.specialOfferTitle[index]
                    //                     .toString(),
                    //               )
                    //             ],
                    //           ),
                    //         ),
                    //       );
                    //     },
                    //   ),
                    // ),
                    CommonText(
                      fontSize: 26,
                      fontWeight: FontWeight.w800,
                      text:
                          "Hi ${Constants.name.toUpperCase().capitalizeFirst},",
                    ),
                    const CommonText(
                      fontSize: 22,
                      text: "Explore The Popular Categories",
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
                                          if (controller
                                                  .serviceList[index].id ==
                                              "6646f17c6538869d3399af45") {
                                            Navigator.of(context).push(
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        RestaurantsAndDishesListingView()));
                                          } else if (controller
                                                  .serviceList[index].id ==
                                              "6646f2196538869d3399af46") {
                                            controller
                                                .requestLocationPermission(
                                                    context);
                                          } else {
                                            null;
                                          }
                                          // controller.serviceList[index].id ==
                                          //         "6646f17c6538869d3399af45"
                                          //     ? Navigator.of(context).push(
                                          //         MaterialPageRoute(
                                          //             builder: (context) =>
                                          //                 RestaurantsAndDishesListingView()))

                                          // Get.to(() =>
                                          //     RestaurantsAndDishesListingView())
                                          // : controller.serviceList[index]
                                          //             .id ==
                                          //         "6646f2196538869d3399af46"
                                          //     ? controller
                                          //         .requestLocationPermission(
                                          //             context)
                                          //     : null;
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
