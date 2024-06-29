import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:mynewpackage/app/modules/cab/cab_repository.dart';
import 'package:mynewpackage/app/modules/cab/ride_track_response.dart';
import 'package:mynewpackage/constants.dart';

class CabMapController extends GetxController {
  Rx<CabStates> cabStatus = CabStates.initial.obs;

  Rx<int> markerIndex = 0.obs;
  final Set<Polyline> polylines = {};
  RxBool canExit = true.obs;
  CabRepository cabRepository = CabRepository();
  // Index of the current position in _routeCoordinates

  RideTrackResponse? trackResponse;
  RxBool rideCompleted = false.obs;

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
    // routeCoordinates.clear();

    carMarker(Marker(
      markerId: MarkerId('car'),
      position: LatLng(10.048726, 76.318781), // Starting position
      // Use a default icon until the custom icon is loaded
      // icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure),
    ));
  }

  initial(){
    // resetRide();
    cabStatus(CabStates.initial);
    onRideSelection();
  }

  onRideSelection() {
    debugPrint("inside reide selection up ${cabStatus.value}");
    cabStatus(CabStates.rideSelection);
    debugPrint("inside reide selection ${cabStatus.value}");

    // _startMoving();
  }

  onCabSearch(){
    cabStatus(CabStates.searchingCab);

    setCabAccepted();

  }

  setCabAccepted(){
    _startMoving();

    _setPolylines();

  }

  // setCabApproachingPassenger() {
  //   _startMoving();
  //
  //   cabStatus(CabStates.arriving);
  //   // Future.delayed(Duration(seconds: 2), () {
  //   //   setCabArrived();
  //   // });
  // }
  //
  // setCabArrived() {
  //   cabStatus(CabStates.arrived);
  //
  //   // Future.delayed(Duration(seconds: 2), () {
  //   //   setCabJourneyStarted();
  //   // });
  // }
  //
  // setOtpVerified(){
  //   cabStatus(CabStates.otpVerified);
  // }
  //
  // setCabJourneyStarted(){
  //   cabStatus(CabStates.inProgress);
  // }

  setCabJourneyCompleted(Timer timer) {
    timer.cancel();
    cabStatus(CabStates.completed);
    resetRide();
    rideCompleted(true);
  }



  // setCabAllocated() {
  //   cabStatus(CabStates.cabAllocated);
  //   _setPolylines();
  //   _startMoving();
  //   // Future.delayed(Duration(seconds: 2), () {
  //   //   setCabApproachingPassenger();
  //   // });
  // }



  // onCabStartJourney() {
  //   _startMoving();
  // }

  // onDestinationSelected() {
  //   cabStatus(CabStates.rideSelection);
  //   canExit(false);
  // }
  Future<CabStates?> trackRide() async {
    try {

      // Assuming you have some state management logic to indicate loading
      // isLoadingServices(true);

      // Await the trackRide call and handle the response
      trackResponse = await cabRepository.trackRide(requestId: Constants.requestId ?? 1);

      if (trackResponse?.requestId != null) {
        debugPrint("Driver Latitude: ${trackResponse?.driverLat}");
        debugPrint("Updating value: ${Constants.long}");
        Constants.driverName = trackResponse?.driverDetails?.name;
        Constants.vehicleNumber = trackResponse?.vehicle?.licensePlate;
        Constants.vehicleMake = trackResponse?.vehicle?.make;

        switch (trackResponse?.rideStatus) {
          case 1:
            debugPrint("inside case 1");
            return cabStatus(CabStates.accepted);
          case 2:
            debugPrint("inside case 2");

            return cabStatus(CabStates.arriving);
          case 3:
            debugPrint("inside case 3");

            return cabStatus(CabStates.arrived);
          case 4:
            debugPrint("inside case 4");

            return cabStatus(CabStates.otpVerified);
          case 5:
            debugPrint("inside case 5");

            return cabStatus(CabStates.inProgress);
          case 6:
            debugPrint("inside case 6");

            return cabStatus(CabStates.completed);
          default:
            throw Exception("Unknown status: ");
        }





        // if(trackResponse.)

        // routeCoordinates.addAll(LatLng(trackResponse.driverLat, trackResponse.driverLng),);
        // Add any additional state updates or logic here
        // e.g., update the map with driver's new location
      } else {

        return null;





        debugPrint("No request ID found in the response.");
        // Handle the case where the request ID is null
        // e.g., show an error message to the user
      }
    } catch (e) {
      return null;

      // Handle the error appropriately
      // e.g., show an error message to the user
    } finally {
      // Ensure that loading state is updated in all cases
      // isLoadingServices(false);
    }
  }


  _startMoving() async {
    initial();
    int splitIndex = routeCoordinates.indexWhere(
        (coord) => coord.latitude == 10.055348 && coord.longitude == 76.321888);

    List<LatLng> firstPart = routeCoordinates.sublist(0, splitIndex);
    List<LatLng> secondPart = routeCoordinates.sublist(splitIndex);
    // Timer _timer = Timer.periodic(const Duration(seconds: 1), (timer) async{

      if(rideCompleted.value){
        return ;
      }
      ///api call
      log("startMoving called");
      // if (markerIndex < (routeCoordinates.length - 1)) {
        for(var i=0; i< routeCoordinates.length; i++){


          var response = await trackRide();


         debugPrint("print tracr ${CabStates}");

        if(response != null) {
        markerIndex(markerIndex.value + 1);
        carMarker.value = carMarker.value.copyWith(
          // positionParam: routeCoordinates[markerIndex.value],
          positionParam: LatLng(
              double.parse(trackResponse!.driverLat.toString()),
              double.parse(trackResponse!.driverLng.toString())),
        );
      }
      // if (firstPart.contains(carMarker.value.position)) {
          //   setCabApproachingPassenger();
          // }
          // if (carMarker.value.position == LatLng(10.055348, 76.321888)) {
          //   // setCabArrived();
          //   setCabJourneyStarted();
          //
          // }
          // if (secondPart.contains(carMarker.value.position)) {
          //   setCabJourneyStarted();
          // }
          // if(carMarker.value.position == LatLng(10.064588, 76.351151) ){
          //   setCabJourneyCompleted(timer);
          // }
        // }
      // }
      // else {
      //   setCabJourneyCompleted(timer);
      //   update();
          await Future.delayed(Duration(seconds: 5));
      }

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
  accepted,
  arriving,
  arrived,
  otpVerified,
  inProgress,
  completed


  // cabAllocated,
  // cabApproachingPassenger,
  // cabArrived,
  // cabStartedJourney,
  // cabReachedDestination,
}





// import 'dart:async';
//
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:mynewpackage/app/modules/cab/cab_repository.dart';
// import 'package:mynewpackage/app/modules/cab/ride_track_response.dart';
// import 'package:mynewpackage/constants.dart';
//
// class CabMapController extends GetxController {
//   Rx<CabStates> cabStatus = CabStates.initial.obs;
//
//   Rx<int> markerIndex = 0.obs;
//   final Set<Polyline> polylines = {};
//   RxBool canExit = true.obs;
//   CabRepository cabRepository = CabRepository();
//   RideTrackResponse? trackResponse;
//   RxBool rideCompleted = false.obs;
//
//   RxList<LatLng> routeCoordinates = <LatLng>[
//     LatLng(10.048726, 76.318781),
//     // Add more coordinates as needed
//   ].obs;
//
//   Rx<Marker> carMarker = Marker(
//     markerId: MarkerId('car'),
//     position: LatLng(10.048726, 76.318781), // Starting position
//   ).obs;
//
//   @override
//   void dispose() {
//     super.dispose();
//   }
//
//   resetRide() {
//     cabStatus(CabStates.initial);
//     markerIndex(0);
//     canExit(true);
//     polylines.clear();
//     carMarker(Marker(
//       markerId: MarkerId('car'),
//       position: LatLng(10.048726, 76.318781), // Starting position
//     ));
//   }
//
//   initial(){
//     cabStatus(CabStates.initial);
//     onRideSelection();
//   }
//
//   onRideSelection() {
//     cabStatus(CabStates.rideSelection);
//   }
//
//   onCabSearch() {
//     cabStatus(CabStates.searchingCab);
//     setCabAccepted();
//   }
//
//   setCabAccepted() {
//     _startMoving();
//   }
//
//   setCabJourneyCompleted(Timer timer) {
//     timer.cancel();
//     cabStatus(CabStates.completed);
//     resetRide();
//     rideCompleted(true);
//   }
//
//   Future<CabStates?> trackRide() async {
//     try {
//       trackResponse = await cabRepository.trackRide(requestId: Constants.requestId ?? 1);
//       if (trackResponse?.requestId != null) {
//         Constants.driverName = trackResponse?.driverDetails?.name;
//         Constants.vehicleNumber = trackResponse?.vehicle?.licensePlate;
//         Constants.vehicleMake = trackResponse?.vehicle?.make;
//
//         switch (trackResponse?.rideStatus) {
//           case 1:
//             return cabStatus(CabStates.accepted);
//           case 2:
//             return cabStatus(CabStates.arriving);
//           case 3:
//             return cabStatus(CabStates.arrived);
//           case 4:
//             return cabStatus(CabStates.otpVerified);
//           case 5:
//             return cabStatus(CabStates.inProgress);
//           case 6:
//             return cabStatus(CabStates.completed);
//           default:
//             throw Exception("Unknown status: ");
//         }
//       } else {
//         return null;
//       }
//     } catch (e) {
//       return null;
//     }
//   }
//
//   _startMoving() async {
//     initial();
//
//     for (var i = 0; i < routeCoordinates.length; i++) {
//       if (rideCompleted.value) {
//         return;
//       }
//
//       var response = await trackRide();
//
//       if (response != null) {
//         markerIndex(markerIndex.value + 1);
//         carMarker.value = carMarker.value.copyWith(
//           positionParam: LatLng(
//               double.parse(trackResponse!.driverLat.toString()),
//               double.parse(trackResponse!.driverLng.toString())),
//         );
//         _updatePolyline(LatLng(
//             double.parse(trackResponse!.driverLat.toString()),
//             double.parse(trackResponse!.driverLng.toString())));
//       }
//     }
//   }
//
//   void _updatePolyline(LatLng newPoint) {
//     List<LatLng> updatedPoints = List.from(routeCoordinates)..add(newPoint);
//     routeCoordinates.value = updatedPoints;
//
//     polylines.clear();
//     polylines.add(Polyline(
//       polylineId: PolylineId('route'),
//       visible: true,
//       points: routeCoordinates,
//       width: 4,
//       color: Colors.black,
//     ));
//   }
//
//   setExitFalse() {
//     canExit(false);
//   }
//
//   setExitTrue() {
//     canExit(true);
//   }
// }
//
// enum CabStates {
//   initial,
//   loading,
//   rideSelection,
//   searchingCab,
//   accepted,
//   arriving,
//   arrived,
//   otpVerified,
//   inProgress,
//   completed
// }

