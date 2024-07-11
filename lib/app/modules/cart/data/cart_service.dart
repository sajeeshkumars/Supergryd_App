import 'dart:core';

import 'package:mynewpackage/app/modules/cart/data/models/add_to_cart_response.dart';
import 'package:mynewpackage/app/modules/cart/data/models/view_cart_response.dart';

abstract class CartService {
  Future<AddToCartResponse> addToCart(Map<String, dynamic>? params);
  Future<ViewCartResponse> viewCart(Map<String, dynamic>? params);
}
