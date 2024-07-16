import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mynewpackage/app/modules/cab/model/ride_track_response.dart';
import 'package:mynewpackage/app/modules/cab/repository/cab_repository.dart';
import 'package:mynewpackage/constants.dart';

import '../../../../generated/assets.dart';
import '../../home/controllers/home_controller.dart';
import '../model/Ride_details_response.dart';
import '../model/cab_states.dart';
import '../model/cancel_reasons_response.dart';

class CabMapController extends GetxController {
  Rx<CabStates> cabStatus = CabStates.initial.obs;

  Rx<int> markerIndex = 0.obs;
  final Set<Polyline> polylines = {};
  RxBool canExit = true.obs;
  CabRepository cabRepository = CabRepository();
  RideTrackResponse? trackResponse;
  RxBool rideCompleted = false.obs;
  GoogleMapController? mapController;
  BitmapDescriptor? customIcon;
  RxBool isCancelClicked = false.obs;
  RxInt selectedCancelReason = 0.obs;
  List<CancelReasons>? cancelReasons;
  RxBool isRideCancelLoading = false.obs;
  RxInt selectedReasonId = 0.obs;
  RxString selectedCancelReasonText = ''.obs;
  RxBool isRideCompleteDataLoading = false.obs;
  bool isDelayApplied = false;
  final Set<Marker> markers = {}; // Define the markers set here

  @override
  void onInit() {
    super.onInit();
    _createCustomMarkerIcon();
  }

  fetchRideCancelReasons() async => await _rideCancelReasons();

  RideDetailsResponse? rideDetailsResponse;

  void _createCustomMarkerIcon() async {
    customIcon = await BitmapDescriptor.asset(
      ImageConfiguration(size: Size(80, 80)),
      'packages/mynewpackage/${Assets.iconsTracking}',
    );
  }

  ///for drawing polyline initially
  void _setPolyLines() {
    // Split _routeCoordinates based on LatLng(10.055348, 76.321888)
    int splitIndex = _routeCoordinates.indexWhere(
        (coord) => coord.latitude == 10.055348 && coord.longitude == 76.321888);

    List<LatLng> firstPart = _routeCoordinates.sublist(0, splitIndex);
    List<LatLng> secondPart = _routeCoordinates.sublist(splitIndex);

    polylines.add(
      Polyline(
        polylineId: PolylineId('route1'),
        visible: true,
        points: firstPart,
        width: 4,
        color: Colors.black,
      ),
    );
    polylines.add(
      Polyline(
        polylineId: PolylineId('route2'),
        visible: true,
        points: secondPart,
        width: 4,
        color: Colors.red,
      ),
    );
  }

  /// initial polyline
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

  RxList<LatLng> routeCoordinates = <LatLng>[
    LatLng(10.048726, 76.318781),
    // Add other initial coordinates here if necessary
  ].obs;

  Rx<Marker> carMarker = Marker(
    markerId: MarkerId('car'),
    position: LatLng(10.048726, 76.318781), // Starting position
  ).obs;

  Rx<Marker> destinationMarker = Marker(
    markerId: MarkerId('destination'),
    position: LatLng(10.064588, 76.351151), // Set to your destination position
  ).obs;

  void setDestination(LatLng destination) {
    destinationMarker.value = Marker(
      markerId: MarkerId('destination'),
      position: destination,
      icon: BitmapDescriptor.defaultMarker,
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _moveCamera(LatLng position) {
    mapController?.animateCamera(
      CameraUpdate.newLatLng(position),
    );
  }

  resetRide() {
    cabStatus(CabStates.initial);
    isCancelClicked = false.obs;

    markerIndex(0);
    canExit(true);
    polylines.clear();
    routeCoordinates.clear(); // Reset the route coordinates
    routeCoordinates
        .add(LatLng(10.048726, 76.318781)); // Re-add the starting position

    carMarker(Marker(
      markerId: MarkerId('car'),
      position: LatLng(10.048726, 76.318781), // Starting position
    ));
  }

  initial() {
    resetRide(); // Ensure ride is reset when initializing
    onRideSelection();
  }

  onRideSelection() {
    debugPrint("inside ride selection up ${cabStatus.value}");
    cabStatus(CabStates.rideSelection);
    debugPrint("inside ride selection ${cabStatus.value}");
  }

  onCabSearch() {
    cabStatus(CabStates.searchingCab);
    setCabAccepted();
  }

  onCancel() {
    cabStatus(CabStates.canceled);
  }

  setCabAccepted() {
    cabStatus(CabStates.accepted);
    // _setPolylines();
    // update();

    _startMoving();
  }

  setCabJourneyCompleted(Timer timer) {
    timer.cancel();
    cabStatus(CabStates.completed);
    rideCompleted(true);
    resetRide();
  }

  Future<CabStates?> trackRide() async {
    debugPrint("inside trackid ${isCancelClicked.value}");
    if (Constants.requestId == null) {
      debugPrint("Request ID is null");
      return null;
    }

    try {
      if (!isCancelClicked.value) {
        trackResponse = await cabRepository.trackRide(
            requestId: Constants.requestId!,
            otp: trackResponse?.rideStatus == 3
                ? int.parse(Constants.otp.toString())
                : 1234);

        if (trackResponse?.requestId != null) {
          debugPrint("Driver Latitude: ${trackResponse?.driverLat}");
          Constants.driverName = trackResponse?.driverDetails?.name;
          Constants.vehicleNumber = trackResponse?.vehicle?.licensePlate;
          Constants.vehicleMake = trackResponse?.vehicle?.make;
          Constants.vehicleModel = trackResponse?.vehicle?.model;
          Constants.vehicleImage = trackResponse?.vehicle?.pictureUrl;
          Constants.driverImage = trackResponse?.driverDetails?.pictureUrl;
          Constants.rating = trackResponse?.driverDetails?.rating.toString();
          if (trackResponse?.rideStatus == 1) {
            Constants.otp = trackResponse?.otp;
            debugPrint("otp inside ${Constants.otp}");
            getRideDetails();
          }
          if (trackResponse?.rideStatus == 3) {
            Future.delayed(Duration(seconds: 20));
          }

          switch (trackResponse?.rideStatus) {
            case 1:
              return cabStatus(CabStates.accepted);
            case 2:
              return cabStatus(CabStates.arriving);
            case 3:
              return cabStatus(CabStates.arrived);
            case 4:
              return cabStatus(CabStates.otpVerified);
            case 5:
              return cabStatus(CabStates.inProgress);
            case 6:
              return cabStatus(CabStates.completed);
            default:
              throw Exception("Unknown status: ");
          }
        } else {
          if (trackResponse?.status == 'FAILURE') {
            // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            //   content: Text(
            //     trackResponse!.message.toString(),
            //   ),
            //   backgroundColor: Colors.red,
            // ));
          }
          return null;
        }
      }
    } catch (e) {
      return null;
    }
    return null;
  }

  Future<void> getRideDetails() async {
    isRideCompleteDataLoading(true);
    await cabRepository
        .rideDetails(requestId: Constants.requestId!)
        .then((value) {
      if (value.data != []) {
        isRideCompleteDataLoading(false);
        rideDetailsResponse = value;
      } else {
        isRideCompleteDataLoading(false);
      }
    });
  }

  setRideNotFound() {
    cabStatus(CabStates.rideNotFound);
    canExit(true);
    update();
  }

  Future<void> _rideCancelReasons() async {
    await cabRepository.rideCancelReasons().then((value) {
      if (value.data != []) {
        cancelReasons = value.data;
        selectedCancelReasonText.value = cancelReasons?.first.reason ?? "";
        selectedReasonId.value = cancelReasons?.first.reasonId?.toInt() ?? 1;
      } else {}
    });
  }

  Future<void> cancelRide(
      {required BuildContext context,
      required int requestId,
      required int reasonId,
      required String reason}) async {
    isRideCancelLoading(true);
    await cabRepository.cancelRide({
      "request_id": requestId,
      "reason_id": reasonId,
      "reason": reason
    }).then((value) {
      if (value.status == 200) {
        isRideCancelLoading(false);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
          value.message.toString(),
        )));
        Navigator.pop(context);
        Navigator.pop(context);
        Navigator.pop(context);
        // Navigator.pushAndRemoveUntil(
        //   context,
        //   MaterialPageRoute(builder: (context) => HomeView()),
        //       (route) => false,
        // );

        CabMapController cabMapController = Get.find();
        HomeController homeController = Get.find();

        cabMapController.resetRide();
        homeController.clearValues();
      } else {
        isRideCancelLoading(false);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
          value.message.toString(),
        )));
      }
    });
  }

  _startMoving() {
    initial();
    if (rideCompleted.value) {
      return;
    }

    Timer.periodic(Duration(seconds: 5), (timer) async {
      if (rideCompleted.value) {
        timer.cancel();
        return;
      }
      if (isCancelClicked.value) {
        timer.cancel();
        return;
      }

      var response = await trackRide();

      if (response != null) {
        markerIndex(markerIndex.value + 1);
        LatLng newLatLng = LatLng(
            double.parse(trackResponse!.driverLat.toString()),
            double.parse(trackResponse!.driverLng.toString()));

        carMarker.value = carMarker.value.copyWith(
          positionParam: newLatLng,
        );

        if (!routeCoordinates.contains(newLatLng)) {
          routeCoordinates.add(newLatLng);
          _setPolyLines();
        }

        _moveCamera(newLatLng); // Move the camera to the new marker position

        if (cabStatus.value == CabStates.completed) {
          timer.cancel();
          return;
        }
      }
    });
  }

  setExitFalse() {
    canExit(false);
    update();
  }

  setExitTrue() {
    canExit(true);
    update();
  }
}
