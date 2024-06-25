import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:mynewpackage/app_colors.dart';

import '../../../../constants.dart';
import '../../../../generated/assets.dart';
import '../../../../widgets/common_text.dart';
import '../controllers/add_cash_to_wallet_controller.dart';

class AddCashToWalletView extends GetView<AddCashToWalletController> {
  const AddCashToWalletView({super.key});

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
                child: CommonText(
                  textColor: Colors.white,
                  text:Constants.nameFirstLetter,
                ), // Radius of the circle
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: 120,
              color: Colors.blueAccent,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CommonText(
                      textColor:AppColors.white ,

                       text:  "Hi,${Constants.name}",
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    CommonText(
                      fontSize: 18,textColor: AppColors.white,
                         text: "Total Balance",),
                    const SizedBox(
                      height: 5,
                    ),
                    CommonText(
                      textColor: AppColors.white,
                        fontSize:28 ,
                        fontWeight:FontWeight.bold ,
                        text: "\$0.00",),
                  ],
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.all(15.0),
                  child: Text(
                    "Payment Methods",
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 8,
                    right: 8,
                  ),
                  child: Card(
                    surfaceTintColor: AppColors.white,
                    child: Column(
                      children: [
                        PaymentMethodTile(
                          controller: controller,
                          title: 'Apple Pay',
                          value: 1,
                        ),
                        PaymentMethodTile(
                          controller: controller,
                          title: 'UPI',
                          value: 2,
                        ),
                        PaymentMethodTile(
                          controller: controller,
                          title: 'Cash',
                          value: 3,
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8, right: 8),
                  child: Card(
                    surfaceTintColor: AppColors.white,
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
                      title: const Text("Add Credit Card/Debit Card"),
                      trailing: const Icon(
                        Icons.arrow_forward_ios_rounded,
                        size: 12,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8, right: 8, bottom: 25),
                  child: Card(
                    surfaceTintColor: AppColors.white,
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
                      title: const Text("Net Banking"),
                      trailing: const Icon(
                        Icons.arrow_forward_ios_rounded,
                        size: 12,
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 100,
                  width: double.maxFinite,
                  decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(20.0))),
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                              width: 150,
                              decoration: BoxDecoration(
                                  border:
                                      Border.all(color: AppColors.borderColor),
                                  borderRadius: BorderRadius.circular(10)),
                              child: TextButton(
                                  onPressed: () {
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return  CommonAlertDialog(
                                            imagePath: Assets.iconsWallet,
                                            contentOne:
                                                "Want Exlplore Our Services?",
                                            contentTwo:
                                                'Add money to wallet for availing\nthe services',
                                            buttonTextOne:
                                                'Add Money to Wallet',
                                            buttonTextTwo: 'Skip', onButtonOneTap: (){
                                            Navigator.of(context).pop();

                                          }, onButtonTwoTap: (){
                                            Navigator.of(context).pop();

                                          },
                                          );
                                        });
                                  },
                                  child: Text(
                                    "Add Later",
                                    style: TextStyle(
                                        color: AppColors.textLightColor),
                                  ))),
                        ),
                        Container(
                            width: 200,
                            decoration: BoxDecoration(
                                color: AppColors.primaryColor,
                                borderRadius: BorderRadius.circular(10)),
                            child: TextButton(
                                onPressed: () {
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return  CommonAlertDialog(
                                          imagePath: Assets.iconsWallet,
                                          contentOne:
                                          "Congratulations!",
                                          contentTwo:
                                          'You added \$500 to your wallet',
                                          buttonTextOne:
                                          'Explore Our Services',
                                          buttonTextTwo: 'Back to Home', onButtonOneTap: (){
                                            Navigator.of(context).pop();
                                        }, onButtonTwoTap: (){
                                          Navigator.of(context).pop();

                                        },
                                        );
                                      });
                                },
                                child: Text(
                                  "Add cash to Wallet  >",
                                  style: TextStyle(color: AppColors.white),
                                )))
                      ],
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class CommonAlertDialog extends StatelessWidget {
  const CommonAlertDialog(
      {super.key,
      required this.imagePath,
      required this.contentOne,
      required this.contentTwo,
      required this.buttonTextOne,
       this.buttonTextTwo,
      required this.onButtonOneTap,
       this.onButtonTwoTap});

  final String imagePath;
  final String contentOne;
  final String contentTwo;
  final String buttonTextOne;
  final String? buttonTextTwo;
  final  Function onButtonOneTap;
  final  Function? onButtonTwoTap;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppColors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      content: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset("imagePathBase/$imagePath"),
            SizedBox(height: 20),
            // Add spacing if needed
            Column(
              children: [
                const Text(
                  "Hi Michael,",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  contentOne,
                  style:
                      const TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
                  textAlign: TextAlign.center,


                ),
                const SizedBox(
                  height: 5,
                ),
                CommonText(
                 text:  contentTwo,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: AppColors.primaryColor,
                      borderRadius: const BorderRadius.all(Radius.circular(10))),
                  child: TextButton(
                      onPressed: () {
                        onButtonOneTap;
                      },
                      child: Text(
                        buttonTextOne,
                        style: TextStyle(color: AppColors.white),
                      )),
                ),
               buttonTextTwo != "" ? const SizedBox(
                  height: 10,
                ):SizedBox.shrink(),
                buttonTextTwo != "" ? TextButton(
                    onPressed: () {
                      onButtonOneTap;
                    },
                    child: Text(buttonTextTwo!)):SizedBox.shrink()
              ],
            ),
            // Add more widgets as needed
          ],
        ),
      ),
    );
  }
}

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
            )
        ),
      );
    });
  }
}
