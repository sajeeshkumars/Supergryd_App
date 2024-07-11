import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:mynewpackage/app/modules/cart/data/cart_repo.dart';
import 'package:mynewpackage/app/modules/cart/data/models/add_to_cart_request.dart';
import 'package:mynewpackage/app/modules/cart/data/models/add_to_cart_response.dart';
import 'package:mynewpackage/app/modules/home/controllers/home_controller.dart';

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
  Future<void> addToCart(
      {BuildContext? context,required int storeId}) async {
    debugPrint("inside addToCart");

    isAddToCartLoading(true);


    AddToCartRequest request = AddToCartRequest(
        storeId: storeId,
        cartItems: cartItems,
        addressId: null,
        providerCode: "BHZ",
        location: Location(lat:homeController.selectedLocationCoordinates['lat'] ,long: homeController.selectedLocationCoordinates['long'])
    );
    debugPrint("inside addToCart2");
    await cartRepository.addToCart(request.toJson())
        .then((value) {

      if (value.status == 200) {
        isAddToCartLoading(false);
        ScaffoldMessenger.of(context!).showSnackBar(SnackBar(content: Text(value.message.toString())));
        Navigator.of(context).push(
            MaterialPageRoute(
                builder: (context) =>
                    CartView()));


      } else {
        isAddToCartLoading(false);
        ScaffoldMessenger.of(context!).showSnackBar(SnackBar(content: Text(value.message.toString())));


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

  int get totalItems => cartItems.length;
  double get totalPrice => cartItems.fold(0, (sum, item) => sum + (item.quantity! * getPrice(item.productId!)));

  double getPrice(num productId) {
    // Replace with actual price fetching logic
    return 10.0; // Example price
  }
}





