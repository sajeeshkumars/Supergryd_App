import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CabMapController extends GetxController {
  Rx<CabStates> cabStatus = CabStates.initial.obs;

  Rx<int> markerIndex = 0.obs;
  final Set<Polyline> polylines = {};
  RxBool canExit = true.obs;
  // Index of the current position in _routeCoordinates

  RxList<LatLng> routeCoordinates = <LatLng>[
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
  ].obs;

  Rx<Marker> carMarker = Marker(
    markerId: MarkerId('car'),
    position: LatLng(10.048726, 76.318781), // Starting position
    // Use a default icon until the custom icon is loaded
    // icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure),
  ).obs;

  @override
  void dispose() {
    super.dispose();
  }

  resetRide() {
    cabStatus(CabStates.initial);
    markerIndex(0);
    canExit(true);

    carMarker(Marker(
      markerId: MarkerId('car'),
      position: LatLng(10.048726, 76.318781), // Starting position
      // Use a default icon until the custom icon is loaded
      // icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure),
    ));
  }

  onRideSelection() {
    _setPolylines();
  }

  setCabApproachingPassenger() {
    cabStatus(CabStates.cabApproachingPassenger);
    Future.delayed(Duration(seconds: 2), () {
      setCabArrived();
    });
  }

  setCabJourneyCompleted(Timer timer) {
    timer.cancel();
    cabStatus(CabStates.cabReachedDestination);
  }

  setCabArrived() {
    cabStatus(CabStates.cabArrived);

    Future.delayed(Duration(seconds: 2), () {
      setCabJourneyStarted();
    });
  }

  setCabAllocated() {
    cabStatus(CabStates.cabAllocated);
    _setPolylines();
    _startMoving();
    // Future.delayed(Duration(seconds: 2), () {
    //   setCabApproachingPassenger();
    // });
  }

  setCabJourneyStarted() {
    cabStatus(CabStates.cabStartedJourney);

    onCabStartJourney();
  }

  onCabStartJourney() {
    _startMoving();
  }

  onDestinationSelected() {
    cabStatus(CabStates.rideSelection);
    canExit(false);
  }

  _startMoving() {
    int splitIndex = routeCoordinates.indexWhere(
        (coord) => coord.latitude == 10.055348 && coord.longitude == 76.321888);

    List<LatLng> firstPart = routeCoordinates.sublist(0, splitIndex);
    List<LatLng> secondPart = routeCoordinates.sublist(splitIndex);
    Timer _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      log("startMoving called");
      if (markerIndex < (routeCoordinates.length - 1)) {
        markerIndex(markerIndex.value + 1);
        carMarker.value = carMarker.value.copyWith(
          positionParam: routeCoordinates[markerIndex.value],
        );
        if (firstPart.contains(carMarker.value.position)) {
          setCabApproachingPassenger();
        }
        if (carMarker.value.position == LatLng(10.055348, 76.321888)) {
          setCabArrived();
        }
        if (secondPart.contains(carMarker.value.position)) {
          setCabJourneyStarted();
        }
        update();
      } else {
        setCabJourneyCompleted(timer);
        update();
      }
    });
  }

  void _setPolylines() {
    // Split _routeCoordinates based on LatLng(10.055348, 76.321888)
    int splitIndex = routeCoordinates.indexWhere(
        (coord) => coord.latitude == 10.055348 && coord.longitude == 76.321888);

    List<LatLng> firstPart = routeCoordinates.sublist(0, splitIndex);
    List<LatLng> secondPart = routeCoordinates.sublist(splitIndex);

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
  cabAllocated,
  cabApproachingPassenger,
  cabArrived,
  cabStartedJourney,
  cabReachedDestination,
}
