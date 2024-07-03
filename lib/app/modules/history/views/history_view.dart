import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:mynewpackage/app/core/utility.dart';
import 'package:mynewpackage/widgets/common_text.dart';
import 'package:mynewpackage/widgets/custom_button.dart';

import '../../../../app_colors.dart';
import '../../../../generated/assets.dart';
import '../controllers/history_controller.dart';

class HistoryView extends GetView<HistoryController> {
  const HistoryView({super.key});
  @override
  Widget build(BuildContext context) {
    return   DefaultTabController(
      length: 4, // Number of tabs
      child: Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              const CommonText(
                text: 'History',
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
              const Spacer(),
              Obx(() {
                return Container(
                  height: 35,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(40),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: DropdownButton<String>(
                        dropdownColor: Colors.black,
                        icon: Icon(
                          Icons.keyboard_arrow_down,
                          color: AppColors.white,
                        ),
                        value: controller.selectedFilter.value,
                        onChanged: (String? newValue) {
                          controller.selectedFilter.value = newValue!;
                        },
                        items: <String>[
                          'This Month',
                          'This Year',
                          'Last Year',
                        ].map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: CommonText(
                              text: value,
                              fontSize: 12,
                              textColor: AppColors.white,
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                );
              }),
            ],
          ),
          bottom: TabBar(
            tabAlignment: TabAlignment.start,
            padding: const EdgeInsets.only(left: 20),
            isScrollable: true,
            splashFactory: NoSplash.splashFactory,
            indicatorColor: AppColors.primaryColor,
            labelColor: AppColors.primaryColor,
            labelStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            tabs: const <Widget>[
              Tab(
                text: "Cab",
              ),
              Tab(
                text: "Food",
              ),
              Tab(
                text: "Micro Mobility",
              ),
              Tab(
                text: "Experience",
              ),
            ],
          ),
        ),
        body: Obx(
          () {
            return controller.isRideHistoryLoading.value ? Center(child: CircularProgressIndicator()): controller.historyList.isEmpty ? Center(child: CommonText(text: 'No Ride Found')): TabBarView(
              children: <Widget>[
                // Add your widgets here
                Center(child: ListView.builder(
                  itemCount:controller.historyList.length,

                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        color: AppColors.white,
                        surfaceTintColor:AppColors.white,
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
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
                                    crossAxisAlignment:
                                    CrossAxisAlignment
                                        .start,
                                    children: [
                                      CommonText(
                                        text:
                                        controller.historyList[index].originAddress!.first.address.toString(),
                                        fontSize: 14,
                                      ),
                                      CommonText(text:controller.historyList[index].startTime != null ?Utility.dateAndTime(controller.historyList[index].startTime.toString()):"" ,textColor: AppColors.borderColor,),
                                      SizedBox(height: 20),
                                      CommonText(
                                        text: controller.historyList[index].destinationAddress!.first.address.toString(),
                                        fontSize: 14,
                                      ),
                                      CommonText(text:controller.historyList[index].endTime != null ? Utility.dateAndTime(controller.historyList[index].endTime.toString()):"",textColor: AppColors.borderColor,),

                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(height: 5,),
                              Container(
                                width: 82,
                                height: 24,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(25),
                                  color:controller.historyList[index].status == 6 ? Colors.green : Colors.red,

                                ),
                                child: Center(
                                  child: CommonText(text: controller.historyList[index].status == 6 ?"Completed":"Canceled",textColor:AppColors.white,
                                  fontSize: 12,),
                                ),
                              ),
                              SizedBox(height: 5,),
                              Divider(),

                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 10),
                                child:Row(
                                  children: [
                                    SvgPicture.asset(
                                      "packages/mynewpackage/${Assets.iconsDollarCircle}",
                                    ),
                                    SizedBox(
                                      width: MediaQuery.of(
                                          context)
                                          .size
                                          .width *
                                          .01,
                                    ),
                                    CommonText(
                                        text: '₹ '+controller.historyList[index].estimatedPrice.toString()),
                                  ],
                                )

                                // Row(
                                //   children: [
                                //     SvgPicture.asset(
                                //       "packages/mynewpackage/${Assets.iconsDateRangeLight}",
                                //     ),
                                //     SizedBox(
                                //       width: MediaQuery.of(
                                //           context)
                                //           .size
                                //           .width *
                                //           .01,
                                //     ),
                                //      CommonText(
                                //         text: controller.historyList[index].requestedTime.toString()),
                                //     SizedBox(
                                //       width: MediaQuery.of(
                                //           context)
                                //           .size
                                //           .width *
                                //           .045,
                                //     ),
                                //
                                //     SvgPicture.asset(
                                //       "packages/mynewpackage/${Assets.iconsClock}",
                                //     ),
                                //     SizedBox(
                                //       width: MediaQuery.of(
                                //           context)
                                //           .size
                                //           .width *
                                //           .01,
                                //     ),
                                //
                                //      CommonText(
                                //         text: controller.historyList[index].startTime.toString()),
                                //   Spacer(),
                                //     SvgPicture.asset(
                                //       "packages/mynewpackage/${Assets.iconsDollarCircle}",
                                //     ),
                                //     SizedBox(
                                //       width: MediaQuery.of(
                                //           context)
                                //           .size
                                //           .width *
                                //           .01,
                                //     ),
                                //      CommonText(
                                //         text: controller.historyList[index].estimatedPrice.toString()),
                                //
                                //   ],
                                // ),
                              ),
                              Divider(),

                              controller.historyList[index].status == 6 ?      ListTile(
                                  leading:controller.historyList[index].driverDetails!.isNotEmpty ? CircleAvatar(
                                    radius: 30.0,
                                    backgroundImage:
                                    NetworkImage(controller.historyList[index].driverDetails!.first.pictureUrl.toString()),
                                    backgroundColor: Colors.transparent,
                                  ):CircleAvatar(),
                                title: CommonText(text:(controller.historyList[index].driverDetails!.isNotEmpty ? controller.historyList[index].driverDetails?.first.name : "").toString(),),
                                subtitle: Row(
                                  children: [
                                    SvgPicture.asset(
                                      "packages/mynewpackage/${Assets.iconsStar}",
                                    ),
                                    SizedBox(width: 2,),
                                    CommonText(text:(controller.historyList[index].driverDetails!.isNotEmpty ?  controller.historyList[index].driverDetails?.first.rating : "").toString())
                                  ],
                                ),
                                trailing: CommonButton(
                                  width: 140,
                                    height: 45,
                                    onPressed: (){}, text: "Rebook"),
                              ):SizedBox.shrink()
                            ],
                          ),
                        )
                      ),
                    );

                  },

                ),),
                Center(child: Text('Dishes')),
                Center(child: Text('Dishes')),
                Center(child: Text('Dishes')),
              ],
            );
          }
        ),
      ),
    );
  }
}
