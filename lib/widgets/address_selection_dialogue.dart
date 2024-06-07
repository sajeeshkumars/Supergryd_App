import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_place_picker/google_maps_place_picker.dart';
import 'package:mynewpackage/app/modules/home/controllers/home_controller.dart';
import 'package:mynewpackage/app_colors.dart';


import '../generated/assets.dart';
import '../generated/locales.g.dart';
import 'common_text.dart';
import 'custom_button.dart';

class AddressSelectionDialog extends StatefulWidget {
  AddressSelectionDialog(
      {super.key,
      required this.onDataReceived,
      required this.onSelected,});



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
  State<AddressSelectionDialog> createState() => _AddressSelectionDialogState();
}

class _AddressSelectionDialogState extends State<AddressSelectionDialog> {
  String? zipCode = '';

  String? city = '';

  String? stateName = '';

  String? stateIsoCode = '';

  String? streetNumber = '';

  String? route = '';

  Enum? searchingState;

  HomeController homeController = Get.find();



  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            width: double.infinity,
            color: Colors.white,
            child:
            PlacePicker(
              apiKey: 'AIzaSyBkEMGux54F5lqQ7_bXIjWVf5m3jaRdYdk',
              initialPosition: const LatLng(9.9816, 76.2999),
              resizeToAvoidBottomInset: false,
              enableMyLocationButton: false,
              enableMapTypeButton: false,
              selectedPlaceWidgetBuilder:
                  (context, result, state, searchBarFocused) {
                if (state == SearchingState.Idle) {
                  for (var i in result?.addressComponents ?? []) {
                    if (i.types.first == "postal_code") {
                      print("postal_code${i.longName}");
                      zipCode = i.longName;
                    }
                    if (i.types.first == "locality") {
                      city = i.longName;
                    }

                    if (i.types.first == "street_number") {
                      streetNumber = i.longName;
                    }
                    if (i.types.first == "administrative_area_level_1") {
                      stateName = i.longName;
                      stateIsoCode = i.shortName;
                      debugPrint("$stateName");
                    }
                    if (i.types.first == "route") {
                      route = i.longName;
                      debugPrint("route$route");
                    }
                  }
                }
                return Positioned(
                  bottom: 1,
                  child:
                  state == SearchingState.Searching
                      ? Container(
                          height: 100,
                          color: Colors.white,
                          width: MediaQuery.of(context).size.width,
                          child: const Center(
                            child: CircularProgressIndicator(),
                          ),
                        )
                      :
                  Container(
                    color: Colors.white,
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Where are you going today?",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
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
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Pick-up",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    "My current location",
                                    style: TextStyle(
                                      fontSize: 16,
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  Text(
                                    "Drop off (optional)",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    "Where to?",
                                    style: TextStyle(
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          Row(
                            children: [
                              ElevatedButton.icon(
                                onPressed: () {},
                                icon: SvgPicture.asset("packages/mynewpackage/${Assets.iconsHomeIcon}"),
                                label: Text("Home"),
                                style: ElevatedButton.styleFrom(
                                  surfaceTintColor: AppColors.white,
                                  foregroundColor: Colors.black, backgroundColor: Colors.white,
                                  side: BorderSide(color: Colors.grey),
                                ),
                              ),
                              const SizedBox(width: 10),
                              ElevatedButton.icon(
                                onPressed: () {},
                                icon: SvgPicture.asset("packages/mynewpackage/${Assets.iconsOffice}"),
                                label: Text("Office"),
                                style: ElevatedButton.styleFrom(
                                  foregroundColor: Colors.black, backgroundColor: Colors.white,
                                  surfaceTintColor: AppColors.white,
                                  side: BorderSide(color: Colors.grey),
                                ),
                              ),
                              const SizedBox(width: 15),
                              Container(
                                height: 40,
                                width: 40,
                                decoration: BoxDecoration(
                                  border: Border.all(color: AppColors.borderColor),
                                  borderRadius: BorderRadius.circular(50)
                                ),
                                child: Icon(Icons.arrow_forward_ios,size: 10,color: AppColors.borderColor,),
                              )

                            ],
                          ),
                          const SizedBox(height: 20),
                          const Text(
                            "Saved Places",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            height: 150,
                            child: ListView.builder(
                              itemCount: 2,
                              itemBuilder: (BuildContext context, int index) {
                               return const ListTile(
                                  leading: Icon(Icons.location_on_outlined),
                                  title: Text("Heckenackerstraße 18, 75365 Berlin, Germany"),
                                  subtitle: Text("dummy text"),
                                );
                              },

                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
