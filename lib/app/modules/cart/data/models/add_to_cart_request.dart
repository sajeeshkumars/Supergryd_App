import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:mynewpackage/app/modules/cart/data/models/view_cart_response.dart';
import 'package:mynewpackage/app/modules/restaurants_details/data/get_restaurant_details_response.dart';

import '../../../restaurants_and_dishes_listing/data/dish_listing_response.dart';
import 'add_to_cart_response.dart';
/// store_id : 1
/// cartItems : [{"product_id":11,"quantity":2,"addons":[],"variants":[]},{"product_id":15,"quantity":2,"addons":[],"variants":[]}]
/// address_id : null
/// user_id : "66826ba73ff1d692ff0ef51c"
/// provider_code : "BHZ"
/// location : {"lat":12.912922,"long":77.290929}

AddToCartRequest addToCartRequestFromJson(String str) => AddToCartRequest.fromJson(json.decode(str));
String addToCartRequestToJson(AddToCartRequest data) => json.encode(data.toJson());
class AddToCartRequest {
  AddToCartRequest({
      num? storeId, 
      List<CartItems>? cartItems, 
      dynamic addressId, 
      String? userId,
    String? deviceId,
      String? providerCode, 
      DeliveryLocation? location,}){
    _storeId = storeId;
    _cartItems = cartItems;
    _addressId = addressId;
    _userId = userId;
    _deviceId = deviceId;
    _providerCode = providerCode;
    _location = location;
}

  AddToCartRequest.fromJson(dynamic json) {
    _storeId = json['store_id'];
    if (json['cartItems'] != null) {
      _cartItems = [];
      json['cartItems'].forEach((v) {
        _cartItems?.add(CartItems.fromJson(v));
      });
    }
    _addressId = json['address_id'];
    _userId = json['user_id'];
    _deviceId = json['device_id'];
    _providerCode = json['provider_code'];
    _location = json['location'] != null ? DeliveryLocation.fromJson(json['location']) : null;
  }
  num? _storeId;
  List<CartItems>? _cartItems;
  dynamic _addressId;
  String? _userId;
  String? _deviceId;
  String? _providerCode;
  DeliveryLocation? _location;
AddToCartRequest copyWith({  num? storeId,
  List<CartItems>? cartItems,
  dynamic addressId,
  String? userId,
  String? deviceId,
  String? providerCode,
  DeliveryLocation? location,
}) => AddToCartRequest(  storeId: storeId ?? _storeId,
  cartItems: cartItems ?? _cartItems,
  addressId: addressId ?? _addressId,
  userId: userId ?? _userId,
  deviceId: deviceId ?? _deviceId,
  providerCode: providerCode ?? _providerCode,
  location: location ?? _location,
);
  num? get storeId => _storeId;
  List<CartItems>? get cartItems => _cartItems;
  dynamic get addressId => _addressId;
  String? get userId => _userId;
  String? get deviceId => _deviceId;
  String? get providerCode => _providerCode;
  DeliveryLocation? get location => _location;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['store_id'] = _storeId;
    if (_cartItems != null) {
      map['cartItems'] = _cartItems?.map((v) => v.toJson()).toList();
    }
    map['address_id'] = _addressId;
    map['user_id'] = _userId;
    map['device_id'] = _deviceId;
    map['provider_code'] = _providerCode;
    if (_location != null) {
      map['location'] = _location?.toJson();
    }
    return map;
  }

}

/// lat : 12.912922
/// long : 77.290929

DeliveryLocation locationFromJson(String str) => DeliveryLocation.fromJson(json.decode(str));
String locationToJson(DeliveryLocation data) => json.encode(data.toJson());
class DeliveryLocation {
  DeliveryLocation({
      num? lat, 
      num? long,}){
    _lat = lat;
    _long = long;
}

  DeliveryLocation.fromJson(dynamic json) {
    _lat = json['lat'];
    _long = json['long'];
  }
  num? _lat;
  num? _long;
DeliveryLocation copyWith({  num? lat,
  num? long,
}) => DeliveryLocation(  lat: lat ?? _lat,
  long: long ?? _long,
);
  num? get lat => _lat;
  num? get long => _long;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['lat'] = _lat;
    map['long'] = _long;
    return map;
  }

}

/// product_id : 11
/// quantity : 2
/// addons : []
/// variants : []

CartItems cartItemsFromJson(String str) => CartItems.fromJson(json.decode(str));
String cartItemsToJson(CartItems data) => json.encode(data.toJson());
class CartItems {
  CartItems({
      num? productId, 
      num? quantity,
    int? storeId,
      List<dynamic>? addons, 
      List<dynamic>? variants,}){
    _productId = productId;
    _quantity = quantity;
    _addons = addons;
    _variants = variants;
    _storeId = storeId;
}

  CartItems.fromJson(dynamic json) {
    _productId = json['product_id'];
    _quantity = json['quantity'];
    _storeId = json['store_id'];
    // if (json['addons'] != null) {
    //   _addons = [];
    //   json['addons'].forEach((v) {
    //     _addons?.add(Dynamic.fromJson(v));
    //   });
    // }
    // if (json['variants'] != null) {
    //   _variants = [];
    //   json['variants'].forEach((v) {
    //     _variants?.add(Dynamic.fromJson(v));
    //   });
    // }
  }
  num? _productId;
  num? _quantity;
  int? _storeId;
  List<dynamic>? _addons;
  List<dynamic>? _variants;
CartItems copyWith({  num? productId,
  num? quantity,
  int? storeId,
  List<dynamic>? addons,
  List<dynamic>? variants,
}) => CartItems(  productId: productId ?? _productId,
  quantity: quantity ?? _quantity,
  storeId: storeId ?? _storeId,
  addons: addons ?? _addons,
  variants: variants ?? _variants,
);
  num? get productId => _productId;
  num? get quantity => _quantity;
  int? get storeId => _storeId;
  List<dynamic>? get addons => _addons;
  List<dynamic>? get variants => _variants;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['product_id'] = _productId;
    map['quantity'] = _quantity;
    map['store_id'] = _storeId;
    if (_addons != null) {
      map['addons'] = _addons?.map((v) => v.toJson()).toList();
    }
    if (_variants != null) {
      map['variants'] = _variants?.map((v) => v.toJson()).toList();
    }
    return map;
  }

  num? get productIdForAddingToLIst => _productId;
  num? get quantityForAddingToLIst => _quantity;
  int? get storeIdForAddingToList => _storeId;
  List<dynamic>? get addonsForAddingToLIst => _addons;
  List<dynamic>? get variantsForAddingToLIst => _variants;

  void incrementQuantity() {
    _quantity = (_quantity ?? 0) + 1;
    debugPrint("quantity in increment ${quantity}");

  }

  void decrementQuantity() {
    if (_quantity != null && _quantity! > 0) {
      _quantity = _quantity! - 1;
    }
    debugPrint("quantity in decreeeeement ${quantity}");

  }

  factory CartItems.fromDish(Restaurant dish) {
    return CartItems(
      productId: dish.productId,
      quantity: 1,
      storeId: dish.storeId
      // addons: dish.addons,
      // variants: dish.variants,
    );
  }

  factory CartItems.fromDishList(Dishes dish) {
    return CartItems(
      productId: dish.storeProducts?.productId,
      quantity: 1,
        storeId: dish.storeId

      // addons: dish.addons,
      // variants: dish.variants,
    );
  }

  factory CartItems.fromCart(ViewCartItems dish) {
    return CartItems(
        productId: dish.productId,
        quantity: 1,

      // addons: dish.addons,
      // variants: dish.variants,
    );
  }

}