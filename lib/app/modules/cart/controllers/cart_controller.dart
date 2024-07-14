import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:mynewpackage/app/modules/cart/data/cart_repo.dart';
import 'package:mynewpackage/app/modules/cart/data/models/add_to_cart_request.dart';
import 'package:mynewpackage/app/modules/cart/data/models/add_to_cart_response.dart';
import 'package:mynewpackage/app/modules/cart/data/models/create_order_request.dart';
import 'package:mynewpackage/app/modules/cart/data/models/create_order_response.dart';
import 'package:mynewpackage/app/modules/home/controllers/home_controller.dart';
import 'package:mynewpackage/app/modules/restaurants_and_dishes_listing/data/dish_listing_response.dart';
import 'package:mynewpackage/constants.dart';
import 'package:mynewpackage/widgets/common_text.dart';

import '../../../../widgets/custom_button.dart';
import '../../restaurants_details/data/get_restaurant_details_response.dart';
import '../data/models/view_cart_response.dart';
import '../views/cart_view.dart';

class CartController extends GetxController {
  //TODO: Implement CartController

  AddToCartResponse? addToCartResponse;
  AddToCartRequest? addToCartRequest = AddToCartRequest() ;
  CartRepository cartRepository = CartRepository();
  RxBool isAddToCartLoading = false.obs;
  var cartItems = <CartItems>[].obs;
  HomeController homeController = Get.find();
  RxBool isViewCartLoading = false.obs;
  ViewCartResponse? viewCartResponse;
  RxBool isCreateOrderLoading = false.obs;
  RxBool isConfirmOrderLoading = false.obs;
  CreateOrderResponse? createOrderResponse;



  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }



  UserData userData = UserData(
    name: Constants.name,
    contactNumber: 3123424
  );

  @override
  void onClose() {}


  void addProductToCart(Restaurant dish) {
    final existingItem = cartItems.firstWhereOrNull((item) => item.productId == dish.productId);
    if (existingItem != null) {
      existingItem.incrementQuantity();
    } else {
      cartItems.add(CartItems.fromDish(dish));
    }
  }

  void addProductToCartFromCart(ViewCartItems dish) {
    final existingItem = cartItems.firstWhereOrNull((item) => item.productId == dish.productId);
    if (existingItem != null) {
      existingItem.incrementQuantity();
    } else {
      cartItems.add(CartItems.fromCart(dish));
    }
  }



  void addProductToCartFromListing(Dishes dish) {
    final existingItem = cartItems.firstWhereOrNull((item) => item.productId == dish.storeProducts?.productId);
    if (existingItem != null) {
      existingItem.incrementQuantity();
    } else {
      cartItems.add(CartItems.fromDishList(dish));
    }
  }

   areAllDishesFromSameShop( List<Dishes> dishesList) {

    int firstStoreId = dishesList.first.storeId ?? -1;

    if( dishesList.every((dish) => dish.storeId == firstStoreId)){
      AlertDialog(title: CommonText(text: 'test',),);
    }
  }


  /// Add/update cart api call
  Future<void> addToCart(
      {BuildContext? context,required int storeId}) async {
    debugPrint("inside addToCart");

    isAddToCartLoading(true);


    AddToCartRequest request = AddToCartRequest(
        storeId: storeId,
        cartItems: cartItems,
        addressId: null,
        providerCode: "BHZ",
        userId: Constants.userId,
        deviceId: addToCartResponse?.data?.deviceId ?? null,
        location: DeliveryLocation(lat:homeController.selectedLocationCoordinates['lat'] ,long: homeController.selectedLocationCoordinates['long'])
    );
    debugPrint("inside addToCart2");
    await cartRepository.addToCart(request.toJson())
        .then((value) {

      if (value.status == 200) {
        isAddToCartLoading(false);
        addToCartResponse = value;
          ScaffoldMessenger.of(context!).showSnackBar(
              SnackBar(content: Text(value.data!.statusMessage.toString())));
          viewCart(context: context);
         // viewCart(context: context);
        // Navigator.of(context).push(
        //     MaterialPageRoute(
        //         builder: (context) =>
        //             CartView()));


      } else {
        isAddToCartLoading(false);
        ScaffoldMessenger.of(context!).showSnackBar(SnackBar(content: Text(value.data!.statusMessage.toString())));


      }
    });
  }

  void removeFromCart(CartItems item) {
    if (item.quantity! > 1) {
      item.decrementQuantity();
    } else {
      cartItems.remove(item);
    }
  }



  Future<void> viewCart(
      {required BuildContext context}) async {

    isViewCartLoading(true);

      await cartRepository.viewCart({
      "device_id":addToCartResponse?.data?.deviceId,
      "store_id":addToCartResponse?.data?.storeId
    })
        .then((value) {

      if (value.status == 200) {
        isViewCartLoading(false);
        viewCartResponse = value;




      } else {
        isViewCartLoading(false);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(value.message.toString())));


      }
      return null;
    });
  }


  Future<void> createOrder({required BuildContext context}) async {


    isCreateOrderLoading(true);


    CreateOrderRequest request = CreateOrderRequest(
      storeId: viewCartResponse?.data?.storeId,
      cartId: viewCartResponse?.data?.cartMeta?.cartId,
      deviceId: viewCartResponse?.data?.deviceId,
      addressData: [AddressData(
          lat: homeController.selectedLocationCoordinates['lat'],
          lng:homeController.selectedLocationCoordinates['long'],
          address: homeController.address.value,
          doorFlatNo: "369/3",
          landmark: ""
      )],
      userData:[
        UserData(
          // name: Constants.name,
          name: 'Najib',
          contactNumber: 1234567890
        )

      ],
      // userId: Constants.userId,
      userId: "66826ba73ff1d692ff0ef51c",
      providerCode: null,
      location:Location(
        lat: homeController.selectedLocationCoordinates['lat'],
        lng:homeController.selectedLocationCoordinates['long'],
      ),
      foodRemark: 'test'

    );
    await cartRepository.createOrder(request.toJson())
        .then((value) {

      if (value.status == 200) {
        isCreateOrderLoading(false);
        createOrderResponse = value;

        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: CommonText(text: value.data!.statusMessage.toString())));
        if(value.data?.statusCode == 1){

          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: CommonText(
                    text: 'Confirm Order of ₹ ${viewCartResponse?.data?.cartMeta?.cartTotal}'),
                actions: [
                  Row(
                    children: [
                      Expanded(
                        child: CommonButton(
                          onPressed: () {
                            Navigator.pop(context);
                            // Close the dialog
                          },
                          text: 'No',
                        ),
                      ),
                      SizedBox(width: 5,),
                      Expanded(
                        child: Obx(
                          () {
                            return CommonButton(
                              isLoading: isConfirmOrderLoading.value,
                              onPressed: () {
                                confirmOrder(context: context, onSuccess: (){
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: CommonText(text: 'Order Placed Successfully'),
                                        actions: [
                                          CommonButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                              Navigator.pop(context);
                                              Navigator.pop(context);
                                              Navigator.pop(context);
                                              Navigator.pop(context);
                                              // Close the dialog
                                            },
                                            text: 'Back to Services',
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                });

                                // Navigator.pop(context);

                              },
                              text: 'Confirm',
                            );
                          }
                        ),
                      ),
                    ],
                  ),
                ],
              );
            },
          );

        }



      } else {
        isCreateOrderLoading(false);


      }
    });
  }


  Future<void> confirmOrder({required BuildContext context,required Function onSuccess}) async {


    isConfirmOrderLoading(true);


    await cartRepository.confirmOrder({
      "order_id":createOrderResponse?.data?.orderReferance?.first.orderId,
      "device_id":viewCartResponse?.data?.deviceId,
      "payment_method":"CASH"
    })
        .then((value) {

      if (value.status == 200) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: CommonText(text: value.data!.statusMessage.toString())));

        isConfirmOrderLoading(false);
        cartItems.clear();
        if(value.data?.statusCode == 1){
          {
            onSuccess();

          }
        }



      } else {
        isCreateOrderLoading(false);


      }
    });
  }





}





