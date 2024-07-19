import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:mynewpackage/app/modules/cart/data/models/add_to_cart_response.dart';
import 'package:mynewpackage/app/modules/cart/data/models/confirm_order_response.dart';
import 'package:mynewpackage/app/modules/cart/data/models/create_order_response.dart';
import 'package:mynewpackage/app/modules/cart/data/models/view_cart_response.dart';

import '../../../../services/api_service.dart';
import '../../cab/model/cancel_reasons_response.dart';
import 'cart_service.dart';
import 'models/cancel_order_response.dart';

class CartRepository implements CartService {
  ApiService apiService = Get.find();

  @override
  Future<AddToCartResponse> addToCart(Map<String, dynamic>? params) async {
    debugPrint("inside cart repo");
    AddToCartResponse addToCartResponse;
    Response response =
        await apiService.reqst(url: 'food/add-update-cart', params: params);
    try {
      addToCartResponse = AddToCartResponse.fromJson(response.body);
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
    Response response =
        await apiService.reqst(url: 'food/view-cart', params: params);
    try {
      viewCartResponse = ViewCartResponse.fromJson(response.body);
      return viewCartResponse;
    } catch (e, s) {
      debugPrint(s.toString());
      debugPrint(e.toString());
      return ViewCartResponse(message: "Server Error", status: 401);
    }
  }

  @override
  Future<CreateOrderResponse> createOrder(Map<String, dynamic>? params) async {
    CreateOrderResponse createOrderResponse;
    Response response =
        await apiService.reqst(url: 'food/create-order', params: params);
    try {
      createOrderResponse = CreateOrderResponse.fromJson(response.body);
      return createOrderResponse;
    } catch (e, s) {
      debugPrint(s.toString());
      debugPrint(e.toString());
      return CreateOrderResponse(message: "Server Error", status: 401);
    }
  }

  @override
  Future<ConfirmOrderResponse> confirmOrder(
      Map<String, dynamic>? params) async {
    ConfirmOrderResponse confirmOrderResponse;
    Response response =
        await apiService.reqst(url: 'food/conform-order', params: params);
    try {
      confirmOrderResponse = ConfirmOrderResponse.fromJson(response.body);
      return confirmOrderResponse;
    } catch (e, s) {
      debugPrint(s.toString());
      debugPrint(e.toString());
      return ConfirmOrderResponse(message: "Server Error", status: 401);
    }
  }

  Future<CancelReasonsResponse> orderCancelReasons() async {
    CancelReasonsResponse cancelReasonsResponse;
    Response response = await apiService.reqst(
        url: 'behrouzbiryani/v1/api/cancel/reasons/user', method: Method.GET);
    debugPrint(response.statusCode.toString());
    try {
      cancelReasonsResponse = CancelReasonsResponse.fromJson(response.body);
      return cancelReasonsResponse;
    } catch (e, s) {
      debugPrint(s.toString());
      debugPrint(e.toString());
      return CancelReasonsResponse();
    }
  }

  Future<CancelOrderResponse> cancelOrder(Map<String, dynamic>? params) async {
    CancelOrderResponse cancelResponse;
    Response response =
        await apiService.reqst(url: 'food/cancel-food-order', params: params);
    try {
      cancelResponse = CancelOrderResponse.fromJson(response.body);
      return cancelResponse;
    } catch (e, s) {
      debugPrint(s.toString());
      debugPrint(e.toString());
      return CancelOrderResponse();
    }
  }
}
