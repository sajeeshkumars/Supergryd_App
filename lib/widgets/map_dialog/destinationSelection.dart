import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:mynewpackage/app/modules/cab/controllers/cab_map_controller.dart';
import 'package:mynewpackage/widgets/custom_button.dart';

import '../../app/modules/home/views/home_view.dart';
import '../../app_colors.dart';
import '../../generated/assets.dart';
import '../common_text.dart';

class DestinationSelection extends StatelessWidget {
  const DestinationSelection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Card(
        color: AppColors.white,
        surfaceTintColor: AppColors.white,
        elevation: 5,
        child: Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            color: Colors.white,
          ),
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CommonText(
                  text: "Where are you going today?",
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                const SizedBox(height: 10),
                Row(
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
                    SizedBox(
                      width: 300,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CommonText(
                            text: "Pick-up",
                            fontSize: 12,
                            textColor: Colors.grey,
                          ),
                          SizedBox(height: 2),
                          InkWell(
                            onTap: () {
                              controller.showLocationSelectionBottomSheet(
                                context: context,
                                locationType: 'PickUp',
                              );
                            },
                            child: Obx(() {
                              return CommonText(
                                text: controller.selectedPickUp.value != ''
                                    ? controller.selectedPickUp.value
                                    : controller.address.value,
                                fontSize: 16,
                                maxLines: 1,
                              );
                            }),
                          ),
                          SizedBox(height: 20),
                          CommonText(
                            text: "Drop off",
                            fontSize: 12,
                            textColor: Colors.grey,
                          ),
                          SizedBox(height: 2),
                          InkWell(
                            onTap: () {
                              controller.showLocationSelectionBottomSheet(
                                  context: context, locationType: '');
                            },
                            child: Obx(() {
                              return CommonText(
                                text: controller.selectedDropOff.value != ''
                                    ? controller.selectedDropOff.value
                                    : 'Where to?',
                                fontSize: 16,
                                maxLines: 1,
                                textOverflow: TextOverflow.ellipsis,
                              );
                            }),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    ElevatedButton.icon(
                      onPressed: () {},
                      icon: SvgPicture.asset(
                          "packages/mynewpackage/${Assets.iconsHomeIcon}"),
                      label: const CommonText(text: "Home"),
                      style: ElevatedButton.styleFrom(
                        surfaceTintColor: AppColors.white,
                        foregroundColor: Colors.black,
                        backgroundColor: Colors.white,
                        side: const BorderSide(color: Colors.grey),
                      ),
                    ),
                    const SizedBox(width: 10),
                    ElevatedButton.icon(
                      onPressed: () {},
                      icon: SvgPicture.asset(
                          "packages/mynewpackage/${Assets.iconsOffice}"),
                      label: const CommonText(text: "Office"),
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.black,
                        backgroundColor: Colors.white,
                        surfaceTintColor: AppColors.white,
                        side: const BorderSide(color: Colors.grey),
                      ),
                    ),
                    const SizedBox(width: 15),
                    InkWell(
                      onTap: () {
                        // controller.isDestinationSelected.value = true;
                      },
                      child: Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                            border: Border.all(color: AppColors.borderColor),
                            borderRadius: BorderRadius.circular(50)),
                        child: Icon(
                          Icons.arrow_forward_ios,
                          size: 10,
                          color: AppColors.borderColor,
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 20),
                const CommonText(
                  text: "Saved Places",
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                SizedBox(
                  height: 150,
                  child: ListView.builder(
                    itemCount: 2,
                    itemBuilder: (BuildContext context, int index) {
                      return const ListTile(
                        leading: Icon(Icons.location_on_outlined),
                        title: CommonText(
                          text: "Heckenackerstraße 18, 75365 Berlin, Germany",
                        ),
                        subtitle: CommonText(text: "dummy text"),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class RideNotFoundWidget extends StatelessWidget {
  const RideNotFoundWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: AppColors.white,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset("packages/mynewpackage/${Assets.iconsRideNotFound}"),
          const CommonText(
            text: "Ride not found",
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
          const SizedBox(height: 20),
          const CommonText(
            text: "Please try again in few minutes",
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: CommonButton(
                onPressed: () {
                  final cabController = Get.find<CabMapController>();
                  cabController.cabStatus(CabStates.initial);
                },
                text: "Try Again"),
          )
        ],
      ),
    );
  }
}
