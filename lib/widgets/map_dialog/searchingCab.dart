import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:mynewpackage/app/modules/cab/controllers/cab_map_controller.dart';
import 'package:mynewpackage/widgets/custom_ride_button.dart';

import '../../app/modules/cab/model/cab_states.dart';
import '../../app/modules/home/controllers/home_controller.dart';
import '../../app_colors.dart';
import '../../generated/assets.dart';
import '../common_text.dart';

class SearchingCab extends StatelessWidget {
  SearchingCab({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    HomeController homeController = Get.find();
    CabMapController cabMapController = Get.find();
    debugPrint("inside search cab ${cabMapController.isCancelClicked.value}");
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      child: Obx(() {
        return homeController.isRequestRideLoading.value
            ? Center(child: CircularProgressIndicator())
            : Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CommonText(
                    text: "Finding Your Ride",
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                  ),
                  SvgPicture.asset(
                    "packages/mynewpackage/${Assets.iconsCab}",
                  ),
                  ListTile(
                    leading: SvgPicture.asset(
                      "packages/mynewpackage/${Assets.iconsPickupDriverLoading}",
                    ),
                    title: CommonText(
                      text: 'Pick up',
                      fontSize: 14,
                      textColor: AppColors.textLightColor,
                    ),
                    subtitle: CommonText(
                        // text: homeController.selectedPickUp.value,
                        text: homeController
                            .requestRideData!.originAddress!.first.address
                            .toString(),
                        fontWeight: FontWeight.w500,
                        fontSize: 15),
                  ),
                  ListTile(
                    leading: SvgPicture.asset(
                      "packages/mynewpackage/${Assets.iconsDestinationDriverLoading}",
                    ),
                    title: CommonText(
                      text: 'Drop off',
                      fontSize: 14,
                      textColor: AppColors.textLightColor,
                    ),
                    subtitle: CommonText(
                        // text: homeController.selectedDropOff.value,
                        text: homeController
                            .requestRideData!.destinationAddress!.first.address
                            .toString(),
                        fontWeight: FontWeight.w500,
                        fontSize: 15),
                  ),
                  ListTile(
                    leading: SvgPicture.asset(
                      "packages/mynewpackage/${Assets.iconsDollarCircle}",
                    ),
                    title: CommonText(
                      text: 'Cash',
                    ),
                    subtitle: CommonText(
                      text:
                          "₹ ${homeController.requestRideData?.estimatedPrice}",
                      fontWeight: FontWeight.w500,
                      fontSize: 15,
                    ),
                  ),
                  CustomRideButton(
                      onTap: () {
                        cabMapController.cabStatus(CabStates.canceled);

                        cabMapController.isCancelClicked.value = true;

                        // Navigator.of(context).push(
                        //     MaterialPageRoute(
                        //         builder: (context) =>
                        //     CancelReason()));
                      },
                      text: "Cancel")
                ],
              );
      }),
    );
  }
}
