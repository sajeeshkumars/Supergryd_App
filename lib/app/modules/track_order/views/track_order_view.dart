import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:mynewpackage/app/modules/cart/controllers/cart_controller.dart';
import 'package:mynewpackage/app_colors.dart';
import 'package:mynewpackage/widgets/common_text.dart';
import 'package:mynewpackage/widgets/custom_button.dart';

import '../../../../generated/assets.dart';
import '../../../../widgets/map_dialog/cancel_reason.dart';
import '../controllers/track_order_controller.dart';

class TrackOrderView extends GetView<TrackOrderController> {
  CartController cartController = Get.find();
  @override
  Widget build(BuildContext context) {
    debugPrint("cart count in track order ${cartController.viewCartResponse?.data?.cartItmes?.length}");
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(150.0), // here the desired height
          child: AppBar(
            foregroundColor: AppColors.white,
            backgroundColor: AppColors.primaryColor,
            flexibleSpace: Obx(
               () {
                return cartController.isTrackOrderLoading.value ? SizedBox.shrink(): Container(
                  width: MediaQuery.of(context).size.width,
                  color: AppColors.primaryColor,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CommonText(text: 'Order from ---',textColor: AppColors.white,),
                      CommonText(text: cartController.orderTrackResponse!.message.toString(),fontSize: 18,textColor: AppColors.white,fontWeight: FontWeight.w700,),
                      // CommonText(text: cartController.orderTrackResponse?.status == 9 ?cartController.orderTrackResponse!.message.toString():"" ,textColor: AppColors.white)
                    ],
                  ),
                );
              }
            ),
          )
      ),
      body: Obx(
        () {
          return  cartController.isTrackOrderLoading.value ? Center(child: CircularProgressIndicator()) :SingleChildScrollView(
            child: Column(
              children: [

                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ListTile(
                        leading: CircleAvatar(),
                        title: CommonText(text: 'john Doe',),
                        trailing: SvgPicture.asset(
                            height: 40,
                            width: 40,
                            'packages/mynewpackage/${Assets.iconsCall}'),
                      ),
                      Divider(),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          children: [
                            SvgPicture.asset(
                                height: 20,
                                width: 20,
                                'packages/mynewpackage/${Assets.iconsLocation}'),
                            SizedBox(width: 5,),
                            CommonText(text: 'Delivered to : ',fontWeight: FontWeight.w700,),
                            CommonText(text: 'Seeroo it',textColor: AppColors.textColor,)
                          ],
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        color: AppColors.borderColor,
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: CommonText(text: 'Bill Details'),
                        ),
                      ),
                      ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: cartController.viewCartResponse?.data?.cartItmes?.length,
                        itemBuilder: (context, index) {

                          return SizedBox(
                            // height: 30,
                            child: ListTile(
                              title: CommonText(text:cartController.viewCartResponse?.data!.cartItmes?[index].name ?? "",
                              textOverflow: TextOverflow.ellipsis,),
                              trailing: CommonText(text: '₹ ${cartController.viewCartResponse?.data!.cartItmes?[index].effectiveItemPrice?.toStringAsFixed(2)}'),
                            ),
                          );
                        },
                      ),
                      SizedBox(height: 5,),
                      Divider(),
                      SizedBox(
                        height: 30,
                        child: ListTile(
                          leading: CommonText(text: 'Item Total',),
                          trailing: CommonText(text:'₹ ${cartController.viewCartResponse?.data?.cartMeta?.cartTotal}' ,),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                        child: ListTile(
                          leading: CommonText(text: 'Delivery partner fee',),
                          trailing: CommonText(text:'₹ 0' ,),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                        child: ListTile(
                          leading: CommonText(text: 'Discount Applied',),
                          trailing: CommonText(text:'₹ 0' ,),
                        ),
                      ),
                      ListTile(
                        leading: CommonText(text: 'Taxes',),
                        trailing: CommonText(text:'₹ 0' ,),
                      ),
                      Divider(),

                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            CommonText(text: 'Paid Via Cash'),
                            Spacer(),
                            CommonText(text: 'Bill Total',fontWeight: FontWeight.w700,),
                            CommonText(text: ' ₹ ${cartController.viewCartResponse?.data?.cartMeta?.cartTotal}',fontWeight: FontWeight.w700,)
                          ],
                        ),
                      ),
                      cartController.orderTrackResponse!.status! < 10?   Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CommonButton(onPressed: ()async{
                        await  cartController.orderCancelReasons();
                        Navigator.of(context).push(
                            MaterialPageRoute(
                                builder:
                                    (context) =>
                                        CancelReason(isFromOrderTrack: true.obs,)));
                        }, text: 'Cancel Order',),
                      ):SizedBox.shrink()


                    ],
                  ),
                )

              ],
            ),
          );
        }
      )
    );
  }
}
