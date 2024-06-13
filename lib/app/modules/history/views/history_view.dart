import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:mynewpackage/widgets/common_text.dart';

import '../../../../app_colors.dart';
import '../controllers/history_controller.dart';

class HistoryView extends GetView<HistoryController> {
  const HistoryView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                children: [
                  Icon(Icons.arrow_back_rounded),
                  CommonText(text: 'History'),
          Spacer(),
          Obx(
             () {
              return Container(
                height: 35,
                decoration: BoxDecoration(
                    color: Colors.black,

                    borderRadius: BorderRadius.circular(40)
                ),
                child: DropdownButtonHideUnderline(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: DropdownButton<
                        String>(
                      dropdownColor: Colors.black,
                      icon:  Icon(Icons
                          .keyboard_arrow_down,
                      color: AppColors.white,),
                      value:
                      controller.selectedFilter
                          .value,
                      onChanged: (String?
                      newValue) {
                       controller. selectedFilter
                            .value =
                        newValue!;
                      },
                      items: <String>[
                        'This Month',
                        'This Year',
                        'Last Year'
                      ].map<
                          DropdownMenuItem<
                              String>>((String
                      value) {
                        return DropdownMenuItem<
                            String>(
                          value: value,
                          child:
                          CommonText(
                            text: value,
                            fontSize:
                            12,
                            textColor: AppColors.white,
                          ),
                        );
                      }).toList(),


                    ),
                  ),
                ),
              );
            }
          )],
              )

            ],
          ),
        ),
      )
    );
  }
}
