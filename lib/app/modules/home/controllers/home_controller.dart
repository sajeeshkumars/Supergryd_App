import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:location/location.dart' as location;
import 'package:mynewpackage/app/authentication/authentication_repo.dart';
import 'package:mynewpackage/app/authentication/controller/base_controller.dart';
import 'package:mynewpackage/app/authentication/model/authentication_request_model.dart';
import 'package:mynewpackage/app/authentication/model/create_user_request_model.dart';
import 'package:mynewpackage/app/modules/cab/controllers/cab_map_controller.dart';
import 'package:mynewpackage/app/modules/home/data/home_repository.dart';
import 'package:mynewpackage/app/modules/restaurants_and_dishes_listing/controllers/restaurants_and_dishes_listing_controller.dart';
import 'package:mynewpackage/constants.dart';
import 'package:mynewpackage/services/exception_handler.dart';
import 'package:mynewpackage/widgets/address_selection_dialogue.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../app_colors.dart';
import '../../../../generated/assets.dart';
import '../data/models/request_ride_response.dart';
import '../data/models/ride_estimation_response.dart';
import '../data/models/service_category_response.dart';
import 'color_controller.dart';

class HomeController extends GetxController {
  RxString _name = "".obs;
  RxString _mobile = "".obs;
  RxBool isAuthenticated = false.obs;
  late BaseController baseController;
  final AuthRepository authRepository = Get.find();
  RxInt _retryCount = 0.obs;

  @override
  void onInit() {
    baseController = Get.find<BaseController>();
    baseController.isAuthenticated.listen((val) {
      isAuthenticated(val);
      update();
    });
    super.onInit();
  }

  List addressTypeImage = [
    Assets.iconsHomeIcon,
    Assets.iconsOffice,
    Assets.iconsOffice,
    Assets.iconsHomeIcon,
    Assets.iconsOffice,
  ];
  List addressHeading = [
    "Home",
    "Office",
    "Seeroo",
    "Home Bengaluru",
    "Office Bengaluru"
  ];

  // List addressDescription = [
  //   "67/8, 4th cross Road, Lavella Road,  Bengaluru,Karnataka 560001, India",
  //   "No. 63, 1st Floor, 14th Cross, 9th Main Road,Indiranagar, Bengaluru, Karnataka 560038, India",
  //   "XIII/330, Santhigiri Campus, Cochin, NAD Rd, North Kalamassery, HMT Kalamassery, Kerala 683503",
  // ];
  List addressDescription = [
    "Devalokam,Thevakal",
    "No. 63, 1st Floor, 14th Cross, 9th Main Road,Indiranagar, Bengaluru, Karnataka 560038, India",
    "Seeroo it solutions",
    "Bengaluru home",
    "Bengaluru office",
    // "other"
  ];

  Map<String, dynamic> locationCoordinates = {
    "Home": {
      "lat": 10.055348,
      "long": 76.321888,
    },
    "Office": {
      "lat": 10.064582,
      "long": 76.351153,
    },
    "Seeroo": {
      "lat": 10.064588,
      "long": 76.351151,
    },

    /// Bengaluru address are for displaying food
    "Home Bengaluru": {
      "lat": 13.094478,
      "long": 77.720049,
    },
    "Office Bengaluru": {
      "lat": 12.9147399,
      "long": 77.5972174,
    },
    // "Other": {
    //   "lat": 13.094471,
    //   "long": 77.720029,
    // },
  };

  RxBool isForFood = false.obs;

  RxMap selectedLocationCoordinates = {
    "lat": 13.094478,
    "long": 77.720049,
  }.obs;
  RxMap selectedPickupCoordinates = {
    "lat": 13.094478,
    "long": 77.720049,
  }.obs;
  RxMap selectedDropoffCoordinates = {
    "lat": 13.094478,
    "long": 77.720049,
  }.obs;
  RxString address = "Select Address".obs;
  RxString selectedPickUp = "".obs;
  RxString selectedDropOff = "".obs;
  RxBool isLoading = false.obs;
  RxBool isLoadingServices = false.obs;
  RxBool isEstimationLoading = false.obs;
  RxBool isRequestRideLoading = false.obs;
  RxBool isRequestSent = false.obs;
  RxString productId = "".obs;
  RxString fareId = "".obs;
  RxDouble price = 0.0.obs;
  RxString carType = "".obs;
  RxDouble rideDuration = 0.0.obs;
  RxString rideDistance = "".obs;
  RxString seatCapacity = "".obs;
  RequestRideData? requestRideData;

  // AppStorage storage = AppStorage();
  HomeRepository homeRepository = Get.put(HomeRepository());
  RxList<ServiceCategories> serviceList =
      List<ServiceCategories>.empty(growable: true).obs;

  RxList<RideEstimationList> estimationList =
      List<RideEstimationList>.empty(growable: true).obs;

  List specialOfferTitle = [
    "Special\nFood Menu",
    "100% Cashback\non First Order",
    "Get 20% OFF\non All Foods",
    "Limited Offer\nHot Deals",
    "Get 20% - 30%\nCashback"
  ];
  List specialOfferImages = [
    Assets.imagesTopOffer1,
    Assets.imagesTopOffer2,
    Assets.imagesTopOffer3,
    Assets.imagesTopOffer4,
    Assets.imagesTopOffer5
  ];
  List recommendedServicesImages = [
    Assets.iconsRecomentedServices1,
    Assets.iconsRecomentedService2,
    Assets.iconsRecomentedService3
  ];
  List recommendedServices = [
    "25 people booked\n ticket to visit\n Brandenburg Gate past 5 days ",
    "50 people from New\n York ate Schnitzel\n from Schnitzelei Mitte ",
    "15 people from New York\n ate Salat from\n 1990 Vegan Living"
  ];
  final ColorController colorController = Get.find<ColorController>();
  final location.Location locationStatus = location.Location();

  RxInt count = 0.obs;
  RxBool isDestinationSelected = false.obs;
  CabMapController cabMapController = Get.put(CabMapController());

  @override
  void onReady() {
    isAuthenticated.listen((val) {
      if (val) {
        getServices();
      }
    });
    super.onReady();
  }

  void showAddressSelectionBottomSheet({
    required BuildContext context,
    RestaurantsAndDishesListingController? controller,
  }) {
    showModalBottomSheet(
      isDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return Obx(() {
          return isLoading.value
              ? SizedBox.shrink()
              : Container(
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(25))),
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        'Select Your Delivery Location',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 20),
                      InkWell(
                        onTap: () {},
                        child: Row(
                          children: [
                            Icon(
                              Icons.add_circle_outline,
                              color: colorController.primaryColor.value,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              "Add New Address",
                              style: TextStyle(
                                  color: colorController.primaryColor.value,
                                  fontWeight: FontWeight.w800),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        'Saved Address',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w800),
                      ),
                      Expanded(
                        child: ListView.builder(
                          itemCount: addressDescription.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: InkWell(
                                onTap: () {
                                  selectedPickUp.value =
                                      addressDescription[index].toString();

                                  controller?.restaurantList.clear();
                                  controller?.dishList.clear();
                                  address.value =
                                      addressDescription[index].toString();
                                  debugPrint('value ${address.value}');
                                  selectedLocationCoordinates.value =
                                      locationCoordinates[addressHeading[index]]
                                          as Map<dynamic, dynamic>;
                                  selectedPickupCoordinates.value =
                                      locationCoordinates[addressHeading[index]]
                                          as Map<dynamic, dynamic>;
                                  controller?.getRestaurants(initial: true);
                                  Navigator.pop(context);
                                  count.value = 1;

                                  // Get.back();
                                },
                                child: Container(
                                  color: colorController.primaryColor.value
                                      .withOpacity(.05),
                                  child: ListTile(
                                    leading: ColorFiltered(
                                        colorFilter: ColorFilter.mode(
                                            AppColors.accentColor,
                                            BlendMode.modulate),
                                        child: SvgPicture.asset(
                                            "packages/mynewpackage/${addressTypeImage[index]}")),
                                    title: Text(
                                      addressHeading[index].toString(),
                                      style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    subtitle: Text(
                                      addressDescription[index].toString(),
                                      style: (TextStyle(
                                          color: AppColors.textColor)),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                );
        });
      },
    );
  }

  void showLocationSelectionBottomSheet(
      {required BuildContext context, required String locationType}) {
    showModalBottomSheet(
      isDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return Obx(() {
          return isLoading.value
              ? SizedBox.shrink()
              : Container(
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(25))),
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // InkWell(
                      //   onTap: () {},
                      //   child: Row(
                      //     children: [
                      //       Icon(
                      //         Icons.add_circle_outline,
                      //         color: colorController.primaryColor.value,
                      //       ),
                      //       const SizedBox(
                      //         width: 10,
                      //       ),
                      //       Text(
                      //         "Add New Address",
                      //         style: TextStyle(
                      //             color: colorController.primaryColor.value,
                      //             fontWeight: FontWeight.w800),
                      //       ),
                      //     ],
                      //   ),
                      // ),
                      const Text(
                        'Saved Address',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w800),
                      ),
                      Expanded(
                        child: ListView.builder(
                          itemCount: addressDescription.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: InkWell(
                                onTap: () {
                                  if (locationType == 'PickUp') {
                                    selectedPickUp.value =
                                        addressDescription[index].toString();
                                    selectedPickupCoordinates.value =
                                        locationCoordinates[
                                            addressHeading[index]];
                                  } else {
                                    selectedDropOff.value =
                                        addressDescription[index].toString();
                                    isDestinationSelected.value = true;
                                    selectedDropoffCoordinates.value =
                                        locationCoordinates[
                                            addressHeading[index]];

                                    getEstimations();
                                  }
                                  Navigator.pop(context);

                                  //
                                  // address.value = addressDescription[index];
                                  // debugPrint("value ${address.value}");
                                  // selectedLocationCoordinates.value =
                                  // locationCoordinates[
                                  // addressHeading[index]];
                                  // debugPrint("value ${address.value}");
                                  // debugPrint(
                                  //     "selectedLocationCordinates $selectedLocationCoordinates");
                                  // Navigator.pop(context);
                                  // count.value = 1;

                                  // Get.back();
                                },
                                child: Container(
                                  color: colorController.primaryColor.value
                                      .withOpacity(.05),
                                  child: ListTile(
                                    leading: ColorFiltered(
                                        colorFilter: ColorFilter.mode(
                                            AppColors.accentColor,
                                            BlendMode.modulate),
                                        child: SvgPicture.asset(
                                            "packages/mynewpackage/${addressTypeImage[index]}")),
                                    title: Text(
                                      addressHeading[index].toString(),
                                      style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    subtitle: Text(
                                      addressDescription[index].toString(),
                                      style: (TextStyle(
                                          color: AppColors.textColor)),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                );
        });
      },
    );
  }

  void authenticate({required BuildContext context}) async {
    if (isAuthenticated.isFalse) {
      isLoading(true);
      debugPrint("before api call${isLoading.value}");

      AuthenticationRequestModel requestModel = AuthenticationRequestModel(
          clientId: baseController.clientID,
          clientSecrete: baseController.clientSecret);

      var result = await InternetConnectionChecker().hasConnection;

      if (result == true && isAuthenticated.isFalse) {
        log("authenticated called from home_controller");

        await authRepository.authenticate(requestModel.toJson()).then((value) {
          // await authRepository.authenticate().then((value) {
          if (value.status == 200) {
            debugPrint("after success${isLoading.value}");

            debugPrint("authenticated");
            debugPrint("${value.message}");
            debugPrint("token${value.data?.refreshToken}");
            Constants.accessToken = value.data?.accessToken ?? "";
            // storage.writeAccessToken(value.data?.accessToken ?? "");
            //   debugPrint("access token ${storage.getAccessToken()}");
            // storage.writeRefreshToken(value.data?.refreshToken ?? "");
            Constants.refreshToken = value.data?.refreshToken ?? "";
            Constants.isAuthenticated = true;
            AppColors.primaryColor =
                fromHex(value.data!.themes!.first.primaryColor.toString());
            AppColors.accentColor =
                fromHex(value.data!.themes!.first.accentColor.toString());
            debugPrint("color ${AppColors.primaryColor}");
            colorController.updateColors(
              value.data!.themes!.first.primaryColor.toString(),
              value.data!.themes!.first.accentColor.toString(),
            );

            //   storage.writeIsAuthenticated(true);
            createUser(
                mobile: _mobile.value, name: _name.value, context: context);
            getServices();
            isLoading(false);
          } else {
            isLoading(false);
            debugPrint("after failure${value.message}");
            Navigator.pop(context);

            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text(
                  "Unauthorized please check Your Key",
                ),
                backgroundColor: Colors.red,
                duration: Duration(minutes: 5)));
            // Navigator.of(context, rootNavigator: true).pop();

            // Navigator.pop(context);
          }
        });
      } else {
        isLoading(false);
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
            "No Internet",
          ),
          backgroundColor: Colors.red,
        ));
      }
    }
  }

  void createUser(
      {required String mobile,
      required String name,
      required BuildContext? context}) async {
    // isLoading(true);
    _name(name);
    _mobile(mobile);
    if (isAuthenticated.isTrue) {
      CreateUserRequestModel requestModel = CreateUserRequestModel(
          phoneNumber: mobile, phoneCode: "+91", name: name);

      await authRepository.createUser(requestModel.toJson()).then((value) {
        if (value.status == 200) {
          // isLoading(false);
          // storage.writeUserId(value.data?.id ?? "");
          Constants.userId = value.data?.id ?? "";
          isAuthenticated(true);
        } else {
          isAuthenticated(false);
          if (context != null) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(
                  value.message ?? "",
                ),
                backgroundColor: Colors.red,
              ));
            });
          }
        }
      });
    } else {
      ExceptionHandler.instance.throwException(
          Exception("CreateUser:Unauthorized please check Your Key"));
      if (context != null) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
              "Unauthorized please check Your Key",
            ),
            backgroundColor: Colors.red,
          ));
        });
      }
    }
  }

  Future<void> getServices() async {
    serviceList.clear();
    isLoadingServices(true);
    await homeRepository.getServiceList().then((value) {
      if (value.data?.serviceCategories != [] && (value.status == 200)) {
        serviceList.addAll(value.data?.serviceCategories ?? []);
        // debugPrint("list service ${serviceList.first.categoryName}");
        isLoadingServices(false);
      } else {
        isLoadingServices(false);
        _retryCount++;
        if (_retryCount.value < 5) {
          getServices();
        } else {
          _retryCount(0);
        }
      }
    });
  }

  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  Future<void> requestLocationPermission(BuildContext context) async {
    try {
      location.PermissionStatus permission =
          await locationStatus.requestPermission();
      if (permission == location.PermissionStatus.granted) {
        await showDialog(
          context: context,
          builder: (BuildContext context) {
            return Scaffold(
              backgroundColor: Colors.transparent,
              body: RideDialog(
                onSelected: (address, lat, lng, zip, city, state, streetNumber,
                    route, homeAddress) {},
                onDataReceived: (
                  String address,
                  double lat,
                  double lng,
                  String zip,
                  String city,
                  String state,
                  String streetNumber,
                  String route,
                  String stateIsoCode,
                ) {
                  // onAddressSelect(
                  //   address,
                  //   lat,
                  //   lng,
                  //   zip,
                  //   city,
                  //   state,
                  //   streetNumber,
                  //   route,
                  //   stateIsoCode,
                  // );
                },
              ),
            );
          },
        );
      } else {
        await showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text(""),
              content: Text(
                  'Location permission is not allowed. Please allow it in Location Services'),
              actions: <Widget>[
                TextButton(
                  child: Text("OK"),
                  onPressed: () {
                    openLocationServicesSettings();
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void openLocationServicesSettings() async {
    const String settingsUrl = 'App-Prefs:LOCATION_SERVICES';
    final uri = Uri.parse(settingsUrl);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      if (kDebugMode) {
        print('Could not open Location Services settings.');
      }
    }
  }

  Future<void> requestLocationForAndroid(
      {int count = 1, required BuildContext context}) async {
    try {
      final locationStatus = await Permission.location.request();

      final locationServiceStatus = await Permission.location.serviceStatus;

      if (locationServiceStatus != ServiceStatus.enabled) {
        await location.Location().requestService();
      }

      if (locationStatus == PermissionStatus.granted &&
          locationServiceStatus == ServiceStatus.enabled) {
        showAddressSelectionDialog(context);
      } else {
        if (locationStatus == PermissionStatus.permanentlyDenied) {
          await openAppSettings();
        }
        if (locationStatus == PermissionStatus.denied) {
          if (count < 2) {
            await requestLocationForAndroid(count: 2, context: context);
          }
        }
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void showAddressSelectionDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return RideDialog(
          onSelected: (address, lat, lng, zip, city, state, streetNumber, route,
              stateIsoCode, homeAddress) {},
          onDataReceived: (
            String address,
            double lat,
            double lng,
            String zip,
            String city,
            String state,
            String streetNumber,
            String route,
            String stateIsoCode,
          ) {
            // onAddressSelect(address, lat, lng, zip, city, state, streetNumber,
            //     route, stateIsoCode
            //     // districtName, districtIsoCode
            //     );
          },
        );
      },
    );
  }

  Future<void> getEstimations() async {
    estimationList.clear();
    isEstimationLoading(true);
    await homeRepository.getRideEstimation({
      // "start_location": {"lat": 28.668613, "long": 77.206174},
      "start_location": {
        "lat": selectedPickupCoordinates['lat'],
        "long": selectedPickupCoordinates['long']
      },
      // "end_location": {"lat": 10.064588, "long": 76.351151}
      "end_location": {
        "lat": selectedDropoffCoordinates['lat'],
        "long": selectedDropoffCoordinates['long']
      }
    }).then((value) {
      if (value.data != [] && (value.status == 200)) {
        estimationList.addAll(value.data ?? []);
        isEstimationLoading(false);
        final cabController = Get.find<CabMapController>();
        debugPrint("ride selection top ${cabController.cabStatus.value}");
        cabController.onRideSelection();
        debugPrint(
            "ride selection after reset ${cabController.cabStatus.value}");
      } else {
        isEstimationLoading(false);

        if (value.status == 422) {
          cabMapController.setRideNotFound();
        }
        // getEstimations();
      }
    });
  }

  Future<void> requestRide(BuildContext context) async {
    isRequestRideLoading(true);
    await homeRepository.requestRide({
      'first_name': "first name",
      'last_name': 'last name',
      'phone_number': '9878765434',
      'email': 'example@gmail.com',
      "start_location": {
        // "lat": "10.28668613",
        "lat": selectedPickupCoordinates['lat'],
        // "long": "76.321888",
        "long": selectedPickupCoordinates['long'],
        // "address": "Devalokam,Thevakal"
        "address": selectedPickUp.value
      },
      "end_location": {
        // "lat": "10.064588",
        "lat": selectedDropoffCoordinates['lat'],
        // "long": "76.351151",
        "long": selectedDropoffCoordinates['long'],
        // "address": "Seeroo it solutions"
        "address": selectedDropOff.value
      },
      'product_id': productId.value,
      'fare_id': fareId.value,
      'user_id': "66595991f94a7ec05b88ebf9",
      // 'user_id': Constants.userId,
      'price': price.value
    }).then((value) {
      if (value.status == 200) {
        requestRideData = value.data;

        isRequestSent.value = true;
        Constants.requestId = value.data?.requestedId?.toInt();
        price.value = value.data!.estimatedPrice!.toDouble();
        debugPrint("price.value ${price.value}");
        debugPrint("price.value ${value.data!.estimatedPrice!.toDouble()}");
        final cabController = Get.find<CabMapController>();
        cabController.onCabSearch();
        // estimationList.addAll(value.data ?? []);
        isRequestRideLoading(false);
      } else {
        if (value.status == 400) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text("Booking Failed")));
        } else {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(value.message.toString())));
        }
        isRequestRideLoading(false);
      }
    });
  }

  void clearValues() {
    selectedPickUp = "".obs;
    selectedDropOff = "".obs;
    isLoading = false.obs;
    isEstimationLoading = false.obs;
    isRequestRideLoading = false.obs;
    isRequestSent = false.obs;
    productId = "".obs;
    fareId = "".obs;
    price = 0.0.obs;
    estimationList.clear();
  }
}
