import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:mynewpackage/widgets/common_text.dart';

import '../../../../app_colors.dart';
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
              CommonText(
                text: 'History',
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
              Spacer(),
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
            Center(child: Text('Restaurants')),
            Center(child: Text('Dishes')),
            Center(child: Text('Dishes')),
            Center(child: Text('Dishes')),
          ],
        ),
      ),
    );
  }
}
