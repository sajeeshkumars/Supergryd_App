import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';

import '../../app/modules/home/views/home_view.dart';
import '../../app_colors.dart';
import '../../constants.dart';
import '../../generated/assets.dart';
import '../common_text.dart';

class TripDetails extends StatelessWidget {
  const TripDetails({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        height: 600,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            color: Colors.white,
          ),
          width: MediaQuery.of(context).size.width,
          child: Padding(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              child: InkWell(
                onTap: () {},
                child: Center(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CommonText(
                          text: "Ride Details",
                          fontWeight: FontWeight.w800,
                          fontSize: 14,
                        ),
                        ListTile(
                          leading: CircleAvatar(),
                          title: CommonText(
                              text: Constants.driverName.toString(),
                              fontWeight: FontWeight.w700),
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
                              CommonText(text: "${controller.rideDistance}km"),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * .1,
                              ),
                              SvgPicture.asset(
                                "packages/mynewpackage/${Assets.iconsClock}",
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * .01,
                              ),
                              CommonText(text: "${controller.rideDuration} min"),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * .1,
                              ),
                              SvgPicture.asset(
                                "packages/mynewpackage/${Assets.iconsDollarCircle}",
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * .01,
                              ),
                              CommonText(text: "₹ ${controller.price}"),
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
                                text: '${controller.rideDuration} min',
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
                                text: '${controller.seatCapacity} Seats',
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
                              Flexible(
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
                                      textOverflow: TextOverflow.ellipsis,
                                      maxLines: 3,
                                      text: "${controller.selectedPickUp.value}",
                                      fontSize: 12,
                                    ),
                                    SizedBox(height: 20),
                                    CommonText(
                                      text: "Drop off",
                                      fontSize: 12,
                                      textColor: Colors.grey,
                                    ),
                                    SizedBox(height: 2),
                                    CommonText(
                                      textOverflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                      text: "${controller.selectedDropOff.value}",
                                      fontSize: 12,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Row(
                            children: [
                              CommonText(text: "Payment methods"),
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
                                text: "₹ ${controller.price}",
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
                ),
              ))),
    );
  }
}
