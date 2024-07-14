import 'dart:developer';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:mynewpackage/app/modules/cab/controllers/cab_map_controller.dart';
import 'package:mynewpackage/app/modules/cart/controllers/cart_controller.dart';
import 'package:mynewpackage/app/modules/cart/views/cart_view.dart';
import 'package:mynewpackage/app/modules/home/controllers/home_controller.dart';
import 'package:mynewpackage/app/modules/restaurants_and_dishes_listing/data/restaurant_listing_response.dart'
    as restaurant_list;
import 'package:mynewpackage/app/modules/restaurants_and_dishes_listing/views/restaurants_and_dishes_listing_view.dart';
import 'package:mynewpackage/app/modules/restaurants_details/controllers/restaurants_details_controller.dart';
import 'package:mynewpackage/app_colors.dart';
import 'package:mynewpackage/widgets/common_Image_view.dart';
import 'package:mynewpackage/widgets/custom_button.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

import '../../../../generated/assets.dart';
import '../../../../widgets/common_text.dart';
import '../../../core/utility.dart';

class RestaurantsDetailsView extends StatefulWidget {
  const RestaurantsDetailsView(
      {super.key,
      required this.restaurantId,
      required this.distance,
      this.restaurantData});

  final String restaurantId;
  final num distance;
  final restaurant_list.RestaurantData? restaurantData;

  @override
  State<RestaurantsDetailsView> createState() => _RestaurantsDetailsViewState();
}

class _RestaurantsDetailsViewState extends State<RestaurantsDetailsView> {
  RestaurantsDetailsController restaurantsDetailsController =
      Get.put(RestaurantsDetailsController());
  HomeController homeController = Get.find();
  CartController cartController = Get.find();


  @override
  void initState() {
    restaurantsDetailsController.getRestaurantDetails(
        restaurantId: widget.restaurantId, initial: true, context: context);
    Get.lazyPut(() => RestaurantsDetailsController());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        title: CommonText(
          text: widget.restaurantData?.restaurantDetails?.first.name ?? "",
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
        // }),
        backgroundColor: AppColors.backgroundColor,
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await restaurantsDetailsController.getRestaurantDetails(
              restaurantId: widget.restaurantId,
              initial: true,
              context: context);
        },
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [

                 Padding(
                  padding: cartController.cartItems.isNotEmpty ?  EdgeInsets.only(bottom: 100):EdgeInsets.zero ,
                  // padding: EdgeInsets.only(bottom: 100) ,
                  child: SingleChildScrollView(
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            BannerAndRatingWidget(
                              restaurantData: widget.restaurantData,
                              distance: widget.distance,
                              controller: restaurantsDetailsController,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            SearchWidget(
                                controller: restaurantsDetailsController,
                                restaurantData: widget.restaurantData),
                            const SizedBox(
                              height: 20,
                            ),
                            ChipWidget(
                                controller: restaurantsDetailsController,
                                restaurantId: widget.restaurantId),
                            const SizedBox(
                              height: 20,
                            ),
                            Obx(() {
                              return restaurantsDetailsController.isLoading.value
                                  ? const Center(child: SizedBox.shrink())
                                  : restaurantsDetailsController
                                          .restaurantDishList.isNotEmpty
                                      ? Column(
                                        children: [
                                          ListView.separated(
                                              shrinkWrap: true,
                                              physics: const NeverScrollableScrollPhysics(),
                                              itemBuilder: (context, index) {
                                                final dish =restaurantsDetailsController
                                                    .restaurantDishList[index];
                                                int _count = cartController.cartItems.firstWhereOrNull((item) => item.productId == dish.id)?.quantity?.toInt() ?? 0;

                                                    return DishCard(
                                                      count:_count.obs,
                                                      restaurantsDetailsController:
                                                          restaurantsDetailsController,
                                                      restaurant: restaurantsDetailsController
                                                          .restaurantDishList[index],
                                                      index: index,
                                                      isDishes: false, storeId: restaurantsDetailsController.restaurantDishList[index].storeId!.toInt()
                                                    );
                                              },
                                              separatorBuilder: (context, index) {
                                                return const SizedBox(
                                                  height: 10,
                                                );
                                              },
                                              itemCount: restaurantsDetailsController
                                                  .restaurantDishList.length,
                                            ),



                                        ],
                                      )
                                      : Center(
                                          child: Column(
                                          children: [
                                            ColorFiltered(
                                              colorFilter: ColorFilter.mode(
                                                  AppColors.primaryColor,
                                                  BlendMode.modulate),
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
                                            CommonText(
                                              text:
                                                  "We're currently out of ${restaurantsDetailsController.selectedFilter.value == 0 ? "Veg" : "Non Veg"} items, but our ${restaurantsDetailsController.selectedFilter.value == 1 ? "Veg" : "Non Veg"} selection is sizzling! Take a look!",
                                              textAlign: TextAlign.center,
                                              fontWeight: FontWeight.w800,
                                            ),
                                          ],
                                        ));
                            })
                          ],
                        ),
                      ),
                    ),
                  ),
                ),

                  Obx(
                  () {
                    return cartController.cartItems.isEmpty ? SizedBox.shrink(): Container(
                      height: 100,
                        decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey,
                                offset: Offset(0.0, 1.0), //(x,y)
                                blurRadius: 2.0,
                              ),
                            ],
                            color: AppColors.white,
                            borderRadius: BorderRadius.only(topLeft: Radius.circular(25),topRight: Radius.circular(25))
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Expanded(child: Obx(
                                 () {
                                  return cartController.isAddToCartLoading.value ? Center(child: CircularProgressIndicator()): CommonText(text: 'Total ₹${cartController.addToCartResponse?.data?.cartMeta?.cartTotal}',fontWeight: FontWeight.w700,);
                                }
                              )),
                              Expanded(child:
                                   CommonButton(
                                    onPressed: () {
                                     cartController. viewCart(context: context);
                                     Navigator.of(context).push(
                                         MaterialPageRoute(
                                             builder: (context) =>
                                                 CartView()));


                                  }, text: 'View Cart',))

                            ],
                          ),
                        ),
                      );
                  }
                )

          ],
        ),
      ),
    );
  }
}

class ChipWidget extends StatefulWidget {
  const ChipWidget({
    super.key,
    required this.controller,
    required this.restaurantId,
  });

  final RestaurantsDetailsController controller;
  final String restaurantId;

  @override
  State<ChipWidget> createState() => _ChipWidgetState();
}

class _ChipWidgetState extends State<ChipWidget> {
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return widget.controller.isLoading.value
          ? const Center(child: CircularProgressIndicator())
          : Row(
              children: List.generate(
                widget.controller.chipTitles.length,
                (index) => Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    splashFactory: NoSplash.splashFactory,
                    onTap: () {
                      widget.controller.isSelected.value =
                          !widget.controller.isSelected.value;
                      if (widget.controller.isSelected.value) {
                        widget.controller.selectedFilter.value = index;
                        widget.controller.restaurantDishFilter();
                      } else {
                        widget.controller.selectedFilter.value = 2;
                        widget.controller.restaurantDishFilter();
                      }
                      // controller. dishFilter();
                    },
                    child: Obx(() {
                      return Container(
                        height: 35,
                        width: 110,
                        decoration: BoxDecoration(

                          borderRadius: const BorderRadius.all(
                            Radius.circular(40),
                          ),
                          border: Border.all(
                            color:
                                widget.controller.selectedFilter.value == index
                                    ? AppColors.primaryColor
                                    : AppColors.borderColor,
                            width:
                                widget.controller.selectedFilter.value == index
                                    ? 1.5
                                    : 1,
                            style: BorderStyle.solid,
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 5, vertical: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                  widget.controller.chipImages[index]),
                              CommonText(
                                text: widget.controller.chipTitles[index],
                                fontSize: 12,
                                textColor: Colors.black,
                              ),
                              // SizedBox(width: 10,),
                              widget.controller.selectedFilter.value == index
                                  ? const Spacer()
                                  : const SizedBox.shrink(),
                              widget.controller.selectedFilter.value == index
                                  ? InkWell(
                                      splashColor: Colors.transparent,
                                      onTap: () {
                                        widget.controller.isSelected.value =
                                            !widget.controller.isSelected.value;
                                        if (widget
                                            .controller.isSelected.value) {
                                          widget.controller.selectedFilter
                                              .value = index;
                                          widget.controller
                                              .restaurantDishFilter();
                                        } else {
                                          widget.controller.selectedFilter
                                              .value = 2;
                                          widget.controller
                                              .restaurantDishFilter();
                                        }
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
            );

    });
  }
}

class SearchWidget extends StatefulWidget {
  const SearchWidget(
      {super.key, required this.controller, this.restaurantData});

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
              onChanged: (value) {
                widget.controller.searchQuery.value = value;
                widget.controller.restaurantDishFilter();
              },
              controller: searchController,
              decoration: InputDecoration(
                hintText:
                    "Search in ${widget.restaurantData?.restaurantDetails?.first.name}",
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
                color: AppColors.accentColor,
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
  const BannerCarousal(
      {super.key, required this.controller, this.restaurantData});

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
          items: widget.restaurantData?.bannerImages?.map((banner) {
                return Builder(
                  builder: (BuildContext context) {
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(25),
                      child: CommonImageView(
                        width: MediaQuery.of(context).size.width * .9,
                        url: banner.image,
                      ),
                    );
                  },
                );
              }).toList() ??
              [],
        ),
        Positioned(
          bottom: 10,
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Center(
              child: AnimatedSmoothIndicator(
                activeIndex: activeIndex,
                count: widget.restaurantData?.bannerImages?.length ?? 0,
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
  const BannerAndRatingWidget(
      {super.key,
      required this.controller,
      required this.distance,
      this.restaurantData});

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
              restaurantData?.bannerImages?.first.image != ""
                  ? BannerCarousal(
                      controller: controller, restaurantData: restaurantData)
                  : SizedBox.shrink(),
              Padding(
                padding: const EdgeInsets.only(
                    left: 120, right: 10, top: 10, bottom: 15),
                child: Obx(() {
                  return Column(
                    children: [
                      InkWell(
                        onTap: () {
                          controller.showMore.value =
                              !controller.showMore.value;
                        },
                        child: Wrap(
                          children: [
                            CommonText(
                              text: restaurantData?.images?.first.description ??
                                  "",
                              maxLines: controller.showMore.value ? 10 : 2,
                              textOverflow: !controller.showMore.value
                                  ? TextOverflow.ellipsis
                                  : null,
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                              textColor: const Color.fromRGBO(69, 84, 97, 1),
                            ),
                            CommonText(
                                text: !controller.showMore.value
                                    ? "Read More"
                                    : "Read Less",
                                textColor: AppColors.primaryColor)
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
                                CommonText(
                                    text:
                                        '${restaurantData?.rating}(${Utility.countConverter(restaurantData!.totalRating!.toInt())})',
                                    fontSize: 10,
                                    fontWeight: FontWeight.w600)
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
                            label: CommonText(
                                text: "${distance.toStringAsFixed(1)} km",
                                fontSize: 10,
                                fontWeight: FontWeight.w600),
                          ),
                        ],
                      )
                    ],
                  );
                }),
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
