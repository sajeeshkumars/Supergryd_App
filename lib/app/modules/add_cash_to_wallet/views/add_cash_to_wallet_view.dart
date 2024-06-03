import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mynewpackage/app_colors.dart';

import '../../../../constants.dart';
import '../controllers/add_cash_to_wallet_controller.dart';

class AddCashToWalletView extends GetView<AddCashToWalletController> {
  AddCashToWalletView({super.key});

  List title = ["Apple Pay", "UPI", "Cash"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        foregroundColor: AppColors.white,
        backgroundColor: Colors.blueAccent,
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              height: 42,
              width: 42,
              child: CircleAvatar(
                backgroundColor: AppColors.primaryColor,
                radius: 50,
                child: Text(
                  Constants.nameFirstLetter,
                  style: TextStyle(color: Colors.white),
                ), // Radius of the circle
              ),
            ),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: Get.width,
            height: 150,
            color: Colors.blueAccent,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Hi,${Constants.name}",
                    style: TextStyle(color: AppColors.white),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text("Total Balance",
                      style: TextStyle(color: AppColors.white, fontSize: 18)),
                  SizedBox(
                    height: 5,
                  ),
                  Text("\$0.00",
                      style: TextStyle(
                          color: AppColors.white,
                          fontSize: 28,
                          fontWeight: FontWeight.bold)),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Payment Methods",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 10,
                ),
                Card(
                  elevation: 5,
                  surfaceTintColor: AppColors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      height: 180,
                      child:
                           ListView.builder(
                            itemCount: title.length,
                            itemBuilder: (context, index) {
                              return RadioListTile<int>(
                                value: index,
                                groupValue: controller.selectedRadio.value,
                                title: Text(title[index]),
                                onChanged: (int? value) {
                                  controller.selectedRadio.value = value ?? 0;
                                },
                              );
                            },
                          )
                          //   ListTile(
                          //   leading: SizedBox(
                          //     height: 40,
                          //     width: 40,
                          //     child: CircleAvatar(
                          //       backgroundColor: Colors.grey,
                          //       radius: 50,
                          //       child: Text(
                          //         Constants.nameFirstLetter,
                          //         style: TextStyle(color: Colors.white),
                          //       ), // Radius of the circle
                          //     ),
                          //   ),
                          //   title: Text(title[index]),
                          //   trailing: Obx(
                          //     () {
                          //       return Radio(
                          //       value: title[index],
                          //       groupValue: controller.selectedRadio,
                          //       onChanged: (value) {
                          //       controller.selectedRadio = value;
                          //       });
                          //     }
                          //   ),
                          // );
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
