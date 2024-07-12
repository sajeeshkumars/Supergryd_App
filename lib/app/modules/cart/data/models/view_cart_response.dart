import 'dart:convert';
/// status : 200
/// message : "Success."
/// data : {"statusCode":1,"statusMessage":"DATA_FETCHED_SUCCESSFULLY","device_id":"1ed9144468af9f78db936fa506058f47","store_id":2,"cartItmes":[{"productId":71,"in_stock":1,"is_error":false,"allowed_quantity":6,"quantity":2,"name":"Veggie Supreme","is_veg":1,"product_imageUrl":"https://supergrydapi.ritikasingh.site/uploads/dish/veggie-supreme.jpg","final_price":199.98,"effective_item_price":247.98,"packing_charge":38,"item_taxes":{"service_tax":0,"vat":0,"service_charges":0,"GST":10},"subtotal":199.98,"total":237.98,"added_by_user_id":-1,"added_by_user_name":"","addons":[],"addons_price":null,"subtotal_coupon_discount":0}],"cartMeta":{"GST_details":{"cart_CGST":5.95,"cart_SGST":5.95,"cart_IGST":0,"external_GST":0,"item_CGST":5,"item_SGST":5,"item_IGST":0,"packaging_CGST":0.95,"packaging_SGST":0.95,"packaging_IGST":0,"service_charge_CGST":0,"service_charge_IGST":0,"service_charge_SGST":0},"cart_subtotal":237.98,"cart_subtotal_without_packing":199.98,"cart_total":249.88,"cart_total_count":2,"delivery_charges":50,"cartId":6959911870}}

ViewCartResponse viewCartResponseFromJson(String str) => ViewCartResponse.fromJson(json.decode(str));
String viewCartResponseToJson(ViewCartResponse data) => json.encode(data.toJson());
class ViewCartResponse {
  ViewCartResponse({
      num? status, 
      String? message, 
      Data? data,}){
    _status = status;
    _message = message;
    _data = data;
}

  ViewCartResponse.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  num? _status;
  String? _message;
  Data? _data;
ViewCartResponse copyWith({  num? status,
  String? message,
  Data? data,
}) => ViewCartResponse(  status: status ?? _status,
  message: message ?? _message,
  data: data ?? _data,
);
  num? get status => _status;
  String? get message => _message;
  Data? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    if (_data != null) {
      map['data'] = _data?.toJson();
    }
    return map;
  }

}

/// statusCode : 1
/// statusMessage : "DATA_FETCHED_SUCCESSFULLY"
/// device_id : "1ed9144468af9f78db936fa506058f47"
/// store_id : 2
/// cartItmes : [{"productId":71,"in_stock":1,"is_error":false,"allowed_quantity":6,"quantity":2,"name":"Veggie Supreme","is_veg":1,"product_imageUrl":"https://supergrydapi.ritikasingh.site/uploads/dish/veggie-supreme.jpg","final_price":199.98,"effective_item_price":247.98,"packing_charge":38,"item_taxes":{"service_tax":0,"vat":0,"service_charges":0,"GST":10},"subtotal":199.98,"total":237.98,"added_by_user_id":-1,"added_by_user_name":"","addons":[],"addons_price":null,"subtotal_coupon_discount":0}]
/// cartMeta : {"GST_details":{"cart_CGST":5.95,"cart_SGST":5.95,"cart_IGST":0,"external_GST":0,"item_CGST":5,"item_SGST":5,"item_IGST":0,"packaging_CGST":0.95,"packaging_SGST":0.95,"packaging_IGST":0,"service_charge_CGST":0,"service_charge_IGST":0,"service_charge_SGST":0},"cart_subtotal":237.98,"cart_subtotal_without_packing":199.98,"cart_total":249.88,"cart_total_count":2,"delivery_charges":50,"cartId":6959911870}

Data dataFromJson(String str) => Data.fromJson(json.decode(str));
String dataToJson(Data data) => json.encode(data.toJson());
class Data {
  Data({
      num? statusCode, 
      String? statusMessage, 
      String? deviceId, 
      num? storeId, 
      List<CartItmes>? cartItmes, 
      CartMeta? cartMeta,}){
    _statusCode = statusCode;
    _statusMessage = statusMessage;
    _deviceId = deviceId;
    _storeId = storeId;
    _cartItmes = cartItmes;
    _cartMeta = cartMeta;
}

  Data.fromJson(dynamic json) {
    _statusCode = json['statusCode'];
    _statusMessage = json['statusMessage'];
    _deviceId = json['device_id'];
    _storeId = json['store_id'];
    if (json['cartItmes'] != null) {
      _cartItmes = [];
      json['cartItmes'].forEach((v) {
        _cartItmes?.add(CartItmes.fromJson(v));
      });
    }
    _cartMeta = json['cartMeta'] != null ? CartMeta.fromJson(json['cartMeta']) : null;
  }
  num? _statusCode;
  String? _statusMessage;
  String? _deviceId;
  num? _storeId;
  List<CartItmes>? _cartItmes;
  CartMeta? _cartMeta;
Data copyWith({  num? statusCode,
  String? statusMessage,
  String? deviceId,
  num? storeId,
  List<CartItmes>? cartItmes,
  CartMeta? cartMeta,
}) => Data(  statusCode: statusCode ?? _statusCode,
  statusMessage: statusMessage ?? _statusMessage,
  deviceId: deviceId ?? _deviceId,
  storeId: storeId ?? _storeId,
  cartItmes: cartItmes ?? _cartItmes,
  cartMeta: cartMeta ?? _cartMeta,
);
  num? get statusCode => _statusCode;
  String? get statusMessage => _statusMessage;
  String? get deviceId => _deviceId;
  num? get storeId => _storeId;
  List<CartItmes>? get cartItmes => _cartItmes;
  CartMeta? get cartMeta => _cartMeta;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['statusCode'] = _statusCode;
    map['statusMessage'] = _statusMessage;
    map['device_id'] = _deviceId;
    map['store_id'] = _storeId;
    if (_cartItmes != null) {
      map['cartItmes'] = _cartItmes?.map((v) => v.toJson()).toList();
    }
    if (_cartMeta != null) {
      map['cartMeta'] = _cartMeta?.toJson();
    }
    return map;
  }

}

/// GST_details : {"cart_CGST":5.95,"cart_SGST":5.95,"cart_IGST":0,"external_GST":0,"item_CGST":5,"item_SGST":5,"item_IGST":0,"packaging_CGST":0.95,"packaging_SGST":0.95,"packaging_IGST":0,"service_charge_CGST":0,"service_charge_IGST":0,"service_charge_SGST":0}
/// cart_subtotal : 237.98
/// cart_subtotal_without_packing : 199.98
/// cart_total : 249.88
/// cart_total_count : 2
/// delivery_charges : 50
/// cartId : 6959911870

CartMeta cartMetaFromJson(String str) => CartMeta.fromJson(json.decode(str));
String cartMetaToJson(CartMeta data) => json.encode(data.toJson());
class CartMeta {
  CartMeta({
      GstDetails? gSTDetails, 
      num? cartSubtotal, 
      num? cartSubtotalWithoutPacking, 
      num? cartTotal, 
      num? cartTotalCount, 
      num? deliveryCharges, 
      num? cartId,}){
    _gSTDetails = gSTDetails;
    _cartSubtotal = cartSubtotal;
    _cartSubtotalWithoutPacking = cartSubtotalWithoutPacking;
    _cartTotal = cartTotal;
    _cartTotalCount = cartTotalCount;
    _deliveryCharges = deliveryCharges;
    _cartId = cartId;
}

  CartMeta.fromJson(dynamic json) {
    _gSTDetails = json['GST_details'] != null ? GstDetails.fromJson(json['GST_details']) : null;
    _cartSubtotal = json['cart_subtotal'];
    _cartSubtotalWithoutPacking = json['cart_subtotal_without_packing'];
    _cartTotal = json['cart_total'];
    _cartTotalCount = json['cart_total_count'];
    _deliveryCharges = json['delivery_charges'];
    _cartId = json['cartId'];
  }
  GstDetails? _gSTDetails;
  num? _cartSubtotal;
  num? _cartSubtotalWithoutPacking;
  num? _cartTotal;
  num? _cartTotalCount;
  num? _deliveryCharges;
  num? _cartId;
CartMeta copyWith({  GstDetails? gSTDetails,
  num? cartSubtotal,
  num? cartSubtotalWithoutPacking,
  num? cartTotal,
  num? cartTotalCount,
  num? deliveryCharges,
  num? cartId,
}) => CartMeta(  gSTDetails: gSTDetails ?? _gSTDetails,
  cartSubtotal: cartSubtotal ?? _cartSubtotal,
  cartSubtotalWithoutPacking: cartSubtotalWithoutPacking ?? _cartSubtotalWithoutPacking,
  cartTotal: cartTotal ?? _cartTotal,
  cartTotalCount: cartTotalCount ?? _cartTotalCount,
  deliveryCharges: deliveryCharges ?? _deliveryCharges,
  cartId: cartId ?? _cartId,
);
  GstDetails? get gSTDetails => _gSTDetails;
  num? get cartSubtotal => _cartSubtotal;
  num? get cartSubtotalWithoutPacking => _cartSubtotalWithoutPacking;
  num? get cartTotal => _cartTotal;
  num? get cartTotalCount => _cartTotalCount;
  num? get deliveryCharges => _deliveryCharges;
  num? get cartId => _cartId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_gSTDetails != null) {
      map['GST_details'] = _gSTDetails?.toJson();
    }
    map['cart_subtotal'] = _cartSubtotal;
    map['cart_subtotal_without_packing'] = _cartSubtotalWithoutPacking;
    map['cart_total'] = _cartTotal;
    map['cart_total_count'] = _cartTotalCount;
    map['delivery_charges'] = _deliveryCharges;
    map['cartId'] = _cartId;
    return map;
  }

}

/// cart_CGST : 5.95
/// cart_SGST : 5.95
/// cart_IGST : 0
/// external_GST : 0
/// item_CGST : 5
/// item_SGST : 5
/// item_IGST : 0
/// packaging_CGST : 0.95
/// packaging_SGST : 0.95
/// packaging_IGST : 0
/// service_charge_CGST : 0
/// service_charge_IGST : 0
/// service_charge_SGST : 0

GstDetails gstDetailsFromJson(String str) => GstDetails.fromJson(json.decode(str));
String gstDetailsToJson(GstDetails data) => json.encode(data.toJson());
class GstDetails {
  GstDetails({
      num? cartCGST, 
      num? cartSGST, 
      num? cartIGST, 
      num? externalGST, 
      num? itemCGST, 
      num? itemSGST, 
      num? itemIGST, 
      num? packagingCGST, 
      num? packagingSGST, 
      num? packagingIGST, 
      num? serviceChargeCGST, 
      num? serviceChargeIGST, 
      num? serviceChargeSGST,}){
    _cartCGST = cartCGST;
    _cartSGST = cartSGST;
    _cartIGST = cartIGST;
    _externalGST = externalGST;
    _itemCGST = itemCGST;
    _itemSGST = itemSGST;
    _itemIGST = itemIGST;
    _packagingCGST = packagingCGST;
    _packagingSGST = packagingSGST;
    _packagingIGST = packagingIGST;
    _serviceChargeCGST = serviceChargeCGST;
    _serviceChargeIGST = serviceChargeIGST;
    _serviceChargeSGST = serviceChargeSGST;
}

  GstDetails.fromJson(dynamic json) {
    _cartCGST = json['cart_CGST'];
    _cartSGST = json['cart_SGST'];
    _cartIGST = json['cart_IGST'];
    _externalGST = json['external_GST'];
    _itemCGST = json['item_CGST'];
    _itemSGST = json['item_SGST'];
    _itemIGST = json['item_IGST'];
    _packagingCGST = json['packaging_CGST'];
    _packagingSGST = json['packaging_SGST'];
    _packagingIGST = json['packaging_IGST'];
    _serviceChargeCGST = json['service_charge_CGST'];
    _serviceChargeIGST = json['service_charge_IGST'];
    _serviceChargeSGST = json['service_charge_SGST'];
  }
  num? _cartCGST;
  num? _cartSGST;
  num? _cartIGST;
  num? _externalGST;
  num? _itemCGST;
  num? _itemSGST;
  num? _itemIGST;
  num? _packagingCGST;
  num? _packagingSGST;
  num? _packagingIGST;
  num? _serviceChargeCGST;
  num? _serviceChargeIGST;
  num? _serviceChargeSGST;
GstDetails copyWith({  num? cartCGST,
  num? cartSGST,
  num? cartIGST,
  num? externalGST,
  num? itemCGST,
  num? itemSGST,
  num? itemIGST,
  num? packagingCGST,
  num? packagingSGST,
  num? packagingIGST,
  num? serviceChargeCGST,
  num? serviceChargeIGST,
  num? serviceChargeSGST,
}) => GstDetails(  cartCGST: cartCGST ?? _cartCGST,
  cartSGST: cartSGST ?? _cartSGST,
  cartIGST: cartIGST ?? _cartIGST,
  externalGST: externalGST ?? _externalGST,
  itemCGST: itemCGST ?? _itemCGST,
  itemSGST: itemSGST ?? _itemSGST,
  itemIGST: itemIGST ?? _itemIGST,
  packagingCGST: packagingCGST ?? _packagingCGST,
  packagingSGST: packagingSGST ?? _packagingSGST,
  packagingIGST: packagingIGST ?? _packagingIGST,
  serviceChargeCGST: serviceChargeCGST ?? _serviceChargeCGST,
  serviceChargeIGST: serviceChargeIGST ?? _serviceChargeIGST,
  serviceChargeSGST: serviceChargeSGST ?? _serviceChargeSGST,
);
  num? get cartCGST => _cartCGST;
  num? get cartSGST => _cartSGST;
  num? get cartIGST => _cartIGST;
  num? get externalGST => _externalGST;
  num? get itemCGST => _itemCGST;
  num? get itemSGST => _itemSGST;
  num? get itemIGST => _itemIGST;
  num? get packagingCGST => _packagingCGST;
  num? get packagingSGST => _packagingSGST;
  num? get packagingIGST => _packagingIGST;
  num? get serviceChargeCGST => _serviceChargeCGST;
  num? get serviceChargeIGST => _serviceChargeIGST;
  num? get serviceChargeSGST => _serviceChargeSGST;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['cart_CGST'] = _cartCGST;
    map['cart_SGST'] = _cartSGST;
    map['cart_IGST'] = _cartIGST;
    map['external_GST'] = _externalGST;
    map['item_CGST'] = _itemCGST;
    map['item_SGST'] = _itemSGST;
    map['item_IGST'] = _itemIGST;
    map['packaging_CGST'] = _packagingCGST;
    map['packaging_SGST'] = _packagingSGST;
    map['packaging_IGST'] = _packagingIGST;
    map['service_charge_CGST'] = _serviceChargeCGST;
    map['service_charge_IGST'] = _serviceChargeIGST;
    map['service_charge_SGST'] = _serviceChargeSGST;
    return map;
  }

}

/// productId : 71
/// in_stock : 1
/// is_error : false
/// allowed_quantity : 6
/// quantity : 2
/// name : "Veggie Supreme"
/// is_veg : 1
/// product_imageUrl : "https://supergrydapi.ritikasingh.site/uploads/dish/veggie-supreme.jpg"
/// final_price : 199.98
/// effective_item_price : 247.98
/// packing_charge : 38
/// item_taxes : {"service_tax":0,"vat":0,"service_charges":0,"GST":10}
/// subtotal : 199.98
/// total : 237.98
/// added_by_user_id : -1
/// added_by_user_name : ""
/// addons : []
/// addons_price : null
/// subtotal_coupon_discount : 0

CartItmes cartItmesFromJson(String str) => CartItmes.fromJson(json.decode(str));
String cartItmesToJson(CartItmes data) => json.encode(data.toJson());
class CartItmes {
  CartItmes({
      num? productId, 
      num? inStock, 
      bool? isError, 
      num? allowedQuantity, 
      num? quantity, 
      String? name, 
      num? isVeg, 
      String? productImageUrl, 
      num? finalPrice, 
      num? effectiveItemPrice, 
      num? packingCharge, 
      ItemTaxes? itemTaxes, 
      num? subtotal, 
      num? total, 
      num? addedByUserId, 
      String? addedByUserName, 
      List<dynamic>? addons, 
      dynamic addonsPrice, 
      num? subtotalCouponDiscount,}){
    _productId = productId;
    _inStock = inStock;
    _isError = isError;
    _allowedQuantity = allowedQuantity;
    _quantity = quantity;
    _name = name;
    _isVeg = isVeg;
    _productImageUrl = productImageUrl;
    _finalPrice = finalPrice;
    _effectiveItemPrice = effectiveItemPrice;
    _packingCharge = packingCharge;
    _itemTaxes = itemTaxes;
    _subtotal = subtotal;
    _total = total;
    _addedByUserId = addedByUserId;
    _addedByUserName = addedByUserName;
    _addons = addons;
    _addonsPrice = addonsPrice;
    _subtotalCouponDiscount = subtotalCouponDiscount;
}



  CartItmes.fromJson(dynamic json) {
    _productId = json['productId'];
    _inStock = json['in_stock'];
    _isError = json['is_error'];
    _allowedQuantity = json['allowed_quantity'];
    _quantity = json['quantity'];
    _name = json['name'];
    _isVeg = json['is_veg'];
    _productImageUrl = json['product_imageUrl'];
    _finalPrice = json['final_price'];
    _effectiveItemPrice = json['effective_item_price'];
    _packingCharge = json['packing_charge'];
    _itemTaxes = json['item_taxes'] != null ? ItemTaxes.fromJson(json['item_taxes']) : null;
    _subtotal = json['subtotal'];
    _total = json['total'];
    _addedByUserId = json['added_by_user_id'];
    _addedByUserName = json['added_by_user_name'];
    // if (json['addons'] != null) {
    //   _addons = [];
    //   json['addons'].forEach((v) {
    //     _addons?.add(Dynamic.fromJson(v));
    //   });
    // }
    _addonsPrice = json['addons_price'];
    _subtotalCouponDiscount = json['subtotal_coupon_discount'];
  }
  num? _productId;
  num? _inStock;
  bool? _isError;
  num? _allowedQuantity;
  num? _quantity;
  String? _name;
  num? _isVeg;
  String? _productImageUrl;
  num? _finalPrice;
  num? _effectiveItemPrice;
  num? _packingCharge;
  ItemTaxes? _itemTaxes;
  num? _subtotal;
  num? _total;
  num? _addedByUserId;
  String? _addedByUserName;
  List<dynamic>? _addons;
  dynamic _addonsPrice;
  num? _subtotalCouponDiscount;
CartItmes copyWith({  num? productId,
  num? inStock,
  bool? isError,
  num? allowedQuantity,
  num? quantity,
  String? name,
  num? isVeg,
  String? productImageUrl,
  num? finalPrice,
  num? effectiveItemPrice,
  num? packingCharge,
  ItemTaxes? itemTaxes,
  num? subtotal,
  num? total,
  num? addedByUserId,
  String? addedByUserName,
  List<dynamic>? addons,
  dynamic addonsPrice,
  num? subtotalCouponDiscount,
}) => CartItmes(  productId: productId ?? _productId,
  inStock: inStock ?? _inStock,
  isError: isError ?? _isError,
  allowedQuantity: allowedQuantity ?? _allowedQuantity,
  quantity: quantity ?? _quantity,
  name: name ?? _name,
  isVeg: isVeg ?? _isVeg,
  productImageUrl: productImageUrl ?? _productImageUrl,
  finalPrice: finalPrice ?? _finalPrice,
  effectiveItemPrice: effectiveItemPrice ?? _effectiveItemPrice,
  packingCharge: packingCharge ?? _packingCharge,
  itemTaxes: itemTaxes ?? _itemTaxes,
  subtotal: subtotal ?? _subtotal,
  total: total ?? _total,
  addedByUserId: addedByUserId ?? _addedByUserId,
  addedByUserName: addedByUserName ?? _addedByUserName,
  addons: addons ?? _addons,
  addonsPrice: addonsPrice ?? _addonsPrice,
  subtotalCouponDiscount: subtotalCouponDiscount ?? _subtotalCouponDiscount,
);
  num? get productId => _productId;
  num? get inStock => _inStock;
  bool? get isError => _isError;
  num? get allowedQuantity => _allowedQuantity;
  num? get quantity => _quantity;
  String? get name => _name;
  num? get isVeg => _isVeg;
  String? get productImageUrl => _productImageUrl;
  num? get finalPrice => _finalPrice;
  num? get effectiveItemPrice => _effectiveItemPrice;
  num? get packingCharge => _packingCharge;
  ItemTaxes? get itemTaxes => _itemTaxes;
  num? get subtotal => _subtotal;
  num? get total => _total;
  num? get addedByUserId => _addedByUserId;
  String? get addedByUserName => _addedByUserName;
  List<dynamic>? get addons => _addons;
  dynamic get addonsPrice => _addonsPrice;
  num? get subtotalCouponDiscount => _subtotalCouponDiscount;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['productId'] = _productId;
    map['in_stock'] = _inStock;
    map['is_error'] = _isError;
    map['allowed_quantity'] = _allowedQuantity;
    map['quantity'] = _quantity;
    map['name'] = _name;
    map['is_veg'] = _isVeg;
    map['product_imageUrl'] = _productImageUrl;
    map['final_price'] = _finalPrice;
    map['effective_item_price'] = _effectiveItemPrice;
    map['packing_charge'] = _packingCharge;
    if (_itemTaxes != null) {
      map['item_taxes'] = _itemTaxes?.toJson();
    }
    map['subtotal'] = _subtotal;
    map['total'] = _total;
    map['added_by_user_id'] = _addedByUserId;
    map['added_by_user_name'] = _addedByUserName;
    if (_addons != null) {
      map['addons'] = _addons?.map((v) => v.toJson()).toList();
    }
    map['addons_price'] = _addonsPrice;
    map['subtotal_coupon_discount'] = _subtotalCouponDiscount;
    return map;
  }

}

/// service_tax : 0
/// vat : 0
/// service_charges : 0
/// GST : 10

ItemTaxes itemTaxesFromJson(String str) => ItemTaxes.fromJson(json.decode(str));
String itemTaxesToJson(ItemTaxes data) => json.encode(data.toJson());
class ItemTaxes {
  ItemTaxes({
      num? serviceTax, 
      num? vat, 
      num? serviceCharges, 
      num? gst,}){
    _serviceTax = serviceTax;
    _vat = vat;
    _serviceCharges = serviceCharges;
    _gst = gst;
}

  ItemTaxes.fromJson(dynamic json) {
    _serviceTax = json['service_tax'];
    _vat = json['vat'];
    _serviceCharges = json['service_charges'];
    _gst = json['GST'];
  }
  num? _serviceTax;
  num? _vat;
  num? _serviceCharges;
  num? _gst;
ItemTaxes copyWith({  num? serviceTax,
  num? vat,
  num? serviceCharges,
  num? gst,
}) => ItemTaxes(  serviceTax: serviceTax ?? _serviceTax,
  vat: vat ?? _vat,
  serviceCharges: serviceCharges ?? _serviceCharges,
  gst: gst ?? _gst,
);
  num? get serviceTax => _serviceTax;
  num? get vat => _vat;
  num? get serviceCharges => _serviceCharges;
  num? get gst => _gst;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['service_tax'] = _serviceTax;
    map['vat'] = _vat;
    map['service_charges'] = _serviceCharges;
    map['GST'] = _gst;
    return map;
  }

}