import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:mynewpackage/app/modules/cart/data/models/add_to_cart_response.dart';
import 'package:mynewpackage/app/modules/cart/data/models/view_cart_response.dart';
import 'package:mynewpackage/app/modules/restaurants_and_dishes_listing/data/restaurant_and_dish_listing_service.dart';
import 'package:mynewpackage/app/modules/restaurants_and_dishes_listing/data/restaurant_listing_response.dart';

import '../../../../services/api_service.dart';
import 'cart_service.dart';

class CartRepository implements CartService {
  ApiService apiService = Get.find();

  @override
  Future<AddToCartResponse> addToCart(Map<String, dynamic>? params) async {
    debugPrint("inside cart repo");
    AddToCartResponse addToCartResponse;
    Response response = await apiService.reqst(
        url: 'food/add-update-cart', params: params);
    try {
      addToCartResponse =
          AddToCartResponse.fromJson(response.body);
      return addToCartResponse;
    } catch (e, s) {
      debugPrint(s.toString());
      debugPrint(e.toString());
      return AddToCartResponse(message: "Server Error", status: 401);
    }
  }


  @override
  Future<ViewCartResponse> viewCart(Map<String, dynamic>? params) async {
    ViewCartResponse viewCartResponse;
    Response response = await apiService.reqst(
        url: 'food/view-cart', params: params);
    try {
      viewCartResponse =
          ViewCartResponse.fromJson(response.body);
      return viewCartResponse;
    } catch (e, s) {
      debugPrint(s.toString());
      debugPrint(e.toString());
      return ViewCartResponse(message: "Server Error", status: 401);
    }
  }


}
