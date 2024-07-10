import 'dart:core';

import 'package:mynewpackage/app/modules/cart/data/models/add_to_cart_response.dart';

abstract class CartService {
  Future<AddToCartResponse> addToCart(Map<String, dynamic>? params);
}
