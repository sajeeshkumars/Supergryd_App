import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mynewpackage/app/modules/cab/controllers/cab_map_controller.dart';
import 'package:mynewpackage/app/modules/cart/controllers/cart_controller.dart';
import 'package:mynewpackage/constants.dart';
import 'package:mynewpackage/widgets/custom_ride_button.dart';

import '../../app_colors.dart';
import '../common_text.dart';

class CancelReason extends StatelessWidget {
  CancelReason({super.key, required this.isFromOrderTrack});

  CabMapController cabMapController = Get.find();
  CartController cartController = Get.find();
  RxBool isFromOrderTrack = false.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SizedBox(
          child: Card(
              color: AppColors.white,
              surfaceTintColor: AppColors.white,
              elevation: 5,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: Icon(Icons.arrow_back)),
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 10,
                        ),
                        CommonText(
                          text: isFromOrderTrack.value
                              ? 'Cancel Order'
                              : 'Cancel Booking',
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                        )
                      ],
                    ),
                    CommonText(
                        text: 'Please select the reason for cancellation'),
                    SizedBox(
                      child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: isFromOrderTrack.value
                              ? cartController.cancelReasons?.length
                              : cabMapController.cancelReasons?.length,
                          itemBuilder: (context, index) {
                            return Row(
                              children: [
                                Obx(
                                  () {
                                    return Radio(
                                      value: index,
                                      activeColor: AppColors.primaryColor,
                                      groupValue: isFromOrderTrack.value
                                          ? cartController
                                              .selectedCancelReason.value
                                          : cabMapController
                                              .selectedCancelReason.value,
                                      onChanged: (value) {
                                        debugPrint("radio clicked");

                                        if (!isFromOrderTrack.value) {
                                          cabMapController.selectedCancelReason
                                              .value = value!;
                                          cabMapController
                                                  .selectedReasonId.value =
                                              cabMapController
                                                  .cancelReasons![index]
                                                  .reasonId!
                                                  .toInt();
                                          cabMapController
                                                  .selectedCancelReasonText
                                                  .value =
                                              cabMapController
                                                  .cancelReasons![index].reason
                                                  .toString();
                                        } else {
                                          cartController.selectedCancelReason
                                              .value = value!;
                                          cartController
                                                  .selectedReasonId.value =
                                              cartController
                                                  .cancelReasons![index]
                                                  .reasonId!
                                                  .toInt();
                                          cartController
                                                  .selectedCancelReasonText
                                                  .value =
                                              cartController
                                                  .cancelReasons![index].reason
                                                  .toString();
                                        }

                                        debugPrint(
                                            "group value ${isFromOrderTrack.value ? cartController.selectedCancelReason.value : cabMapController.selectedCancelReason.value}");
                                        debugPrint("onChange ${value}");
                                      },
                                    );
                                  },
                                ),
                                Flexible(
                                    child: CommonText(
                                  text: isFromOrderTrack.value
                                      ? (cartController
                                          .cancelReasons?[index].reason
                                          .toString() ?? "")
                                      : (cabMapController
                                          .cancelReasons?[index].reason ?? ""),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ))
                              ],
                            );
                          }),
                    ),
                    // SizedBox(height: 10,),

                    // CommonText(text: 'Other',fontSize: 16,fontWeight: FontWeight.w700,),
                    // SizedBox(height: 10,),
                    // TextFormField(
                    //   maxLines: 5,
                    //
                    //   decoration: InputDecoration(
                    //     focusedBorder: OutlineInputBorder(
                    //       borderRadius: BorderRadius.circular(15.0),
                    //       borderSide: BorderSide(
                    //         color: AppColors.borderColor,
                    //       ),
                    //     ),
                    //     enabledBorder: OutlineInputBorder(
                    //       borderRadius: BorderRadius.circular(15.0),
                    //       borderSide: BorderSide(
                    //         color: AppColors.borderColor,
                    //         width: 2.0,
                    //       ),
                    //     ),
                    //     border: InputBorder.none,
                    //     hintText: 'Enter your reason',
                    //     hintStyle: TextStyle(color: AppColors.borderColor),
                    //     fillColor: AppColors.textFieldBackground,
                    //     contentPadding: const EdgeInsets.only(
                    //         left: 14.0, bottom: 6.0, top: 8.0),
                    //
                    //   ),
                    // ),
                    Spacer(),
                    Obx(() {
                      return CustomRideButton(
                          text: isFromOrderTrack.value
                              ? 'Cancel Order'
                              : "Cancel Ride",
                          isLoading: isFromOrderTrack.value
                              ? cartController.isOrderCancelLoading.value
                              : cabMapController.isRideCancelLoading.value,
                          onTap: () {
                            isFromOrderTrack.value
                                ? cartController.cancelOrder(context: context)
                                : cabMapController.cancelRide(
                                    context: context,
                                    requestId: Constants.requestId ?? 0,
                                    reasonId:
                                        cabMapController.selectedReasonId.value,
                                    reason: cabMapController
                                        .selectedCancelReasonText.value);
                          });
                      //   CommonButton(
                      //   isLoading: cabMapController.isRideCancelLoading.value,
                      //     onPressed: (){
                      //   cabMapController.cancelRide(context: context, requestId: Constants.requestId ?? 0, reasonId: cabMapController.selectedReasonId.value, reason: cabMapController.selectedCancelReasonText.value);
                      //
                      // }, text:'Cancel Ride');
                    })
                  ],
                ),
              )),
        ),
      ),
    );
  }
}
