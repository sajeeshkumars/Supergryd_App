import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:mynewpackage/app/modules/cart/data/cart_repo.dart';
import 'package:mynewpackage/app/modules/cart/data/models/add_to_cart_request.dart';
import 'package:mynewpackage/app/modules/cart/data/models/add_to_cart_response.dart';
import 'package:mynewpackage/app/modules/cart/data/models/view_cart_response.dart';
import 'package:mynewpackage/app/modules/home/controllers/home_controller.dart';
import 'package:mynewpackage/app/modules/restaurants_and_dishes_listing/data/dish_listing_response.dart';
import 'package:mynewpackage/constants.dart';
import 'package:mynewpackage/widgets/common_text.dart';

import '../../restaurants_details/data/get_restaurant_details_response.dart';
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



  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
  void increment() => count.value++;

  void addProductToCart(Restaurant dish) {
    final existingItem = cartItems.firstWhereOrNull((item) => item.productId == dish.productId);
    if (existingItem != null) {
      existingItem.incrementQuantity();
    } else {
      cartItems.add(CartItems.fromDish(dish));
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
    // if (dishesList.isEmpty) return true; // If the list is empty, return true

    // Get the storeId of the first dish
    int firstStoreId = dishesList.first.storeId ?? -1;

    // Check if all dishes have the same storeId
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
        location: Location(lat:homeController.selectedLocationCoordinates['lat'] ,long: homeController.selectedLocationCoordinates['long'])
    );
    debugPrint("inside addToCart2");
    await cartRepository.addToCart(request.toJson())
        .then((value) {

      if (value.status == 200) {
        isAddToCartLoading(false);
        addToCartResponse = value;
       if(value.data?.statusCode == 0) {
          ScaffoldMessenger.of(context!).showSnackBar(
              SnackBar(content: Text(value.data!.statusMessage.toString())));
        } // viewCart(context: context);
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

  // int get totalItems => cartItems.length;
  // double get totalPrice => cartItems.fold(0, (sum, item) => sum + (item.quantity! * getPrice(item.productId!)));
  //
  // double getPrice(num productId) {
  //   // Replace with actual price fetching logic
  //   return 10.0; // Example price
  // }


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




}





