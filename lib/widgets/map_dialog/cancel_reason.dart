import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:mynewpackage/app/modules/cab/controllers/cab_map_controller.dart';
import 'package:mynewpackage/widgets/custom_button.dart';

import '../../app/modules/home/views/home_view.dart';
import '../../app_colors.dart';
import '../../generated/assets.dart';
import '../common_text.dart';

class CancelReason extends StatelessWidget {
   CancelReason({
    super.key,
  });

  CabMapController cabMapController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: SizedBox(
        child: Card(
          color: AppColors.white,
          surfaceTintColor: AppColors.white,
          elevation: 5,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    IconButton(onPressed: (){}, icon: Icon(Icons.arrow_back)),
                    SizedBox(width: MediaQuery.of(context).size.width/10,),
                    CommonText(text: 'Cancel Booking',fontSize: 18,fontWeight: FontWeight.w700,)
                  ],
                ),
                CommonText(text: 'Please select the reason for cancellation'),
                SizedBox(
                  height: 250,
                  child: ListView.builder(
                    itemCount: 4,
                      itemBuilder: (context, index){
                    return Row(
                      children: [
                        Obx(
                           () {
                            return Radio(    value: index,
                                activeColor: AppColors.primaryColor,
                                groupValue: cabMapController.selectedCancelReason.value, onChanged: (value){
                                  cabMapController.selectedCancelReason.value = value!;
                                });
                          }
                        ),
                        CommonText(text: '')
                      ],
                    );
                  }),
                ),
                CommonText(text: 'Other',fontSize: 16,fontWeight: FontWeight.w700,),
                SizedBox(height: 10,),
                TextFormField(
                  maxLines: 5,

                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      borderSide: BorderSide(
                        color: AppColors.borderColor,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      borderSide: BorderSide(
                        color: AppColors.borderColor,
                        width: 2.0,
                      ),
                    ),
                    border: InputBorder.none,
                    hintText: 'Enter your reason',
                    hintStyle: TextStyle(color: AppColors.borderColor),
                    fillColor: AppColors.textFieldBackground,
                    contentPadding: const EdgeInsets.only(
                        left: 14.0, bottom: 6.0, top: 8.0),

                  ),
                ),
                Spacer(),
                CommonButton(onPressed: (){

                }, text:'Cancel Ride')

              ],
            ),
          )
        ),
      ),
    );
  }
}
