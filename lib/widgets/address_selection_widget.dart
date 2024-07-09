import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:location/location.dart' as location;
import 'package:mynewpackage/app/helper/alert_helper.dart';
import 'package:mynewpackage/app/modules/home/controllers/home_controller.dart';
import 'package:url_launcher/url_launcher.dart';

import 'address_selection_dialogue.dart';

class AddressSelectionWidget extends StatelessWidget {
  AddressSelectionWidget({
    super.key,
    required this.onAddressSelect,
    required this.address,
    this.borderColor,
  });

  final Function onAddressSelect;
  final String address;
  final Color? borderColor;
  final location.Location locationStatus = location.Location();

  @override
  Widget build(BuildContext context) {
    HomeController homeController = Get.find();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: () async {
            if (Platform.isIOS) {
              await requestLocationPermission(context);
            } else {
              await homeController.requestLocationForAndroid(context: context);
            }
          },
          onLongPress: () {
            Clipboard.setData(ClipboardData(text: address));
            OverlayEntry overlayEntry;
            overlayEntry = OverlayEntry(
              builder: (context) => Positioned(
                bottom: 10, // Adjust the position as needed
                left: 10,
                right: 10,
                child: Material(
                  color: Colors.grey,
                  child: Center(
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      // child: CommonText(
                      //   text: LocaleKeys.copied.tr,
                      //   textStyle: const TextStyle(color: Colors.white),
                      // ),
                    ),
                  ),
                ),
              ),
            );
            Overlay.of(context).insert(overlayEntry);
            // Hide the copy confirmation after a short delay
            Future.delayed(const Duration(seconds: 2), () {
              overlayEntry.remove();
            });
          },
          // child: Row(
          //   children: [
          //     Icon(
          //       Icons.add_circle_outline,
          //       color: colorController.primaryColor.value,
          //     ),
          //     const SizedBox(
          //       width: 10,
          //     ),
          //     Text(
          //       "Add New Address",
          //       style: TextStyle(
          //           color: colorController.primaryColor.value,
          //           fontWeight: FontWeight.w800),
          //     ),
          //   ],
          // ),
        ),
        const SizedBox(
          height: 6,
        ),
      ],
    );
  }

  Future<void> requestLocationPermission(BuildContext context) async {
    try {
      location.PermissionStatus permission =
          await locationStatus.requestPermission();
      if (permission == location.PermissionStatus.granted) {
        await showDialog(
          context: context,
          builder: (BuildContext context) {
            return RideDialog(
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
                onAddressSelect(
                  address,
                  lat,
                  lng,
                  zip,
                  city,
                  state,
                  streetNumber,
                  route,
                  stateIsoCode,
                );
              },
            );
          },
        );
      } else {
        await AlertHelper.showAlert(
            title: "",
            content:
                'Location permission is not allowed. Please allow it in Location Services -> Amagi Caregiver App',
            hasCancel: false,
            confirmText: "OK",
            onConfirm: () {
              openLocationServicesSettings();
              Get.close(1);
            },
            isLoading: ValueNotifier(false),
            onCancel: () {},
            context: context);
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
}
