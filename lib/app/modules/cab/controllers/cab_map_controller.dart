import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mynewpackage/app/modules/cab/cab_repository.dart';
import 'package:mynewpackage/app/modules/cab/model/cance_reasons_response.dart';
import 'package:mynewpackage/app/modules/cab/model/ride_details_response.dart';
import 'package:mynewpackage/app/modules/cab/ride_track_response.dart';
import 'package:mynewpackage/constants.dart';

import '../../../../generated/assets.dart';


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
   List<CancelReasonsResponse>? cancelReasonsResponse;


  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    createCustomMarkerIcon();
    rideCancelReasons();

  }



  RideDetailsResponse? rideDetailsResponse;


  void createCustomMarkerIcon() async {
    customIcon = await BitmapDescriptor.fromAssetImage(
      ImageConfiguration(size: Size(40, 40)),
      'packages/mynewpackage/${Assets.iconsTracker}',
    );

  }








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

  void moveCamera(LatLng position) {
    mapController?.animateCamera(
      CameraUpdate.newLatLng(position),
    );
  }

  resetRide() {
    cabStatus(CabStates.initial);
    markerIndex(0);
    canExit(true);
    polylines.clear();
    routeCoordinates.clear(); // Reset the route coordinates
    routeCoordinates.add(LatLng(10.048726, 76.318781)); // Re-add the starting position

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
      if(!isCancelClicked.value){
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
          return null;
        }
      }
    }
    catch (e) {
      return null;
    }
  }

  Future<void> getRideDetails() async {
    rideDetailsResponse =  await cabRepository.rideDetails(requestId: Constants.requestId!).then((value) {
      if (value.data != [] ) {

      } else {

      }
    });
  }

  Future<void> rideCancelReasons() async {
     await cabRepository.rideCancelReasons().then((value) {
      if (value != [] ) {

        // cancelReasonsResponse = List.of(value);

      } else {

      }
    });
  }

  _startMoving() {
    initial();
    if (rideCompleted.value) {
      return;
    }
    log("startMoving called");

    Timer.periodic(Duration(seconds: 5), (timer) async {
      if (rideCompleted.value) {
        timer.cancel();
        return;
      }
      if(isCancelClicked.value){
        timer.cancel();
        return;
      }
      debugPrint("before api call");

      var response = await trackRide();
      debugPrint("after api call");


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
          _setPolyline();
        }

        moveCamera(newLatLng); // Move the camera to the new marker position

        if (cabStatus.value == CabStates.completed) {
          timer.cancel();
          return;
        }
      }
    });
  }

  void _setPolyline() {
    polylines.clear();
    polylines.add(
      Polyline(
        polylineId: PolylineId('route'),
        visible: true,
        points: routeCoordinates.toList(),
        width: 4,
        color: Colors.black,
      ),
    );
  }

  setExitFalse() {
    canExit(false);
  }

  setExitTrue() {
    canExit(true);
  }
}

enum CabStates {
  initial,
  loading,
  rideSelection,
  searchingCab,
  accepted,
  arriving,
  arrived,
  otpVerified,
  inProgress,
  completed,
  canceled
}
