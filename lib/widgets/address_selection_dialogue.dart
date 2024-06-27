import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mynewpackage/app/modules/cab/controllers/cab_map_controller.dart';
import 'package:mynewpackage/app/modules/history/views/history_view.dart';
import 'package:mynewpackage/app/modules/home/controllers/home_controller.dart';
import 'package:mynewpackage/app/modules/home/data/models/ride_estimation_response.dart';
import 'package:mynewpackage/app/modules/home/views/home_view.dart';
import 'package:mynewpackage/app/modules/trip_rating/views/trip_rating_view.dart';
import 'package:mynewpackage/app_colors.dart';
import 'package:mynewpackage/widgets/custom_button.dart';

import '../app/modules/promo_code_listing/views/promo_code_listing_view.dart';
import '../generated/assets.dart';
import 'common_Image_view.dart';
import 'common_text.dart';

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
  Timer? _timer;
  int _markerIndex = 0; // Index of the current position in _routeCoordinates
  GoogleMapController? _controller;

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
  final Set<Polyline> _polylines = {};
  final List<LatLng> _routeCoordinates = [
    LatLng(10.048726, 76.318781),
    LatLng(10.050847, 76.319333),
    LatLng(10.051901, 76.31972),
    LatLng(10.05229, 76.319835),
    LatLng(10.052395, 76.320123),
    LatLng(10.053021, 76.321193),
    LatLng(10.054492, 76.321823),
    LatLng(10.054967, 76.321889),
    LatLng(10.055238, 76.321951),
    LatLng(10.055348, 76.321888), // Splitting point
    LatLng(10.055348, 76.321888), // Splitting point
    LatLng(10.055348, 76.321888),
    LatLng(10.05584, 76.322294),
    LatLng(10.057875, 76.324598),
    LatLng(10.060516, 76.326551),
    LatLng(10.06415, 76.329083),
    LatLng(10.066537, 76.335756),
    LatLng(10.066508, 76.335625),
    LatLng(10.067714, 76.339166),
    LatLng(10.068647, 76.342179),
    LatLng(10.068624, 76.343715),
    LatLng(10.068364, 76.344748),
    LatLng(10.068021, 76.34584),
    LatLng(10.067678, 76.347257),
    LatLng(10.066707, 76.350607),
    LatLng(10.066522, 76.351306),
    LatLng(10.06642, 76.351764),
    LatLng(10.065774, 76.351721),
    LatLng(10.065171, 76.351757),
    LatLng(10.06474, 76.351739),
    LatLng(10.064588, 76.351151),
  ];
  BitmapDescriptor? _carIcon; // Custom BitmapDescriptor for the car marker icon

  Marker _carMarker = Marker(
    markerId: MarkerId('car'),
    position: LatLng(10.048726, 76.318781), // Starting position
    // Use a default icon until the custom icon is loaded
    // icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure),
  );
  // void _startMovingMarker() {
  //   // Set up a timer to update the position of the marker every second
  //   _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
  //     setState(() {
  //       if (_markerIndex < _routeCoordinates.length - 1) {
  //         _markerIndex++;
  //         _carMarker = _carMarker.copyWith(
  //           positionParam: _routeCoordinates[_markerIndex],
  //         );
  //       } else {
  //         _timer?.cancel();
  //       }
  //     });
  //   });
  // }

  @override
  void initState() {
    super.initState();
    // _setPolylines();
    // _loadCarIcon(); // Load the custom car icon
    // _startMovingMarker();
  }

  // void _setPolylines() {
  //   // Split _routeCoordinates based on LatLng(10.055348, 76.321888)
  //   int splitIndex = _routeCoordinates.indexWhere(
  //       (coord) => coord.latitude == 10.055348 && coord.longitude == 76.321888);
  //
  //   List<LatLng> firstPart = _routeCoordinates.sublist(0, splitIndex);
  //   List<LatLng> secondPart = _routeCoordinates.sublist(splitIndex);
  //
  //   setState(() {
  //     _polylines.add(
  //       Polyline(
  //         polylineId: PolylineId('route1'),
  //         visible: true,
  //         points: firstPart,
  //         width: 4,
  //         color: Colors.black,
  //       ),
  //     );
  //     _polylines.add(
  //       Polyline(
  //         polylineId: PolylineId('route2'),
  //         visible: true,
  //         points: secondPart,
  //         width: 4,
  //         color: Colors.red,
  //       ),
  //     );
  //   });
  // }

  // Method to load custom marker icon from assets
  // void _loadCarIcon() async {
  //   _carIcon = await BitmapDescriptor.asset(
  //     const ImageConfiguration(size: Size(30, 30)), // Adjust size as needed
  //     'assets/images-removebg-preview.png', // Replace with your image path
  //   );
  //   setState(() {
  //     // Set state to rebuild the widget with the loaded icon
  //   });
  // }

  List rideType = ["Normal", "Economy", "Comfort"];

  List time = ["2", "4", "6"];

  List seat = ["2", "5", "6"];

  List price = ["1.99", "2", "3.6"];

  RxInt? selectedType = 0.obs;

  RxString selectedPaymentType = 'Apple Pay'.obs;

  RxInt count = 0.obs;

  @override
  Widget build(BuildContext context) {
    final cabController = Get.put(CabMapController());
    controller.selectedDropOff("");
    cabController.resetRide();
    return Obx(() {
      return PopScope(
        // canPop: false,
        canPop: cabController.canExit.value,
        onPopInvoked: (bool) {
          // controller.isRequestSent.value = false;
          // controller.isDestinationSelected.value = false;
          switch (cabController.cabStatus.value) {
            case CabStates.initial:
              cabController.setExitTrue();
            case CabStates.loading:
            // TODO: Handle this case.
            case CabStates.rideSelection:
              cabController.cabStatus(CabStates.initial);
            case CabStates.searchingCab:
              cabController.cabStatus(CabStates.rideSelection);
            case CabStates.cabAllocated:
              cabController.setExitTrue();
            case CabStates.cabApproachingPassenger:
              cabController.setExitTrue();

            case CabStates.cabArrived:
              cabController.setExitTrue();

            case CabStates.cabStartedJourney:
              cabController.setExitTrue();

            case CabStates.cabReachedDestination:
              cabController.setExitTrue();
          }
        },
        child: SafeArea(
          child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(),
            body: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: double.infinity,
                color: Colors.white,
                child: Stack(
                  children: [
                    Obx(() {
                      if (cabController.cabStatus ==
                          CabStates.cabReachedDestination) {
                        Future.delayed(Duration(seconds: 0), () {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return TripCompleteDialog();
                              });
                        });
                      }
                      return GoogleMap(
                        initialCameraPosition: CameraPosition(
                          target: cabController.routeCoordinates[0],
                          zoom: 12,
                        ),
                        polylines: cabController.polylines,
                        markers: {
                          Marker(
                            markerId: MarkerId('car'),
                            position: cabController.carMarker.value.position,
                            // icon: _carIcon!,
                          ),
                        },
                        onMapCreated: (controller) {
                          log("onMap created called");
                          setState(() {
                            _controller = controller;
                          });
                          if (cabController.cabStatus !=
                              CabStates.cabStartedJourney) {
                            showBottomSheet(
                                context: context,
                                builder: (context) {
                                  return Obx(() {
                                    if (cabController.cabStatus ==
                                        CabStates.cabStartedJourney) {
                                      Future.delayed(Duration(seconds: 1), () {
                                        Navigator.pop(context);
                                      });
                                    }
                                    return switch (
                                        cabController.cabStatus.value) {
                                      CabStates.initial =>
                                        _DestinationSelection(),
                                      CabStates.rideSelection => RideTypeChoose(
                                          rideEstimationList:
                                              homeController.estimationList,
                                          rideType: rideType,
                                          selectedType: selectedType,
                                          selectedPaymentType:
                                              selectedPaymentType,
                                        ),
                                      CabStates.loading =>
                                        CircularProgressIndicator(),
                                      // _ => Container()
                                      // TODO: Handle this case.
                                      CabStates.searchingCab => InkWell(
                                          onTap: () {
                                            cabController.setCabAllocated();
                                          },
                                          child: const FindingDriver()),
                                      // _ => Container(),

                                      CabStates.cabAllocated => InkWell(
                                          onTap: () {},
                                          child: const FindingDriver()),
                                      CabStates.cabApproachingPassenger =>
                                        InkWell(
                                            onTap: () {},
                                            child: const FindingDriver()),
                                      CabStates.cabArrived => InkWell(
                                          onTap: () {},
                                          child: const FindingDriver()),
                                      CabStates.cabStartedJourney => Container(
                                          height: 0,
                                          width: 0,
                                        ),
                                      CabStates.cabReachedDestination =>
                                        Container(
                                          height: 0,
                                          width: 0,
                                        ),
                                    };
                                  });
                                });
                          }
                        },
                      );
                    }),

                    // RideTypeChoose(
                    //   rideEstimationList: homeController.estimationList,
                    //   rideType: rideType,
                    //   selectedType: selectedType,
                    //   selectedPaymentType: selectedPaymentType,
                    // ),
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
}

class RideTypeChoose extends StatelessWidget {
  const RideTypeChoose({
    super.key,
    required this.rideType,
    required this.selectedType,
    required this.selectedPaymentType,
    required this.rideEstimationList,
  });

  final List rideType;
  final RxInt? selectedType;
  final RxString selectedPaymentType;
  final RxList<RideEstimationList> rideEstimationList;

  @override
  Widget build(BuildContext context) {
    final isDriverLoaded = false.obs;
    final totalPrice = rideEstimationList.first.estimation?.estimate.obs;
    controller.productId =
        (rideEstimationList.first.estimation!.productId ?? "").obs;
    controller.fareId =
        (rideEstimationList.first.estimation?.fareId.toString() ?? "").obs;
    controller.price =
        (rideEstimationList.first.estimation?.estimate?.toDouble() ?? 0.0).obs;

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
                            height: 150,
                            child: ListView.builder(
                              itemCount: rideEstimationList.length,
                              itemBuilder: (context, index) {
                                return Card(
                                  elevation: 1,
                                  surfaceTintColor: AppColors.white,
                                  color: AppColors.white,
                                  child: ListTile(
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
                                            color: AppColors.borderColor),
                                        // Icon(Icons.access_time,size: 16,color: AppColors.borderColor,),
                                        CommonText(
                                          text:
                                              '${rideEstimationList[index].estimation!.duration.toString()} min',
                                          fontSize: 12,
                                          textColor: AppColors.borderColor,
                                        ),
                                        const SizedBox(
                                          width: 3,
                                        ),

                                        // Icon(Icons.person_pin,color: AppColors.borderColor,size: 16,),
                                        SvgPicture.asset(
                                          "packages/mynewpackage/${Assets.iconsSeats}",
                                          color: AppColors.borderColor,
                                        ),

                                        CommonText(
                                          text:
                                              '${rideEstimationList[index].capacity.toString()} Seats',
                                          fontSize: 12,
                                          textColor: AppColors.borderColor,
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
                          Row(
                            children: [
                              SvgPicture.asset(
                                "packages/mynewpackage/${Assets.iconsKilometer}",
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * .01,
                              ),
                              CommonText(
                                  text:
                                      "${rideEstimationList.first.estimation?.distance} km"),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * .15,
                              ),
                              SvgPicture.asset(
                                "packages/mynewpackage/${Assets.iconsClock}",
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * .01,
                              ),
                              CommonText(
                                  text:
                                      "${rideEstimationList.first.estimation?.duration} min"),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * .15,
                              ),

                              ///price tag
                              SvgPicture.asset(
                                "packages/mynewpackage/${Assets.iconsDollarCircle}",
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * .01,
                              ),
                              CommonText(text: '${totalPrice}'),
                            ],
                          ),
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
                                      text: "${totalPrice}",
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
                : isDriverLoaded.value == false
                    ? InkWell(
                        onTap: () {
                          isDriverLoaded.value = true;
                        },
                        child: const FindingDriver())
                    : const TripDetails());
        // child: controller.isRequestSent.value == false
        //     ? Container(
        //         decoration: const BoxDecoration(
        //           borderRadius: BorderRadius.all(Radius.circular(20)),
        //           color: Colors.white,
        //         ),
        //         width: MediaQuery.of(context).size.width,
        //         padding: const EdgeInsets.symmetric(
        //             vertical: 24, horizontal: 20),
        //         child: SingleChildScrollView(
        //           child: Column(
        //             mainAxisAlignment: MainAxisAlignment.start,
        //             mainAxisSize: MainAxisSize.min,
        //             crossAxisAlignment: CrossAxisAlignment.start,
        //             children: [
        //               const CommonText(
        //                 text: "Choose your ride",
        //                 fontSize: 24,
        //                 fontWeight: FontWeight.bold,
        //               ),
        //               const SizedBox(height: 10),
        //               SizedBox(
        //                 height: 150,
        //                 child: ListView.builder(
        //                   itemCount: rideEstimationList.length,
        //                   itemBuilder: (context, index) {
        //                     return Card(
        //                       elevation: 1,
        //                       surfaceTintColor: AppColors.white,
        //                       color: AppColors.white,
        //                       child: ListTile(
        //                         leading: SvgPicture.network(
        //                             rideEstimationList[index]
        //                                 .image
        //                                 .toString()),
        //                         title: CommonText(
        //                           text: rideEstimationList[index]
        //                               .name
        //                               .toString(),
        //                           fontSize: 14,
        //                           fontWeight: FontWeight.w600,
        //                         ),
        //                         subtitle: Row(
        //                           children: [
        //                             CommonText(
        //                                 text:
        //                                     "₹ ${rideEstimationList[index].estimation!.estimate.toString()}",
        //                                 fontSize: 12,
        //                                 fontWeight: FontWeight.w600),
        //                             const SizedBox(
        //                               width: 3,
        //                             ),
        //                             SvgPicture.asset(
        //                                 "packages/mynewpackage/${Assets.iconsClock}",
        //                                 color: AppColors.borderColor),
        //                             // Icon(Icons.access_time,size: 16,color: AppColors.borderColor,),
        //                             CommonText(
        //                               text:
        //                                   '${rideEstimationList[index].estimation!.duration.toString()} min',
        //                               fontSize: 12,
        //                               textColor: AppColors.borderColor,
        //                             ),
        //                             const SizedBox(
        //                               width: 3,
        //                             ),
        //
        //                             // Icon(Icons.person_pin,color: AppColors.borderColor,size: 16,),
        //                             SvgPicture.asset(
        //                               "packages/mynewpackage/${Assets.iconsSeats}",
        //                               color: AppColors.borderColor,
        //                             ),
        //
        //                             CommonText(
        //                               text:
        //                                   '${rideEstimationList[index].capacity.toString()} Seats',
        //                               fontSize: 12,
        //                               textColor: AppColors.borderColor,
        //                             ),
        //                           ],
        //                         ),
        //                         trailing: SizedBox(
        //                           height: 23,
        //                           width: 23,
        //                           child: Obx(() {
        //                             return Radio(
        //                                 activeColor: AppColors.primaryColor,
        //                                 value: index,
        //                                 groupValue: selectedType?.value,
        //                                 onChanged: (value) {
        //                                   totalPrice?.value =
        //                                       rideEstimationList[index]
        //                                           .estimation!
        //                                           .estimate!
        //                                           .toDouble();
        //                                   controller.price.value =
        //                                       rideEstimationList[index]
        //                                           .estimation!
        //                                           .estimate!
        //                                           .toDouble();
        //                                   controller.fareId.value =
        //                                       rideEstimationList[index]
        //                                           .estimation!
        //                                           .fareId
        //                                           .toString();
        //                                   controller.productId.value =
        //                                       rideEstimationList[index]
        //                                           .estimation!
        //                                           .productId
        //                                           .toString();
        //                                   selectedType?.value = value!;
        //                                 });
        //                           }),
        //                         ),
        //                       ),
        //                     );
        //                   },
        //                 ),
        //               ),
        //               const SizedBox(height: 20),
        //               Row(
        //                 children: [
        //                   SvgPicture.asset(
        //                     "packages/mynewpackage/${Assets.iconsKilometer}",
        //                   ),
        //                   SizedBox(
        //                     width: MediaQuery.of(context).size.width * .01,
        //                   ),
        //                   CommonText(
        //                       text:
        //                           "${rideEstimationList.first.estimation?.distance} km"),
        //                   SizedBox(
        //                     width: MediaQuery.of(context).size.width * .15,
        //                   ),
        //                   SvgPicture.asset(
        //                     "packages/mynewpackage/${Assets.iconsClock}",
        //                   ),
        //                   SizedBox(
        //                     width: MediaQuery.of(context).size.width * .01,
        //                   ),
        //                   CommonText(
        //                       text:
        //                           "${rideEstimationList.first.estimation?.duration} min"),
        //                   SizedBox(
        //                     width: MediaQuery.of(context).size.width * .15,
        //                   ),
        //
        //                   ///price tag
        //                   SvgPicture.asset(
        //                     "packages/mynewpackage/${Assets.iconsDollarCircle}",
        //                   ),
        //                   SizedBox(
        //                     width: MediaQuery.of(context).size.width * .01,
        //                   ),
        //                   CommonText(text: '${totalPrice}'),
        //                 ],
        //               ),
        //               SizedBox(
        //                 height: MediaQuery.of(context).size.height * .02,
        //               ),
        //               Row(
        //                 children: [
        //                   Obx(() {
        //                     return DropdownButton<String>(
        //                       icon: const Icon(Icons.keyboard_arrow_down),
        //                       value: selectedPaymentType.value,
        //                       onChanged: (String? newValue) {
        //                         selectedPaymentType.value = newValue!;
        //                       },
        //                       items: <String>['Apple Pay', 'Card', 'Cash']
        //                           .map<DropdownMenuItem<String>>(
        //                               (String value) {
        //                         return DropdownMenuItem<String>(
        //                           value: value,
        //                           child: CommonText(
        //                             text: value,
        //                             fontSize: 12,
        //                           ),
        //                         );
        //                       }).toList(),
        //                     );
        //                   }),
        //                   Spacer(),
        //                   InkWell(
        //                     onTap: () {
        //                       Navigator.of(context).push(MaterialPageRoute(
        //                           builder: (context) =>
        //                               const PromoCodeListingView()));
        //                     },
        //                     child: Container(
        //                       height: 40,
        //                       // width: 100,
        //                       decoration: BoxDecoration(
        //                           borderRadius: BorderRadius.circular(25),
        //                           border: Border.all(
        //                               color: AppColors.borderColor)),
        //                       child: Padding(
        //                         padding: const EdgeInsets.all(8.0),
        //                         child: Row(
        //                           children: [
        //                             SvgPicture.asset(
        //                               "packages/mynewpackage/${Assets.iconsOfferIcon}",
        //                               height: 15,
        //                             ),
        //                             const SizedBox(
        //                               width: 2,
        //                             ),
        //                             const CommonText(
        //                               text: "Promo code",
        //                               fontSize: 12,
        //                             )
        //                           ],
        //                         ),
        //                       ),
        //                     ),
        //                   )
        //                 ],
        //               ),
        //               ElevatedButton(
        //                   style: ButtonStyle(
        //                     backgroundColor: MaterialStateProperty.all(
        //                         AppColors.primaryColor),
        //                     minimumSize:
        //                         MaterialStateProperty.all(Size(340, 70)),
        //                   ),
        //                   onPressed: () {
        //                     controller.requestRide();
        //                   },
        //                   child: Row(
        //                     children: [
        //                       CommonText(
        //                         text: "Request",
        //                         textColor: AppColors.white,
        //                       ),
        //
        //                       ///price
        //                       Spacer(),
        //                       CommonText(
        //                           text: "${totalPrice}",
        //                           textColor: AppColors.white),
        //                       SizedBox(
        //                         width: 10,
        //                       ),
        //                       Container(
        //                         height: 40,
        //                         width: 40,
        //                         decoration: BoxDecoration(
        //                             color: AppColors.white,
        //                             borderRadius:
        //                                 BorderRadius.circular(30)),
        //                         child: Icon(
        //                           Icons.arrow_forward_ios,
        //                           color: AppColors.primaryColor,
        //                         ),
        //                       )
        //                     ],
        //                   ))
        //             ],
        //           ),
        //         ),
        //       )
        //     : isDriverLoaded.value == false
        //         ? InkWell(
        //             onTap: () {
        //               isDriverLoaded.value = true;
        //             },
        //             child: const FindingDriver())
        //         : const TripDetails());
      }),
    );
  }
}

class TripDetails extends StatelessWidget {
  const TripDetails({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          color: Colors.white,
        ),
        width: MediaQuery.of(context).size.width,
        child: Padding(
            padding: EdgeInsets.symmetric(vertical: 25, horizontal: 10),
            child: InkWell(
              onTap: () {
                // Navigator.of(context).pop();
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return const TripCompleteDialog();
                  },
                );
              },
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CommonText(
                      text: "Trip Details",
                      fontWeight: FontWeight.w800,
                      fontSize: 14,
                    ),
                    ListTile(
                      leading: CircleAvatar(),
                      title: CommonText(
                          text: "Henry", fontWeight: FontWeight.w700),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CommonText(text: "Experience 1 year"),
                          CommonText(text: "Total Rides: 1000"),
                          RatingBarIndicator(
                            rating: 2.5,
                            itemBuilder: (context, index) => const Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                            itemCount: 5,
                            itemSize: 14.0,
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(30.0),
                      child: Row(
                        children: [
                          SvgPicture.asset(
                            "packages/mynewpackage/${Assets.iconsKilometer}",
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * .01,
                          ),
                          const CommonText(text: "21 km"),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * .15,
                          ),
                          SvgPicture.asset(
                            "packages/mynewpackage/${Assets.iconsClock}",
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * .01,
                          ),
                          const CommonText(text: "8 min"),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * .15,
                          ),
                          SvgPicture.asset(
                            "packages/mynewpackage/${Assets.iconsDollarCircle}",
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * .01,
                          ),
                          const CommonText(text: "\$1.99"),
                        ],
                      ),
                    ),
                    ListTile(
                      leading: SvgPicture.asset(
                        "packages/mynewpackage/${Assets.iconsEconomyCar}",
                      ),
                      title: CommonText(
                        text: 'Economy',
                      ),
                      subtitle: Row(
                        children: [
                          SvgPicture.asset(
                              "packages/mynewpackage/${Assets.iconsClock}",
                              color: AppColors.borderColor),
                          // Icon(Icons.access_time,size: 16,color: AppColors.borderColor,),
                          CommonText(
                            text: '2 min',
                            fontSize: 16,
                            textColor: AppColors.borderColor,
                          ),
                          const SizedBox(
                            width: 5,
                          ),

                          SvgPicture.asset(
                            "packages/mynewpackage/${Assets.iconsSeats}",
                            color: AppColors.borderColor,
                          ),

                          CommonText(
                            text: '5 Seats',
                            fontSize: 16,
                            textColor: AppColors.borderColor,
                          ),
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
                          const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CommonText(
                                text: "Pick-up",
                                fontSize: 12,
                                textColor: Colors.grey,
                              ),
                              SizedBox(height: 2),
                              CommonText(
                                text: "Sonnenweg 32, 79669 Berlin, Germany",
                                fontSize: 14,
                              ),
                              SizedBox(height: 20),
                              CommonText(
                                text: "Drop off",
                                fontSize: 12,
                                textColor: Colors.grey,
                              ),
                              SizedBox(height: 2),
                              CommonText(
                                text:
                                    "St.-Martin-Straße 14, 93099 Berlin,Germany",
                                fontSize: 14,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Row(
                        children: [
                          CommonText(text: "Payment option"),
                          Spacer(),
                          CommonText(text: "Apple Pay")
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Row(
                        children: [
                          CommonText(text: "Total price"),
                          Spacer(),
                          CommonText(
                            text: "\$1.99",
                            fontWeight: FontWeight.w700,
                          )
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          height: 55,
                          width: 206,
                          decoration: BoxDecoration(
                              border: Border.all(color: AppColors.primaryColor),
                              borderRadius: BorderRadius.circular(100)),
                          child: Center(
                              child: CommonText(
                            text: 'Cancel',
                            textColor: AppColors.primaryColor,
                          )),
                        ),
                        // SizedBox(width: 5,),

                        SvgPicture.asset(
                          "packages/mynewpackage/${Assets.iconsMessage}",
                          height: 55,
                          width: 55,
                        ),
                        // SizedBox(width: 5,),
                        SvgPicture.asset(
                          "packages/mynewpackage/${Assets.iconsCall}",
                          height: 55,
                          width: 55,
                        ),
                      ],
                    ),
                  ]),
            )));
  }
}

class FindingDriver extends StatelessWidget {
  const FindingDriver({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final cabController = Get.put(CabMapController());

    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        color: Colors.white,
      ),
      width: MediaQuery.of(context).size.width,
      child: Obx(() {
        String title = "Loading Your Nearest Driver";
        String subtitle =
            "Hang tight! We're connecting you with\nthe closest available driver. This may\ntake a moment.";
        if (cabController.cabStatus.value == CabStates.cabAllocated ||
            cabController.cabStatus.value ==
                CabStates.cabApproachingPassenger) {
          title = "Driver is headed your way";
          subtitle = "Meet at the pickpoint";
        }

        if (cabController.cabStatus.value == CabStates.cabArrived) {
          title = "Driver Arrived";
          subtitle = "Meet at the pickpoint";
        }

        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 25),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SvgPicture.asset(
                  "packages/mynewpackage/${Assets.iconsLoadingDriver}"),
              CommonText(
                text: title,
                fontSize: 20,
                fontWeight: FontWeight.w800,
              ),
              CommonText(
                text: subtitle,
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 100,
              )
            ],
          ),
        );
      }),
    );
  }
}

class _DestinationSelection extends StatelessWidget {
  const _DestinationSelection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
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

class TripCompleteDialog extends StatelessWidget {
  const TripCompleteDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
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
                  text: 'Hi Michel,',
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
                      const CommonText(text: "\$1.99"),
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
                      const Expanded(
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
                              text: "Sonnenweg 32, 79669 Berlin, Germany",
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
                              text:
                                  "St.-Martin-Straße 14, 93099 Berlin, Germany",
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
                  title: const Row(
                    children: [
                      CommonText(
                        text: "Henry",
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
                        text: '\$1.99',
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
                      CommonText(text: "5"),
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
                      Navigator.of(context).pop();
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
