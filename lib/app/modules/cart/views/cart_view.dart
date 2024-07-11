import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:mynewpackage/app/modules/home/controllers/home_controller.dart';
import 'package:mynewpackage/app_colors.dart';
import 'package:mynewpackage/widgets/custom_ride_button.dart';

import '../../../../generated/assets.dart';
import '../../../../widgets/common_text.dart';
import '../../../../widgets/custom_button.dart';
import '../controllers/cart_controller.dart';

class CartView extends GetView<CartController> {
  HomeController homeController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.backgroundColor,
        appBar: AppBar(
          backgroundColor: AppColors.backgroundColor,
          title: InkWell(
            onTap: () {
              homeController.showAddressSelectionBottomSheet(context: context);
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  // mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    CommonText(
                      fontSize: 14,
                      textColor: AppColors.textLightColor,
                      text: "Delivery Location",
                    ),
                    InkWell(
                      onTap: () {},
                      child: const Icon(
                        Icons.keyboard_arrow_down_sharp,
                        size: 14,
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Obx(() {
                  return Row(
                    children: [
                      const SizedBox(
                        width: 5,
                      ),
                      Expanded(
                          child: CommonText(
                        fontSize: 14,
                        maxLines: 1,
                        fontWeight: FontWeight.w800,
                        textOverflow: TextOverflow.ellipsis,
                        text: homeController.address.value,
                      )),
                    ],
                  );
                }),
              ],
            ),
          ),
          centerTitle: true,
        ),
        body: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20,bottom: 120,right: 20),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Flexible(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: AppColors.white,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              ListView.builder(
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: 2,
                                itemBuilder: (context, index) {
                                  var _count = 1;
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20),
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            Column(
                                              children: [
                                                CommonText(
                                                  text: 'Food Name',
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                                CommonText(
                                                  text: 'Food Name',
                                                  textColor: AppColors.textLightColor,
                                                ),
                                              ],
                                            ),
                                            Spacer(),
                                            if (_count == 0)
                                              InkWell(
                                                onTap: () {},
                                                child: SvgPicture.asset(
                                                  "packages/mynewpackage/${Assets.iconsAddIcon}",
                                                  color: AppColors.primaryColor,
                                                ),
                                              ),
                                            if (_count > 0) ...[
                                              Container(
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(50),
                                                  color: AppColors.primaryColor,
                                                ),
                                                height: 30,
                                                child: Padding(
                                                  padding: const EdgeInsets.symmetric(
                                                      horizontal: 15),
                                                  child: Row(
                                                    mainAxisSize: MainAxisSize.min,
                                                    children: [
                                                      InkWell(
                                                        onTap: () {},
                                                        child: const Icon(
                                                            size: 20,
                                                            Icons.remove,
                                                            color: Colors.white),
                                                      ),
                                                      const SizedBox(width: 8),
                                                      CommonText(
                                                          text: '$_count',
                                                          textColor: Colors.white),
                                                      const SizedBox(width: 8),
                                                      InkWell(
                                                        onTap: () {},
                                                        child: const Icon(
                                                            size: 20,
                                                            Icons.add,
                                                            color: Colors.white),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                            SizedBox(
                                              width: 10,
                                            ),
                                            CommonText(text: '248')
                                          ],
                                        ),
                                        Divider(),
                                      ],
                                    ),
                                  );
                                },
                              ),
                              SizedBox(
                                width: 150,
                                  height: 30,
                                  child: CustomRideButton(text: '+ Add More Items', onTap: (){}))
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    CommonText(text: "Offers & Benefits",
                    fontSize: 18,fontWeight: FontWeight.w700,),
                    SizedBox(
                      height: 10,
                    ),
                    ListTile(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      tileColor: AppColors.white,
                      leading: CommonText(text: 'Apply Coupon Code',),
                      trailing: Icon(Icons.arrow_forward_ios,size: 15,),
                    ),
                    SizedBox(height: 10,),
                    CommonText(text: 'Bill Summary',fontWeight: FontWeight.w700,fontSize: 17,),
                    SizedBox(height: 5,),
                    Card(
                      color: AppColors.white,
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          children: [
                            BillItems(title: 'Item Total', price: '16.15',),
                            BillItems(title: 'Delivery Fee', price: 'Free',),
                            BillItems(title: 'GST & Restaurant Changes', price: '0.00',),
                            BillItems(title: 'Platform Fee', price: '0.00',),
                            Divider(),
                            Row(
                              children: [
                                CommonText(text: 'Grand Total',fontSize: 16,fontWeight: FontWeight.w600,),
                                Spacer(),
                                CommonText(text: '16.5',fontSize: 16,fontWeight: FontWeight.w600),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 10,),
                    CommonText(text: 'Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old.'),
                    SizedBox(height: 20,),
                    CommonText(text: 'Read Cancellation Policy',  textStyle: TextStyle(
                      decoration: TextDecoration.underline,
                    ),)
                
                
                  ],
                ),
              ),

            ),
            Container(
              height: 100,
              decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      offset: Offset(0.0, 1.0), //(x,y)
                      blurRadius: 2.0,
                    ),
                  ],
                  color: AppColors.white,
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(25),topRight: Radius.circular(25))
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(child: CommonText(text: 'Total 121')),
                    Expanded(child: CommonButton(onPressed: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (context) =>
                                  CartView()));
                    }, text: 'Place Order',)),
                  ],
                ),
              ),
            )


          ],
        ));
  }
}

class BillItems extends StatelessWidget {
  const BillItems({
    super.key, required this.title, required this.price,
  });

  final String title;
  final String price;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          CommonText(text: title),
          Spacer(),
          CommonText(text: price)
        ],
      ),
    );
  }
}
