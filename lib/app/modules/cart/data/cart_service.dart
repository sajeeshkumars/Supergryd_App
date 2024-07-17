import 'dart:core';

import 'package:mynewpackage/app/modules/cart/data/models/add_to_cart_response.dart';
import 'package:mynewpackage/app/modules/cart/data/models/create_order_response.dart';
import 'package:mynewpackage/app/modules/cart/data/models/view_cart_response.dart';

import '../../cab/model/cancel_reasons_response.dart';
import '../../cab/model/cancel_response.dart';
import 'models/cancel_order_response.dart';
import 'models/confirm_order_response.dart';

abstract class CartService {
  Future<AddToCartResponse> addToCart(Map<String, dynamic>? params);
  Future<ViewCartResponse> viewCart(Map<String, dynamic>? params);
  Future<CreateOrderResponse> createOrder(Map<String, dynamic>? params);
  Future<ConfirmOrderResponse> confirmOrder(Map<String, dynamic>? params);
  Future<CancelReasonsResponse> orderCancelReasons();
  Future<CancelOrderResponse> cancelOrder(Map<String, dynamic>? params);


}
