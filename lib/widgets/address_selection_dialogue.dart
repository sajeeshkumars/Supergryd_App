import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_place_picker/google_maps_place_picker.dart';
import 'package:mynewpackage/app/modules/home/controllers/home_controller.dart';
import 'package:mynewpackage/app/modules/home/views/home_view.dart';
import 'package:mynewpackage/app_colors.dart';


import '../generated/assets.dart';
import 'common_text.dart';


class RideDialog extends StatelessWidget {
  RideDialog(
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

  String? zipCode = '';

  String? city = '';

  String? stateName = '';

  String? stateIsoCode = '';

  String? streetNumber = '';

  String? route = '';

  Enum? searchingState;

  HomeController homeController = Get.find();

  List carImage = ["packages/mynewpackage/${Assets.iconsNormal}","packages/mynewpackage/${Assets.iconsEconomyCar}","packages/mynewpackage/${Assets.iconsEconomyCar}"];
  List rideType = ["Normal","Economy","Comfort"];
  List time = ["2","4","6"];
  List seat = ["2","5","6"];
  List price = ["1.99","2","3.6"];
  RxInt? selectedType = 0.obs;
  RxString selectedPaymentType = 'Apple Pay'.obs;
  RxBool isRequestSent = false.obs;

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
                  left: 1,
                  right: 1,
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
                    Obx(
                      () {
                        return controller.isDestinationSelected.value == false ?
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Card(
                            color: AppColors.white,
                            surfaceTintColor: AppColors.white,
                            elevation: 5,
                            child: Container(
                              decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(20)),                          color: Colors.white,
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
                                      const Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          CommonText(
                                           text:  "Pick-up",
                                              fontSize: 12,
                                              textColor: Colors.grey,
                                          ),
                                          SizedBox(height: 2),
                                          CommonText(
                                          text:   "My current location",
                                              fontSize: 16,
                                          ),
                                          SizedBox(height: 20),
                                          CommonText(
                                           text:  "Drop off (optional)",
                                              fontSize: 12,
                                              textColor: Colors.grey,
                                          ),
                                          SizedBox(height: 2),
                                          CommonText(
                                            text: "Where to?",
                                              fontSize: 16,
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
                                        label: const CommonText(text: "Home"),
                                        style: ElevatedButton.styleFrom(
                                          surfaceTintColor: AppColors.white,
                                          foregroundColor: Colors.black, backgroundColor: Colors.white,
                                          side: const BorderSide(color: Colors.grey),
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      ElevatedButton.icon(
                                        onPressed: () {},
                                        icon: SvgPicture.asset("packages/mynewpackage/${Assets.iconsOffice}"),
                                        label: const CommonText(text: "Office"),
                                        style: ElevatedButton.styleFrom(
                                          foregroundColor: Colors.black, backgroundColor: Colors.white,
                                          surfaceTintColor: AppColors.white,
                                          side: const BorderSide(color: Colors.grey),
                                        ),
                                      ),
                                      const SizedBox(width: 15),
                                      InkWell(
                                        onTap: (){
                                          controller.isDestinationSelected.value = true;
                                        },
                                        child: Container(
                                          height: 40,
                                          width: 40,
                                          decoration: BoxDecoration(
                                            border: Border.all(color: AppColors.borderColor),
                                            borderRadius: BorderRadius.circular(50)
                                          ),
                                          child: Icon(Icons.arrow_forward_ios,size: 10,color: AppColors.borderColor,),
                                        ),
                                      )

                                    ],
                                  ),
                                  const SizedBox(height: 20),
                                  const CommonText(
                                   text:  "Saved Places",
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
                                          title: CommonText(text:"Heckenackerstraße 18, 75365 Berlin, Germany",),
                                          subtitle: CommonText(text:"dummy text"),
                                        );
                                      },

                                    ),
                                  ),
                                ],
                              ),
                            ),
                                              ),
                          ),
                        ):Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Card(
                            color: AppColors.white,
                            surfaceTintColor: AppColors.white,
                            elevation: 5,
                            child:isRequestSent.value == false ?Container(
                              decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(20)),color: Colors.white,
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
                                      text: "Choose your ride",
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    const SizedBox(height: 10),
                                    SizedBox(
                                      height: 150,
                                      child: ListView.builder(
                                        itemCount: rideType.length,
                                        itemBuilder: (context, index) {
                                          return Card(
                                            elevation: 1,
                                              surfaceTintColor:AppColors.white,
                                            color: AppColors.white,
                                            child: ListTile(

                                              leading: SvgPicture.asset(carImage[index]),
                                              title: CommonText(text: rideType[index],fontSize: 14,fontWeight: FontWeight.w600,),
                                              subtitle: Row(
                                                children: [
                                                  CommonText(text: '\$${price[index]}',fontSize: 14,fontWeight: FontWeight.w600),
                                                  const SizedBox(width: 5,),
                                                  SvgPicture.asset("packages/mynewpackage/${Assets.iconsClock}",color: AppColors.borderColor),
                                                  // Icon(Icons.access_time,size: 16,color: AppColors.borderColor,),
                                                  CommonText(text: '${time[index]} min',fontSize: 16,textColor: AppColors.borderColor,),
                                                  const SizedBox(width: 5,),

                                                  // Icon(Icons.person_pin,color: AppColors.borderColor,size: 16,),
                                                  SvgPicture.asset("packages/mynewpackage/${Assets.iconsSeats}",color: AppColors.borderColor,),

                                                  CommonText(text: '${seat[index]} Seats',fontSize: 16,textColor: AppColors.borderColor,),

                                                ],
                                              ),
                                              trailing:SizedBox(
                                                height: 23,
                                                width: 23,
                                                child: Obx(
                                                  () {
                                                    return Radio(
                                                        activeColor: AppColors.primaryColor,
                                                        value: index,
                                                        groupValue: selectedType?.value,
                                                        onChanged: (value) {
                                                          selectedType?.value = value!;
                                                          // controller.selectedRadio.value = value ?? 0;
                                                        });
                                                  }
                                                ),
                                              ) ,
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                    const SizedBox(height: 20),
                                    Row(
                                      children: [
                                        SvgPicture.asset("packages/mynewpackage/${Assets.iconsKilometer}",),
                                        SizedBox(width: MediaQuery.of(context).size.width*.01,),
                                        const CommonText(text: "21 km"),
                                        SizedBox(width: MediaQuery.of(context).size.width*.2,),
                                        SvgPicture.asset("packages/mynewpackage/${Assets.iconsClock}",),
                                        SizedBox(width: MediaQuery.of(context).size.width*.01,),
                                        const CommonText(text: "8 min"),
                                        SizedBox(width: MediaQuery.of(context).size.width*.2,),
                                        SvgPicture.asset("packages/mynewpackage/${Assets.iconsDollarCircle}",),
                                        SizedBox(width: MediaQuery.of(context).size.width*.01,),
                                        const CommonText(text: "\$1.99"),

                                      ],
                                    ),
                                    SizedBox(height: MediaQuery.of(context).size.height*.02,),
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
                                                .map<DropdownMenuItem<String>>((String value) {
                                              return DropdownMenuItem<String>(
                                                value: value,
                                                child: CommonText(text:value,fontSize: 12,),
                                              );
                                            }).toList(),
                                          );
                                        }),
                                        Spacer(),

                                        Container(
                                          height: 40,
                                          // width: 100,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(25),
                                            border: Border.all(color: AppColors.borderColor)
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Row(
                                              children: [
                                                SvgPicture.asset("packages/mynewpackage/${Assets.iconsOfferIcon}",height: 15,),
                                                const SizedBox(width: 2,),
                                                const CommonText(text: "Promo code",fontSize: 12,)

                                              ],
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                    ElevatedButton(
                                      style: ButtonStyle(
                                        backgroundColor: MaterialStateProperty.all(AppColors.primaryColor),
                                        minimumSize: MaterialStateProperty.all(Size(340,70)),
                                      ),
                                        onPressed: (){
                                          isRequestSent.value = true;
                                        }, child: Row(
                                      children: [
                                        CommonText(text: "Request",textColor: AppColors.white,),
                                        Spacer(),
                                        CommonText(text:"\$ 1.99",textColor: AppColors.white),
                                        SizedBox(width: 10,),
                                        Container(
                                          height: 40,
                                          width: 40,
                                          decoration: BoxDecoration(color: AppColors.white,
                                          borderRadius: BorderRadius.circular(30)),
                                          child: Icon(Icons.arrow_forward_ios,color: AppColors.primaryColor,),)
                                      ],
                                    ))




                                  ],
                                ),
                              ),
                            ):Container(
                              decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(20)),color: Colors.white,
                              ),
                              width: MediaQuery.of(context).size.width,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 25),
                                child: Column(
                                  children: [
                                    SvgPicture.asset("packages/mynewpackage/${Assets.iconsLoadingDriver}"),
                                    CommonText(text: "Loading Your Nearest Driver",fontSize: 20,fontWeight: FontWeight.w800,),
                                    CommonText(text: "Hang tight! We're connecting you with\nthe closest available driver. This may\ntake a moment.",
                                    textAlign: TextAlign.center,)


                                  ],
                                ),
                              ),
                            )
                          ),
                        );
                      }
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
