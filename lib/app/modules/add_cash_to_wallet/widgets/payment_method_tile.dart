import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../app_colors.dart';
import '../../../../constants.dart';
import '../controllers/add_cash_to_wallet_controller.dart';

class PaymentMethodTile extends StatelessWidget {
  const PaymentMethodTile(
      {super.key,
      required this.controller,
      required this.title,
      required this.value});

  final AddCashToWalletController controller;
  final String title;
  final int value;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Padding(
        padding: const EdgeInsets.all(5.0),
        child: ListTile(
            leading: SizedBox(
              height: 35,
              width: 35,
              child: CircleAvatar(
                backgroundColor: Colors.grey[200],
                radius: 50,
                child: Text(
                  Constants.nameFirstLetter,
                  style: const TextStyle(color: Colors.white),
                ), // Radius of the circle
              ),
            ),
            title: Text(
              title,
            ),
            trailing: SizedBox(
              height: 10,
              width: 10,
              child: Radio(
                  activeColor: AppColors.primaryColor,
                  value: value,
                  groupValue: controller.selectedRadio.value,
                  onChanged: (value) {
                    controller.selectedRadio.value = value ?? 0;
                  }),
            )),
      );
    });
  }
}
