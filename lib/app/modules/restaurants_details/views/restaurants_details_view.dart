import 'dart:developer';
import 'dart:ffi';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:mynewpackage/app/modules/restaurants_and_dishes_listing/data/dish_listing_response.dart';
import 'package:mynewpackage/app/modules/restaurants_and_dishes_listing/data/restaurant_listing_response.dart' as restaurant_list;
import 'package:mynewpackage/app/modules/restaurants_and_dishes_listing/views/restaurants_and_dishes_listing_view.dart';
import 'package:mynewpackage/app/modules/restaurants_details/controllers/restaurants_details_controller.dart';
import 'package:mynewpackage/app_colors.dart';
import 'package:mynewpackage/widgets/common_Image_view.dart';
import 'package:mynewpackage/widgets/loading_view.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

import '../../../core/utility.dart';

class RestaurantsDetailsView extends StatefulWidget {
   const RestaurantsDetailsView({super.key, required this.restaurantId, required this.distance,   this.restaurantData});

  final String restaurantId;
  final num distance;
  final restaurant_list.RestaurantData? restaurantData;

  @override
  State<RestaurantsDetailsView> createState() => _RestaurantsDetailsViewState();
}

class _RestaurantsDetailsViewState extends State<RestaurantsDetailsView> {
  RestaurantsDetailsController restaurantsDetailsController =
      Get.put(RestaurantsDetailsController());

  @override
  void initState() {
    restaurantsDetailsController.getRestaurantDetails(
        restaurantId: widget.restaurantId, initial: true);
    Get.lazyPut(() => RestaurantsDetailsController());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        title:
        // Obx(() {
        //   return
        // restaurantsDetailsController.isLoading.value? const Center(child: CircularProgressIndicator(color: Colors.transparent,)):
    Text(

             widget.restaurantData?.restaurantDetails?.first.name ?? "",
            // restaurantsDetailsController
            //         .restaurantDetails.first.restaurantDetails?.first.name ??
            //     '',
            style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 18),
          ),
        // }),
        backgroundColor: AppColors.backgroundColor,
      ),
      body: SingleChildScrollView(
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                         BannerAndRatingWidget(restaurantData:widget.restaurantData, distance: widget.distance, controller: restaurantsDetailsController,),
                        const SizedBox(
                          height: 20,
                        ),
                         SearchWidget(controller: restaurantsDetailsController,restaurantData:widget.restaurantData),
                        const SizedBox(
                          height: 20,
                        ),
                         ChipWidget(controller:restaurantsDetailsController,restaurantId:widget.restaurantId),
                        const SizedBox(
                          height: 20,
                        ),
                        Obx(() {
                          return restaurantsDetailsController.restaurantDishList.isNotEmpty ? ListView.separated(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              return DishCard(
                                restaurant: restaurantsDetailsController
                                    .restaurantDishList[index],
                                index: index,
                                isDishes: false,
                              );
                            },
                            separatorBuilder: (context, index) {
                              return const SizedBox(
                                height: 10,
                              );
                            },
                            itemCount: restaurantsDetailsController
                                .restaurantDishList.length,
                          ):const Center(child: Text("No dish found!"));
                        })
                      ],
                    ),
                  ),
                ),
              ),
    );
  }
}

class ChipWidget extends StatefulWidget {
  const ChipWidget({
    super.key, required this.controller, required this.restaurantId,
  });

  final RestaurantsDetailsController controller;
  final String restaurantId;

  @override
  State<ChipWidget> createState() => _ChipWidgetState();
}

class _ChipWidgetState extends State<ChipWidget> {

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
      return widget.controller.isLoading.value? CircularProgressIndicator(): Row(
          children: List.generate(
            widget.controller.chipTitles.length,
                (index) => Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                splashFactory: NoSplash.splashFactory,
                onTap: () {
                  widget.controller.selectedFilter.value = index;
                  widget.controller.restaurantDishFilter();
                  // controller. dishFilter();
                },
                child: Obx(() {
                  return Container(
                    height: 35,
                    width: 110,
                    decoration: BoxDecoration(
                      color: widget.controller
                          .selectedFilter.value ==
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
                          widget.controller.selectedFilter
                              .value ==
                              index
                              ? CommonImageView(
                            svgPath:
                            widget.controller.chipImages[index],
                            color: AppColors.white,
                          )
                              : CommonImageView(
                              svgPath:
                              widget.controller.chipImages[index]),
                          Text(
                            widget.controller.chipTitles[index],
                            style: TextStyle(
                                fontSize: 12,
                                color: widget.controller
                                    .selectedFilter
                                    .value ==
                                    index
                                    ? AppColors.white
                                    : Colors.black),
                          ),
                          // SizedBox(width: 10,),
                          widget.controller
                              .selectedFilter
                              .value ==
                              index ?   Spacer() : SizedBox.shrink(),
                          widget.controller
                              .selectedFilter
                              .value ==
                              index ? InkWell(
                              onTap: (){
                                widget.controller
                                    .selectedFilter
                                    .value = 2;
                                widget.controller.restaurantDishFilter();

                                // controller.dishFilter();

                              },
                              child: Icon(Icons.close_rounded,size: 20,)):SizedBox.shrink(),
                        ],
                      ),
                    ),
                  );
                }),
              ),
            ),
          ),
        );

        // return widget.controller.isLoading.value ? const CircularProgressIndicator() : SizedBox(
        //   height: 50,
        //   child: ListView.separated(
        //     scrollDirection: Axis.horizontal,
        //     shrinkWrap: true,
        //     itemBuilder: (context, index) {
        //       return Obx(
        //          () {
        //           return GestureDetector(
        //             onTap: () {
        //                 widget.controller.selectedFilter.value = index;
        //                 // widget.controller.getRestaurantDetails(restaurantId:widget.restaurantId , initial: true);
        //               widget.controller.restaurantDishFilter();
        //             },
        //             child: Chip(
        //               shape: RoundedRectangleBorder(
        //                 borderRadius: BorderRadius.circular(50.0),
        //                 side: const BorderSide(color: Colors.grey),
        //               ),
        //               label: Row(
        //                 mainAxisAlignment: MainAxisAlignment.start,
        //                 mainAxisSize: MainAxisSize.min,
        //                 children: [
        //                   CommonImageView(
        //                     svgPath:widget.controller.chipImages[index],
        //                     color: widget.controller.selectedFilter.value == index ? Colors.white : null,
        //                   ),
        //
        //                   const SizedBox(
        //                     width: 5,
        //                   ),
        //                   Text(
        //                     widget.controller.chipTitles[index],
        //                     style: TextStyle(
        //                       fontSize: 12,
        //                       fontWeight: FontWeight.w600,
        //                       color:
        //                       widget.controller.selectedFilter.value == index ? Colors.white : Colors.black,
        //                     ),
        //                   ),
        //                   SizedBox(width: 10,),
        //                   widget.controller.selectedFilter.value == index? InkWell(
        //                     onTap: (){
        //                       debugPrint("hello");
        //                       widget.controller.selectedFilter.value = 3;
        //                       widget.controller.restaurantDishFilter();
        //                     },
        //                       child: Icon(Icons.close_rounded,size: 20,)):SizedBox.shrink()
        //                 ],
        //               ),
        //               backgroundColor:
        //               widget.controller.selectedFilter.value == index ? AppColors.primaryColor : null,
        //             ),
        //           );
        //         }
        //       );
        //     },
        //     separatorBuilder: (context, index) {
        //       return const SizedBox(
        //         width: 10,
        //       );
        //     },
        //     itemCount: widget.controller.chipTitles.length,
        //   ),
        // );
      }
    );
  }
}

class SearchWidget extends StatefulWidget {
  const SearchWidget({super.key, required this.controller,   this.restaurantData});

  final RestaurantsDetailsController controller;
  final restaurant_list.RestaurantData? restaurantData;

  @override
  SearchWidgetState createState() => SearchWidgetState();
}

class SearchWidgetState extends State<SearchWidget> {
  final SpeechToText _speechToText = SpeechToText();
  bool _speechEnabled = false;
  String _lastWords = '';
  TextEditingController searchController = TextEditingController();
  Color micBackground = const Color(0xff86EAAA);
  double micSize = 60.0;

  @override
  void initState() {
    super.initState();
    _initSpeech();
  }

  void _initSpeech() async {
    _speechEnabled = await _speechToText.initialize();
    setState(() {});
  }

  void _startListening() async {
    log("Started Listening", name: "Voice");
    await _speechToText.listen(
      onResult: _onSpeechResult,
      onSoundLevelChange: _onSoundLevelChange,
    );
    setState(() {});
  }

  void _stopListening() async {
    log("Stopped Listening", name: "Voice");
    await _speechToText.stop();
    searchController.text = _speechToText.isListening
        ? _lastWords
        : _speechEnabled
            ? 'Tap the microphone to start listening...'
            : 'Speech not available';
    setState(() {
      micSize = 60.0;
    });
  }

  void _onSpeechResult(SpeechRecognitionResult result) {
    setState(() {
      log("Speech result = ${result.recognizedWords}", name: "Voice");
      _lastWords = result.recognizedWords;
      searchController.text = result.recognizedWords;
      widget.controller.searchQuery.value = result.recognizedWords;
      widget.controller.restaurantDishFilter();
      micSize = 60.0;
    });
  }

  void _onSoundLevelChange(double level) {
    setState(() {
      log("Level = $level", name: "Voice");
      if (level < 0) {
        micSize = 60.0;
      } else {
        micSize = 60.0 + level * 2;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28),
        color: Colors.white,
      ),
      height: 60,
      width: double.infinity,
      child: Row(
        children: [
          Expanded(
            child: TextFormField(
              onChanged: (value){
                widget.controller.searchQuery.value = value;
                widget.controller.restaurantDishFilter();
              },
              controller: searchController,
              decoration: InputDecoration(
                hintText: "Search in ${ widget.restaurantData?.restaurantDetails?.first.name}",
                hintStyle: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                  color: Color(0xff6C7B88),
                ),
                prefixIcon: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: SvgPicture.asset(
                    "packages/mynewpackage/lib/assets/icons/search-icon.svg",
                  ),
                ),
                prefixIconConstraints: const BoxConstraints(),
                border: const OutlineInputBorder(borderSide: BorderSide.none),
              ),
            ),
          ),
          InkWell(
            splashColor: Colors.transparent,
            onTap: () {

              searchController.text = '';
              _speechToText.isNotListening
                  ? _startListening()
                  : _stopListening();
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeInOutCubicEmphasized,
              height: 60,
              width: micSize,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(28),
                  bottomRight: Radius.circular(28),
                ),
                color: micBackground,
              ),
              child: SvgPicture.asset(
                "packages/mynewpackage/lib/assets/icons/mic-icon.svg",
                height: 20,
                width: 13,
                fit: BoxFit.scaleDown,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class BannerCarousal extends StatefulWidget {
  const BannerCarousal({super.key,required this.controller,   this.restaurantData});

  final RestaurantsDetailsController controller;
  final restaurant_list.RestaurantData? restaurantData;

  @override
  State<BannerCarousal> createState() => _BannerCarousalState();
}

class _BannerCarousalState extends State<BannerCarousal> {
  int activeIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CarouselSlider(
          options: CarouselOptions(
            autoPlay: true,
            // height: MediaQuery.of(context).size.height * 0.29,
            viewportFraction: 1.2,
            aspectRatio: 16 / 8.5,
            onPageChanged: (index, reason) {
              setState(() {
                activeIndex = index;
              });
            },
          ),
          items: [1, 2, 3, 4, 5].map((i) {
            return Builder(
              builder: (BuildContext context) {
                return ClipRRect(
                  borderRadius: BorderRadius.circular(25),
                  child: CommonImageView(
                    width: MediaQuery.of(context).size.width*.9,
                    url:
                    // widget.controller.restaurantDetails.first.bannerImages?.first.image,
                    widget.restaurantData?.bannerImages?.first.image
                  ),
                );
              },
            );
          }).toList(),
        ),
        Positioned(
          bottom: 10,
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Center(
              child: AnimatedSmoothIndicator(
                activeIndex: activeIndex,
                count: 5,
                effect: const WormEffect(
                  activeDotColor: Color(0xFF184568),
                  dotHeight: 10,
                  dotWidth: 10,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class BannerAndRatingWidget extends StatelessWidget {
  const BannerAndRatingWidget({
    super.key,required this.controller, required this.distance,   this.restaurantData
  });

  final RestaurantsDetailsController controller;
  final num distance;
  final restaurant_list.RestaurantData? restaurantData;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(25)),
      child: Stack(
        children: [
          Column(
            children: [
               BannerCarousal(controller: controller,restaurantData:restaurantData),
              Padding(
                padding: const EdgeInsets.only(
                    left: 120, right: 10, top: 10, bottom: 15),
                child: Obx(
                 () {
                    return Column(
                      children: [
                         InkWell(
                           onTap: (){
                             controller.showMore.value = !controller.showMore.value;
                           },
                           child: Wrap(
                             children: [
                               Text(
                                restaurantData?.images?.first.description ?? "",
                                maxLines:controller.showMore.value ? 10: 2,
                                style:  TextStyle(
                                  overflow:!controller.showMore.value ? TextOverflow.ellipsis:null,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14,
                                  color: Color.fromRGBO(69, 84, 97, 1),
                                ),
                                                   ),
                                Text(!controller.showMore.value?"Read More":"Read Less",style: TextStyle(color: AppColors.primaryColor),)
                             ],
                           ),
                         ),
                        Row(
                          children: [
                            Chip(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(80.0),
                                side: const BorderSide(color: Colors.grey),
                              ),
                              label: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  SvgPicture.asset(
                                      "packages/mynewpackage/lib/assets/icons/Star.svg"),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                   Text(
                                    "${restaurantData?.rating}(${Utility.countConverter(restaurantData?.totalRating)})",
                                    style: TextStyle(
                                        fontSize: 10, fontWeight: FontWeight.w600),
                                  )
                                ],
                              ),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Chip(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(80.0),
                                side: const BorderSide(color: Colors.grey),
                              ),
                              label:  Text(
                                "${distance.toStringAsFixed(1)} km",
                                style: const TextStyle(
                                    fontSize: 10, fontWeight: FontWeight.w600),
                              ),
                            ),
                          ],
                        )
                      ],
                    );
                  }
                ),
              ),
            ],
          ),
          Positioned(
            top: 180,
            left: 10,
            child: ClipOval(
              child: Container(
                color: AppColors.white,
                child: Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: ClipOval(
                    child: Image.network(
                        width: 80,
                        height: 80,
                        fit: BoxFit.cover,
                        "${restaurantData?.logo}"),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
