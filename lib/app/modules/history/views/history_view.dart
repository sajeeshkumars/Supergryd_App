import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
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
        body: TabBarView(
          children: <Widget>[
            // Add your widgets here
            Center(child: ListView.builder(
              itemCount:3,

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
                                    "Sonnenweg 32, 79669 Berlin, Germany",
                                    fontSize: 14,
                                  ),
                                  CommonText(text: "7:34 AM",textColor: AppColors.borderColor,),
                                  SizedBox(height: 20),
                                  CommonText(
                                    text: "St.-Martin-Straße 14, 93099 Berlin,Germany",
                                    fontSize: 14,
                                  ),
                                  CommonText(text: "7:48 AM",textColor: AppColors.borderColor,),

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
                              color: Colors.green,

                            ),
                            child: Center(
                              child: CommonText(text: 'Completed',textColor:AppColors.white,
                              fontSize: 12,),
                            ),
                          ),
                          SizedBox(height: 5,),
                          Divider(),

                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Row(
                              children: [
                                SvgPicture.asset(
                                  "packages/mynewpackage/${Assets.iconsDateRangeLight}",
                                ),
                                SizedBox(
                                  width: MediaQuery.of(
                                      context)
                                      .size
                                      .width *
                                      .01,
                                ),
                                const CommonText(
                                    text: "28 May 2024"),
                                SizedBox(
                                  width: MediaQuery.of(
                                      context)
                                      .size
                                      .width *
                                      .045,
                                ),

                                SvgPicture.asset(
                                  "packages/mynewpackage/${Assets.iconsClock}",
                                ),
                                SizedBox(
                                  width: MediaQuery.of(
                                      context)
                                      .size
                                      .width *
                                      .01,
                                ),

                                const CommonText(
                                    text: "10:45AM"),
                              Spacer(),
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
                                const CommonText(
                                    text: "\$1.99"),

                              ],
                            ),
                          ),
                          Divider(),

                          ListTile(
                            leading: CircleAvatar(),
                            title: CommonText(text: "John Doe",),
                            subtitle: Row(
                              children: [
                                SvgPicture.asset(
                                  "packages/mynewpackage/${Assets.iconsStar}",
                                ),
                                SizedBox(width: 2,),
                                CommonText(text: "4.5")
                              ],
                            ),
                            trailing: CommonButton(
                              width: 140,
                                height: 45,
                                onPressed: (){}, text: "Rebook"),
                          )
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
        ),
      ),
    );
  }
}
