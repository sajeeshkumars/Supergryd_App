import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:mynewpackage/constants.dart';
import 'package:mynewpackage/widgets/map_dialog/searchingCab.dart';

import '../../app/modules/home/data/models/ride_estimation_response.dart';
import '../../app/modules/home/views/home_view.dart';
import '../../app/modules/promo_code_listing/views/promo_code_listing_view.dart';
import '../../app_colors.dart';
import '../../generated/assets.dart';
import '../common_text.dart';

class RideTypeChoose extends StatelessWidget {
  const RideTypeChoose({
    super.key,
    required this.selectedType,
    required this.selectedPaymentType,
    required this.rideEstimationList,
  });

  final RxInt? selectedType;
  final RxString selectedPaymentType;
  final RxList<RideEstimationList> rideEstimationList;

  @override
  Widget build(BuildContext context) {
    final totalPrice = rideEstimationList.first.estimation?.estimate.obs;
    controller.productId =
        (rideEstimationList.first.estimation!.productId ?? "").obs;
    controller.fareId =
        (rideEstimationList.first.estimation?.fareId.toString() ?? "").obs;
    controller.price =
        (rideEstimationList.first.estimation?.estimate?.toDouble() ?? 0.0).obs;
    controller.rideDuration.value = rideEstimationList.first.estimation!.duration!.toDouble();
    controller.rideDistance.value = rideEstimationList.first.estimation!.distance.toString();

    // controller.rideDistance =
    //     (rideEstimationList.first.estimation!.distance.toString()).obs;
    //
    // controller.rideDuration =
    //     (rideEstimationList.first.estimation!.duration.toString()).obs;
    //
    // controller.carType =
    //     (rideEstimationList.first.estimation!.localizedDisplayName.toString())
    //         .obs;

    // controller.seatCapacity =
    //     (rideEstimationList.first.capacity.toString()).obs;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Obx(() {
        return Card(
            color: AppColors.white,
            surfaceTintColor: AppColors.white,
            elevation: 5,
            child: controller.isRequestSent.value == false
                ? Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                color: Colors.white,
              ),
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.symmetric(
                  vertical: 24, horizontal: 20),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const CommonText(
                      text: "Choose your ride",
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      height: 250,
                      child: ListView.builder(
                        itemCount: rideEstimationList.length,
                        itemBuilder: (context, index) {
                          final isSelected = selectedType?.value == index;
                          debugPrint("index ${index}");
                          debugPrint("radio ${selectedType?.value}");

                          return Card(
                            elevation: 1,
                            surfaceTintColor: AppColors.white,
                            color: AppColors.white,
                            child: ListTile(
                              shape: isSelected
                                  ? RoundedRectangleBorder(
                                side: BorderSide(
                                    color: AppColors.primaryColor,
                                    width: 1),
                                borderRadius:
                                BorderRadius.circular(10),
                              )
                                  : null,
                              tileColor: isSelected
                                  ? AppColors.primaryColor.withOpacity(.1)
                                  : AppColors.white,
                              leading: SvgPicture.network(
                                  rideEstimationList[index]
                                      .image
                                      .toString()),
                              title: CommonText(
                                text: rideEstimationList[index]
                                    .name
                                    .toString(),
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                              subtitle: Row(
                                children: [
                                  CommonText(
                                      text:
                                      "₹ ${rideEstimationList[index].estimation!.estimate.toString()}",
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600),
                                  const SizedBox(
                                    width: 3,
                                  ),
                                  SvgPicture.asset(
                                      "packages/mynewpackage/${Assets.iconsClock}",
                                      color: AppColors.textLightColor),
                                  CommonText(
                                    text:
                                    '${(rideEstimationList[index].estimation!.duration!/60).toStringAsFixed(2)} min',
                                    fontSize: 12,
                                    textColor: AppColors.textLightColor,
                                  ),
                                  const SizedBox(
                                    width: 3,
                                  ),
                                  SvgPicture.asset(
                                    "packages/mynewpackage/${Assets.iconsSeats}",
                                    color: AppColors.textLightColor,
                                  ),
                                  CommonText(
                                    text:
                                    '${rideEstimationList[index].capacity.toString()} Seats',
                                    fontSize: 12,
                                    textColor: AppColors.textLightColor,
                                  ),
                                ],
                              ),
                              trailing: SizedBox(
                                height: 23,
                                width: 23,
                                child: Obx(() {
                                  return Radio(
                                      activeColor: AppColors.primaryColor,
                                      value: index,
                                      groupValue: selectedType?.value,
                                      onChanged: (value) {
                                        totalPrice?.value =
                                            rideEstimationList[index]
                                                .estimation!
                                                .estimate!
                                                .toDouble();
                                        controller.price.value =
                                            rideEstimationList[index]
                                                .estimation!
                                                .estimate!
                                                .toDouble();
                                        debugPrint("price of ride ${controller.price.value}");
                                        controller.fareId.value =
                                            rideEstimationList[index]
                                                .estimation!
                                                .fareId
                                                .toString();
                                        controller.productId.value =
                                            rideEstimationList[index]
                                                .estimation!
                                                .productId
                                                .toString();
                                        controller.rideDuration.value =  rideEstimationList[index].estimation!.duration!.toDouble();
                                        controller.rideDistance.value = rideEstimationList[index].estimation!.distance.toString();
                                        selectedType?.value = value!;
                                      });
                                }),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .02,
                    ),
                    Row(
                      children: [
                        Obx(() {
                          return DropdownButton<String>(
                            icon: const Icon(Icons.keyboard_arrow_down),
                            value: selectedPaymentType.value,
                            onChanged: (String? newValue) {
                              selectedPaymentType.value = newValue!;
                            },
                            items: <String>['Apple Pay', 'Card', 'Cash']
                                .map<DropdownMenuItem<String>>(
                                    (String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: CommonText(
                                      text: value,
                                      fontSize: 12,
                                    ),
                                  );
                                }).toList(),
                          );
                        }),
                        Spacer(),
                        InkWell(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) =>
                                const PromoCodeListingView()));
                          },
                          child: Container(
                            height: 40,
                            // width: 100,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25),
                                border: Border.all(
                                    color: AppColors.borderColor)),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  SvgPicture.asset(
                                    "packages/mynewpackage/${Assets.iconsOfferIcon}",
                                    height: 15,
                                  ),
                                  const SizedBox(
                                    width: 2,
                                  ),
                                  const CommonText(
                                    text: "Promo code",
                                    fontSize: 12,
                                  )
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                              AppColors.primaryColor),
                          minimumSize:
                          MaterialStateProperty.all(Size(340, 70)),
                        ),
                        onPressed: () {
                          controller.requestRide();
                        },
                        child: Row(
                          children: [
                            CommonText(
                              text: "Request",
                              textColor: AppColors.white,
                            ),

                            ///price
                            Spacer(),
                            CommonText(
                                text: "₹ ${totalPrice}",
                                textColor: AppColors.white),
                            SizedBox(
                              width: 10,
                            ),
                            Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                  color: AppColors.white,
                                  borderRadius:
                                  BorderRadius.circular(30)),
                              child: Icon(
                                Icons.arrow_forward_ios,
                                color: AppColors.primaryColor,
                              ),
                            )
                          ],
                        ))
                  ],
                ),
              ),
            )
                : SearchingCab(
            ));
      }),
    );
  }
}
