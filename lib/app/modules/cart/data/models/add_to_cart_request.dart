import 'dart:convert';

import 'package:mynewpackage/app/modules/restaurants_details/data/get_restaurant_details_response.dart';
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
      String? providerCode, 
      Location? location,}){
    _storeId = storeId;
    _cartItems = cartItems;
    _addressId = addressId;
    _userId = userId;
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
    _providerCode = json['provider_code'];
    _location = json['location'] != null ? Location.fromJson(json['location']) : null;
  }
  num? _storeId;
  List<CartItems>? _cartItems;
  dynamic _addressId;
  String? _userId;
  String? _providerCode;
  Location? _location;
AddToCartRequest copyWith({  num? storeId,
  List<CartItems>? cartItems,
  dynamic addressId,
  String? userId,
  String? providerCode,
  Location? location,
}) => AddToCartRequest(  storeId: storeId ?? _storeId,
  cartItems: cartItems ?? _cartItems,
  addressId: addressId ?? _addressId,
  userId: userId ?? _userId,
  providerCode: providerCode ?? _providerCode,
  location: location ?? _location,
);
  num? get storeId => _storeId;
  List<CartItems>? get cartItems => _cartItems;
  dynamic get addressId => _addressId;
  String? get userId => _userId;
  String? get providerCode => _providerCode;
  Location? get location => _location;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['store_id'] = _storeId;
    if (_cartItems != null) {
      map['cartItems'] = _cartItems?.map((v) => v.toJson()).toList();
    }
    map['address_id'] = _addressId;
    map['user_id'] = _userId;
    map['provider_code'] = _providerCode;
    if (_location != null) {
      map['location'] = _location?.toJson();
    }
    return map;
  }

}

/// lat : 12.912922
/// long : 77.290929

Location locationFromJson(String str) => Location.fromJson(json.decode(str));
String locationToJson(Location data) => json.encode(data.toJson());
class Location {
  Location({
      num? lat, 
      num? long,}){
    _lat = lat;
    _long = long;
}

  Location.fromJson(dynamic json) {
    _lat = json['lat'];
    _long = json['long'];
  }
  num? _lat;
  num? _long;
Location copyWith({  num? lat,
  num? long,
}) => Location(  lat: lat ?? _lat,
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
      List<dynamic>? addons, 
      List<dynamic>? variants,}){
    _productId = productId;
    _quantity = quantity;
    _addons = addons;
    _variants = variants;
}

  CartItems.fromJson(dynamic json) {
    _productId = json['product_id'];
    _quantity = json['quantity'];
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
  List<dynamic>? _addons;
  List<dynamic>? _variants;
CartItems copyWith({  num? productId,
  num? quantity,
  List<dynamic>? addons,
  List<dynamic>? variants,
}) => CartItems(  productId: productId ?? _productId,
  quantity: quantity ?? _quantity,
  addons: addons ?? _addons,
  variants: variants ?? _variants,
);
  num? get productId => _productId;
  num? get quantity => _quantity;
  List<dynamic>? get addons => _addons;
  List<dynamic>? get variants => _variants;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['product_id'] = _productId;
    map['quantity'] = _quantity;
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
  List<dynamic>? get addonsForAddingToLIst => _addons;
  List<dynamic>? get variantsForAddingToLIst => _variants;

  void incrementQuantity() {
    _quantity = (_quantity ?? 0) + 1;
  }

  void decrementQuantity() {
    if (_quantity != null && _quantity! > 0) {
      _quantity = _quantity! - 1;
    }
  }

  factory CartItems.fromDish(Restaurant dish) {
    return CartItems(
      productId: dish.productId,
      quantity: 1,
      // addons: dish.addons,
      // variants: dish.variants,
    );
  }

}