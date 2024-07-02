
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../app/modules/cab/controllers/cab_map_controller.dart';
import '../../app/modules/history/views/history_view.dart';
import '../../app/modules/home/controllers/home_controller.dart';
import '../../app/modules/home/views/home_view.dart';
import '../../app/modules/trip_rating/views/trip_rating_view.dart';
import '../../app_colors.dart';
import '../../constants.dart';
import '../../generated/assets.dart';
import '../common_Image_view.dart';
import '../common_text.dart';
import '../custom_button.dart';

class TripCompleteDialog extends StatefulWidget {
  TripCompleteDialog({super.key});

  @override
  State<TripCompleteDialog> createState() => _TripCompleteDialogState();
}

class _TripCompleteDialogState extends State<TripCompleteDialog> {
  CabMapController cabMapController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 5),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SvgPicture.asset(
                  "packages/mynewpackage/${Assets.iconsSuccess}",
                  height: 60,
                  width: 60,
                ),
                SizedBox(
                  height: 5,
                ),
                CommonText(
                  text: "Michael",
                  fontSize: 16,
                ),
                SizedBox(
                  height: 5,
                ),
                CommonText(
                  text: 'Your Ride Completed',
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
                SizedBox(
                  height: 5,
                ),
                CommonText(
                  text: 'ID123456789',
                  fontWeight: FontWeight.w600,
                  textColor: AppColors.primaryColor,
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CommonText(
                      text: 'Wallet Balance',
                      fontWeight: FontWeight.w600,
                    ),
                    CommonText(
                      text: ' \$95.85',
                      fontWeight: FontWeight.w600,
                      textColor: Colors.red,
                    ),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                SizedBox(
                  width: 200,
                  child: CommonButton(
                    onPressed: () {},
                    text: "Add Cash to Wallet",
                    hasForwardArrow: true,
                    textSize: 12,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        "packages/mynewpackage/${Assets.iconsDateRangeLight}",
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * .01,
                      ),
                      const CommonText(text: "28 May 2024"),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * .045,
                      ),
                      SvgPicture.asset(
                        "packages/mynewpackage/${Assets.iconsClock}",
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * .01,
                      ),
                      const CommonText(text: "10:45AM"),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * .045,
                      ),
                      SvgPicture.asset(
                        "packages/mynewpackage/${Assets.iconsDollarCircle}",
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * .01,
                      ),
                      CommonText(text: '₹ ${controller.price.value}'),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        children: [
                          SvgPicture.asset(
                            "packages/mynewpackage/${Assets.iconsStartLocation}",
                            height: 24,
                            width: 24,
                          ),
                          Container(
                            height: 40,
                            width: 1,
                            color: Colors.blue,
                          ),
                          SvgPicture.asset(
                            "packages/mynewpackage/${Assets.iconsDestinationIcon}",
                            height: 24,
                            width: 24,
                          ),
                        ],
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CommonText(
                              text: "Pick-up",
                              fontSize: 12,
                              textColor: Colors.grey,
                            ),
                            SizedBox(height: 2),
                            CommonText(
                              text: '${controller.selectedPickUp.value}',
                              fontSize: 14,
                              textOverflow:
                              TextOverflow.ellipsis, // Handle overflow
                            ),
                            SizedBox(height: 20),
                            CommonText(
                              text: "Drop off ",
                              fontSize: 12,
                              textColor: Colors.grey,
                            ),
                            SizedBox(height: 2),
                            CommonText(
                              text: '${controller.selectedDropOff.value}',
                              fontSize: 14,
                              textOverflow:
                              TextOverflow.ellipsis, // Handle overflow
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                ListTile(
                  leading: const CircleAvatar(),
                  title: Row(
                    children: [
                      CommonText(
                        text: Constants.driverName.toString(),
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                      ),
                      Spacer(),
                      CommonText(
                        text: 'Your trip fare',
                        fontSize: 12,
                      ),
                      SizedBox(
                        width: 3,
                      ),
                      CommonText(
                        text: '₹ ${controller.price.value}',
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ],
                  ),
                  subtitle: Row(
                    children: [
                      SvgPicture.asset(
                        "packages/mynewpackage/${Assets.iconsStar}",
                        height: 12,
                        width: 12,
                      ),
                      CommonText(text: Constants.rating.toString()),
                      Spacer(),
                      CommonText(
                        text: "Payment Option",
                        fontSize: 12,
                      ),
                      SizedBox(
                        width: 3,
                      ),
                      CommonText(
                        text: "Apple Pay",
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => const HistoryView()));
                          },
                          child: Container(
                            height: 45,
                            width: 169,
                            decoration: BoxDecoration(
                                border:
                                Border.all(color: AppColors.borderColor)),
                            child: Center(
                              child: CommonText(
                                text: "Booking History",
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => const TripRatingView()));
                          },
                          child: Container(
                            height: 45,
                            width: 169,
                            decoration: BoxDecoration(
                                border:
                                Border.all(color: AppColors.borderColor)),
                            child: Center(
                              child: CommonText(
                                text: "Rate this ride",
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      CommonText(
                        text: 'Recommended Services',
                        fontWeight: FontWeight.w700,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 200,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: controller.recommendedServices.length,
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
                                text: controller.recommendedServices[index]
                                    .toString(),
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                TextButton(
                    onPressed: () {
                      // Navigator.of(context).pop();
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => HomeView()),
                            (route) => false,
                      );

                      CabMapController cabMapController = Get.find();
                      HomeController homeController = Get.find();

                      cabMapController.resetRide();
                      homeController.clearValues();
                    },
                    child: CommonText(
                      text: 'Close',
                      textColor: Colors.black,
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}