import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:mynewpackage/app/modules/cab/controllers/cab_map_controller.dart';

import '../../app/modules/home/controllers/home_controller.dart';
import '../../app_colors.dart';
import '../../generated/assets.dart';
import '../common_text.dart';
import '../custom_button.dart';
import 'cancel_reason.dart';

class SearchingCab extends StatelessWidget {
   SearchingCab({
    super.key,
    required this.homeController,
  });

  final HomeController homeController;
  CabMapController cabMapController = Get.find();

  @override
  Widget build(BuildContext context) {
    debugPrint("inside search cab ${cabMapController.isCancelClicked.value}");
    return  Padding(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      child: Column(
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
                text: homeController.selectedPickUp.value,
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
                text: homeController.selectedDropOff.value,
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
              text: "₹ ${homeController.price.value.toString()}",
              fontWeight: FontWeight.w500,
              fontSize: 15,
            ),
          ),
          CommonButton(onPressed: () {
            cabMapController.isCancelClicked.value = true;
            cabMapController.onCancel();

            // Navigator.of(context).push(
            //     MaterialPageRoute(
            //         builder: (context) =>
            //     CancelReason()));

          }, text: "Cancel")
        ],
      ),
    );
  }
}
