import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:mynewpackage/app_colors.dart';

import '../../../../generated/assets.dart';
import '../../../../widgets/common_text.dart';
import '../controllers/promo_code_listing_controller.dart';

class PromoCodeListingView extends GetView<PromoCodeListingController> {
  const PromoCodeListingView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: AppColors.white,
        backgroundColor: AppColors.primaryColor,
        title:  const CommonText(text: 'PromoCode',fontSize: 20,fontWeight: FontWeight.w700,),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: 100,
            color: AppColors.primaryColor,
            child: Padding(
              padding:
              const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(100.0),
                        borderSide: BorderSide.none
                      ),
                      filled: true,
                      hintStyle: TextStyle(color: Colors.grey[800],fontSize: 14),
                      hintText: "Have a promo code? enter it here",
                      // fillColor: Colors.white70,
                      suffix: CommonText(text: "Apply",)
                    ),

                  ),

                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: CommonText(text: "Voucher Available",fontWeight:FontWeight.w700 ,fontSize: 16,),
          ),
          Expanded(
            child: ListView.builder(
              itemCount:controller.title.length,

              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                      surfaceTintColor:AppColors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListTile(
                        title: CommonText(text:controller.title[index],fontSize: 14,fontWeight: FontWeight.w600,),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CommonText(text: 'You just need to pay \$8,00',fontSize: 12),
                            SizedBox(height: 5,),
                            Row(
                              children: [
                                SvgPicture.asset('packages/mynewpackage/${Assets.iconsClock}',height: 14,),
                                SizedBox(width: 10,),
                                CommonText(text: "valid until September 19, 2024",fontSize: 12,)
                              ],
                            )
                          ],
                        ),
                        trailing: ElevatedButton(onPressed: () {  }, child: CommonText(text: 'Use This',fontSize: 12,),
                        style: ButtonStyle(backgroundColor: MaterialStateProperty.all(AppColors.primaryColor),
                        foregroundColor: MaterialStateProperty.all(AppColors.white),)),
                      ),
                    ),
                  ),
                );

              },

            ),
          ),

        ],
      )
    );
  }
}
