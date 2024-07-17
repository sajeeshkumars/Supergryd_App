import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mynewpackage/app/modules/cab/controllers/cab_map_controller.dart';
import 'package:mynewpackage/app/modules/home/controllers/home_controller.dart';
import 'package:mynewpackage/app/modules/home/views/home_view.dart';
import 'package:mynewpackage/app_colors.dart';
import 'package:mynewpackage/constants.dart';
import 'package:mynewpackage/widgets/custom_ride_button.dart';
import 'package:mynewpackage/widgets/map_dialog/cancel_reason.dart';

import '../generated/assets.dart';
import 'common_Image_view.dart';
import 'common_text.dart';
import 'custom_button.dart';
import 'map_dialog/RideTypeChoose.dart';
import 'map_dialog/TripDetails.dart';
import 'map_dialog/destinationSelection.dart';
import 'map_dialog/searchingCab.dart';
import 'map_dialog/tripCompleteDialog.dart';

class RideDialog extends StatefulWidget {
  RideDialog({
    super.key,
    required this.onDataReceived,
    required this.onSelected,
  });

  Function onSelected;
  final Function(
    String address,
    double lat,
    double lng,
    String zip,
    String city,
    String state,
    String streetNumber,
    String route,
    String stateIsoCode,
  ) onDataReceived;

  @override
  State<RideDialog> createState() => _RideDialogState();
}

class _RideDialogState extends State<RideDialog> {
  String? zipCode = '';

  String? city = '';

  String? stateName = '';

  String? stateIsoCode = '';

  String? streetNumber = '';

  String? route = '';

  Enum? searchingState;

  HomeController homeController = Get.find();

  List carImage = [
    "packages/mynewpackage/${Assets.iconsNormal}",
    "packages/mynewpackage/${Assets.iconsEconomyCar}",
    "packages/mynewpackage/${Assets.iconsEconomyCar}"
  ];

  @override
  void initState() {
    super.initState();
  }

  RxInt? selectedType = 0.obs;

  RxString selectedPaymentType = 'Apple Pay'.obs;

  RxInt count = 0.obs;

  @override
  Widget build(BuildContext context) {
    final cabController = Get.put(CabMapController());
    controller.selectedDropOff("");
    debugPrint("cabstatus inside mapview ${cabController.cabStatus.value}");
    debugPrint("cancel click ${cabController.isCancelClicked.value}");
    return Obx(() {
      return PopScope(
        canPop: cabController.canExit.value,
        onPopInvoked: (bool) {
          switch (cabController.cabStatus.value) {
            case CabStates.initial:
              cabController.setExitTrue();
              homeController.clearValues();
            case CabStates.loading:
            // TODO: Handle this case.
            case CabStates.rideSelection:
              cabController.cabStatus(CabStates.initial);
            case CabStates.searchingCab:
              cabController.cabStatus(CabStates.rideSelection);
              cabController.setExitFalse();
            case CabStates.accepted:
              cabController.setExitFalse();

            case CabStates.arriving:
              cabController.setExitFalse();

            case CabStates.arrived:
              cabController.setExitFalse();

            case CabStates.otpVerified:
              cabController.setExitFalse();

            case CabStates.inProgress:
              cabController.setExitFalse();

            case CabStates.completed:
              homeController.clearValues();
              cabController.setCabJourneyCompleted;
              cabController.resetRide();
              cabController.setExitTrue();
            case CabStates.canceled:
              cabController.setExitFalse();
            case CabStates.rideNotFound:
              cabController.setExitTrue();
              homeController.clearValues();
            case CabStates.noDriverFound:
              cabController.setExitTrue();
              homeController.clearValues();
          }
        },
        child: SafeArea(
          child: Scaffold(
            // appBar: AppBar(
            //   backgroundColor: Colors.transparent,
            //   surfaceTintColor: Colors.transparent,
            // ),
            body: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: double.infinity,
                color: Colors.white,
                child: Stack(
                  children: [
                    Obx(() {
                      if (cabController.cabStatus == CabStates.completed) {
                        Future.delayed(Duration(seconds: 0), () {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return TripCompleteDialog();
                              });
                        });
                      }
                      return Stack(children: [
                        cabController.customIcon == null
                            ? CircularProgressIndicator()
                            : GoogleMap(
                                initialCameraPosition: CameraPosition(
                                  target: cabController.routeCoordinates[0],
                                  zoom: 17,
                                ),
                                polylines: cabController.polylines,
                                markers: {
                                  Marker(
                                      markerId: MarkerId('car'),
                                      position: cabController
                                          .carMarker.value.position,
                                      icon: cabController.customIcon!),
                                  Marker(
                                      markerId: MarkerId('destination'),
                                      position: cabController
                                          .destinationMarker.value.position),
                                  // Marker(
                                  // markerId: MarkerId('splitPoint'),
                                  // position: LatLng(10.055348, 76.321888),
                                  // icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
                                  // infoWindow: InfoWindow(
                                  // title: 'Split Point',
                                  // snippet: 'This is the split point of the route',
                                  // ),
                                  // )
                                },
                                onMapCreated: (controller) {
                                  log("onMap created called");
                                  setState(() {
                                    cabController.mapController = controller;
                                  });

                                  if (cabController.cabStatus !=
                                      CabStates.completed) {
                                    showBottomSheet(
                                        backgroundColor: Colors.transparent,
                                        enableDrag: false,
                                        context: context,
                                        builder: (context) {
                                          return Obx(() {
                                            return switch (
                                                cabController.cabStatus.value) {
                                              CabStates.initial =>
                                                DestinationSelection(),
                                              CabStates.rideSelection =>
                                                RideTypeChoose(
                                                  rideEstimationList:
                                                      homeController
                                                          .estimationList,
                                                  selectedType: selectedType,
                                                  selectedPaymentType:
                                                      selectedPaymentType,
                                                ),
                                              CabStates.loading =>
                                                CircularProgressIndicator(),
                                              // _ => Container()
                                              // TODO: Handle this case.
                                              CabStates.noDriverFound =>
                                                NoDriverFound(),
                                              CabStates.searchingCab =>
                                                SearchingCab(),
                                              CabStates.accepted =>
                                                TripDetails(),
                                              // buildAcceptedWidget(context,"Meet at the pickup point".obs,false.obs),
                                              CabStates.arriving =>
                                                buildAcceptedWidget(
                                                    context,
                                                    'Your Ride Is On The Way'
                                                        .obs,
                                                    false.obs,
                                                    false.obs),
                                              CabStates.arrived =>
                                                buildAcceptedWidget(
                                                    context,
                                                    'Your Ride Is Here'.obs,
                                                    true.obs,
                                                    false.obs),
                                              CabStates.otpVerified =>
                                                buildAcceptedWidget(
                                                    context,
                                                    'Ongoing Ride'.obs,
                                                    false.obs,
                                                    false.obs),
                                              CabStates.inProgress =>
                                                buildAcceptedWidget(
                                                    context,
                                                    'Ongoing Ride'.obs,
                                                    false.obs,
                                                    true.obs),
                                              CabStates.completed => Container(
                                                  height: 0,
                                                  width: 0,
                                                ),
                                              CabStates.canceled => Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: SizedBox(
                                                    height: 200,
                                                    child: Card(
                                                      elevation: 5,
                                                      color: AppColors.white,
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(15.0),
                                                        child: Column(
                                                          children: [
                                                            CommonText(
                                                              text:
                                                                  "Do you want to cancel the ride? ",
                                                              fontSize: 15,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700,
                                                            ),
                                                            CommonText(
                                                              text:
                                                                  "You won't be charged a cancellation fee",
                                                              textColor: AppColors
                                                                  .textLightColor,
                                                            ),
                                                            Spacer(),
                                                            Row(
                                                              children: [
                                                                Expanded(
                                                                    child:
                                                                        CustomRideButton(
                                                                  text: 'No',
                                                                  onTap: () {
                                                                    cabController
                                                                        .onCabSearch();
                                                                    cabController
                                                                        .isCancelClicked
                                                                        .value = false;

                                                                    cabController
                                                                        .trackRide();
                                                                  },
                                                                )
                                                                    //     CommonButton(onPressed: (){
                                                                    //   cabController.onCabSearch();
                                                                    //   cabController.isCancelClicked.value = false;
                                                                    //
                                                                    //   cabController.trackRide();
                                                                    //
                                                                    //   // Navigator.pop(context);
                                                                    //   // cabController.initial();
                                                                    //
                                                                    // }, text: "No")

                                                                    ),
                                                                SizedBox(
                                                                  width: 5,
                                                                ),
                                                                Expanded(
                                                                    child:
                                                                        CustomRideButton(
                                                                  text:
                                                                      'Yes,Cancel',
                                                                  onTap: () {
                                                                    Navigator.of(
                                                                            context)
                                                                        .push(MaterialPageRoute(
                                                                            builder: (context) =>
                                                                                CancelReason(isFromOrderTrack: false.obs,)));
                                                                  },
                                                                )
                                                                    // CommonButton(onPressed: (){
                                                                    //
                                                                    //   Navigator.of(context).push(
                                                                    //       MaterialPageRoute(
                                                                    //           builder: (context) =>
                                                                    //       CancelReason()));
                                                                    // }, text: "Yes,Cancel")

                                                                    )
                                                              ],
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              CabStates.rideNotFound =>
                                                RideNotFoundWidget(),
                                            };
                                          });
                                        });
                                  }
                                  // TripDetails();
                                },
                              ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: InkWell(
                            child: Align(
                              child: Icon(Icons.arrow_back),
                              alignment: Alignment.topLeft,
                            ),
                            onTap: () {
                              if (cabController.cabStatus.value ==
                                  CabStates.initial) {
                                Navigator.pop(context);
                              } else if (cabController.cabStatus.value ==
                                  CabStates.rideSelection) {
                                Navigator.pop(context);
                              } else if (cabController.cabStatus.value ==
                                  CabStates.searchingCab) {
                                cabController.setExitFalse();
                              } else {
                                cabController.setExitFalse();
                              }
                            },
                          ),
                        ),
                        cabController.cabStatus.value == CabStates.inProgress
                            ? Positioned(
                                bottom: 300,
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: 400,
                                    ),
                                    SvgPicture.asset(
                                        height: 80,
                                        width: 80,
                                        'packages/mynewpackage/${Assets.iconsSos}'),
                                  ],
                                ),
                              )
                            : SizedBox.shrink(),
                      ]);
                    }),
                  ],
                ),
                // child: PlacePicker(
                //   apiKey: 'AIzaSyBkEMGux54F5lqQ7_bXIjWVf5m3jaRdYdk',
                //   initialPosition: const LatLng(9.9816, 76.2999),
                //   resizeToAvoidBottomInset: false,
                //   enableMyLocationButton: false,
                //   enableMapTypeButton: false,

                // introModalWidgetBuilder: (context, result) {
                //   return Positioned(
                //     bottom: 1,
                //     left: 1,
                //     right: 1,
                //     // child: state == SearchingState.Searching
                //     //     ? Container(
                //     //   height: 100,
                //     //   color: Colors.white,
                //     //   width: MediaQuery.of(context).size.width,
                //     //   child: const Center(
                //     //     child: CircularProgressIndicator(),
                //     //   ),
                //     // )
                //     //     :
                //     child: Obx(() {
                //       return controller.isDestinationSelected.value == false
                //           ? const _DestinationSelection()
                //           : controller.isEstimationLoading.value
                //               ? CircularProgressIndicator()
                //               : RideTypeChoose(
                //                   rideEstimationList:
                //                       homeController.estimationList,
                //                   rideType: rideType,
                //                   selectedType: selectedType,
                //                   selectedPaymentType: selectedPaymentType,
                //                 );
                //     }),
                //   );
                // },
              ),
            ),
          ),
        ),
      );
    });
  }

  Widget buildAcceptedWidget(BuildContext context, RxString text,
      RxBool isOtpShow, RxBool rideStarted) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        color: AppColors.white,
        surfaceTintColor: AppColors.white,
        elevation: 10,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Obx(() {
                    return CommonText(
                      text: text.value,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    );
                  }),
                  !isOtpShow.value
                      ? Container(
                          height: 56,
                          width: 50,
                          padding: const EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                            color: AppColors.primaryColor,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Column(
                            children: [
                              CommonText(
                                text: "5",
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                textColor: Colors.white,
                              ),
                              CommonText(
                                text: "Min",
                                fontSize: 12,
                                textColor: Colors.white,
                              ),
                            ],
                          ),
                        )
                      : Row(
                          children: List.generate(
                              4,
                              (index) => Padding(
                                    padding: const EdgeInsets.all(2.0),
                                    child: Container(
                                      height: 56,
                                      width: 50,
                                      padding: const EdgeInsets.all(8.0),
                                      decoration: BoxDecoration(
                                        color: AppColors.primaryColor,
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Center(
                                        child: CommonText(
                                          text: Constants.otp!.split('')[index],
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          textColor: Colors.white,
                                        ),
                                      ),
                                    ),
                                  )),
                        )
                ],
              ),
              SizedBox(height: 20),
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: Stack(
                  alignment: Alignment.center,
                  children: [
                    Positioned(
                      right: -10,
                      bottom: -10,
                      child: CommonImageView(
                        height: 50,
                        width: 50,
                        url: Constants.vehicleImage,
                      ),
                    ),
                    CircleAvatar(
                      backgroundImage: NetworkImage(
                        Constants.driverImage.toString(),
                      ),
                      radius: 50,
                    ),
                  ],
                ),
                title: Row(
                  children: [
                    SizedBox(
                      width: 80,
                    ),
                    CommonText(
                      text: Constants.driverName.toString(),
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ],
                ),
                subtitle: Row(
                  children: [
                    SizedBox(
                      width: 80,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CommonText(
                          text: Constants.vehicleNumber.toString(),
                          fontSize: 18,
                        ),
                        CommonText(
                          text: Constants.vehicleMake.toString() +
                              ' ' +
                              Constants.vehicleModel.toString(),
                          fontSize: 16,
                        ),
                        Row(
                          children: [
                            SvgPicture.asset(
                                "packages/mynewpackage/${Assets.iconsStar}"),
                            CommonText(text: Constants.rating.toString()),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(
                    flex: 3,
                    child: CustomRideButton(
                      text: 'Cancel',
                      onTap: () {
                        CabMapController cabMapController = Get.find();
                        cabMapController.cabStatus(CabStates.canceled);

                        cabMapController.isCancelClicked.value = true;
                      },
                    ),
                  ),
                  !rideStarted.value
                      ? Flexible(
                          child: IconButton(
                            icon: SvgPicture.asset(
                                "packages/mynewpackage/${Assets.iconsMessage}"),
                            onPressed: () {},
                          ),
                        )
                      : SizedBox.shrink(),
                  !rideStarted.value
                      ? Flexible(
                          child: IconButton(
                            icon: SvgPicture.asset(
                                "packages/mynewpackage/${Assets.iconsCall}"),
                            onPressed: () {},
                          ),
                        )
                      : SizedBox.shrink()
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class NoDriverFound extends StatelessWidget {
  const NoDriverFound({
    super.key,
  });

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
            text: "No Driver Found",
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
                  cabController.cabStatus(CabStates.rideSelection);
                },
                text: "Try Again"),
          )
        ],
      ),
    );
  }
}
