import 'dart:convert';
/// status : 200
/// message : "Success."
/// data : {"statusCode":1,"statusMessage":"CART_UPDATED_SUCCESSFULLY","data":{"cartItems":{"65":{"productId":65,"in_stock":1,"is_error":false,"allowed_quantity":4,"quantity":2,"name":"Murgh Kefta (Chicken Meatball Kebab)","is_veg":0,"product_imageUrl":"https://supergrydapi.ritikasingh.site/uploads/dish/PVHISEXG3VP6.jpeg","final_price":199.98,"effective_item_price":247.98,"packing_charge":38,"item_taxes":{"service_tax":0,"vat":0,"service_charges":0,"GST":10},"subtotal":199.98,"total":237.98,"added_by_user_id":-1,"added_by_user_name":"","addons":[],"addons_price":null,"subtotal_coupon_discount":0}},"cartMeta":{"GST_details":{"cart_CGST":5.95,"cart_SGST":5.95,"cart_IGST":0,"external_GST":0,"item_CGST":5,"item_SGST":5,"item_IGST":0,"packaging_CGST":0.95,"packaging_SGST":0.95,"packaging_IGST":0,"service_charge_CGST":0,"service_charge_IGST":0,"service_charge_SGST":0},"cart_subtotal":237.98,"cart_subtotal_without_packing":199.98,"cart_total":249.88,"cart_total_count":2,"delivery_charges":50,"cartId":4821151639},"cartItemsCount":2,"minCartValue":200},"device_id":"82e5b85ad76d800531350b5f225158c4"}

AddToCartResponse addToCartResponseFromJson(String str) => AddToCartResponse.fromJson(json.decode(str));
String addToCartResponseToJson(AddToCartResponse data) => json.encode(data.toJson());
class AddToCartResponse {
  AddToCartResponse({
      num? status, 
      String? message, 
  }){
    _status = status;
    _message = message;
}

  AddToCartResponse.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
  }
  num? _status;
  String? _message;
AddToCartResponse copyWith({  num? status,
  String? message,
}) => AddToCartResponse(  status: status ?? _status,
  message: message ?? _message,
);
  num? get status => _status;
  String? get message => _message;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    return map;
  }

}

/// statusCode : 1
/// statusMessage : "CART_UPDATED_SUCCESSFULLY"
/// data : {"cartItems":{"65":{"productId":65,"in_stock":1,"is_error":false,"allowed_quantity":4,"quantity":2,"name":"Murgh Kefta (Chicken Meatball Kebab)","is_veg":0,"product_imageUrl":"https://supergrydapi.ritikasingh.site/uploads/dish/PVHISEXG3VP6.jpeg","final_price":199.98,"effective_item_price":247.98,"packing_charge":38,"item_taxes":{"service_tax":0,"vat":0,"service_charges":0,"GST":10},"subtotal":199.98,"total":237.98,"added_by_user_id":-1,"added_by_user_name":"","addons":[],"addons_price":null,"subtotal_coupon_discount":0}},"cartMeta":{"GST_details":{"cart_CGST":5.95,"cart_SGST":5.95,"cart_IGST":0,"external_GST":0,"item_CGST":5,"item_SGST":5,"item_IGST":0,"packaging_CGST":0.95,"packaging_SGST":0.95,"packaging_IGST":0,"service_charge_CGST":0,"service_charge_IGST":0,"service_charge_SGST":0},"cart_subtotal":237.98,"cart_subtotal_without_packing":199.98,"cart_total":249.88,"cart_total_count":2,"delivery_charges":50,"cartId":4821151639},"cartItemsCount":2,"minCartValue":200}
/// device_id : "82e5b85ad76d800531350b5f225158c4"



/// cartItems : {"65":{"productId":65,"in_stock":1,"is_error":false,"allowed_quantity":4,"quantity":2,"name":"Murgh Kefta (Chicken Meatball Kebab)","is_veg":0,"product_imageUrl":"https://supergrydapi.ritikasingh.site/uploads/dish/PVHISEXG3VP6.jpeg","final_price":199.98,"effective_item_price":247.98,"packing_charge":38,"item_taxes":{"service_tax":0,"vat":0,"service_charges":0,"GST":10},"subtotal":199.98,"total":237.98,"added_by_user_id":-1,"added_by_user_name":"","addons":[],"addons_price":null,"subtotal_coupon_discount":0}}
/// cartMeta : {"GST_details":{"cart_CGST":5.95,"cart_SGST":5.95,"cart_IGST":0,"external_GST":0,"item_CGST":5,"item_SGST":5,"item_IGST":0,"packaging_CGST":0.95,"packaging_SGST":0.95,"packaging_IGST":0,"service_charge_CGST":0,"service_charge_IGST":0,"service_charge_SGST":0},"cart_subtotal":237.98,"cart_subtotal_without_packing":199.98,"cart_total":249.88,"cart_total_count":2,"delivery_charges":50,"cartId":4821151639}
/// cartItemsCount : 2
/// minCartValue : 200


/// GST_details : {"cart_CGST":5.95,"cart_SGST":5.95,"cart_IGST":0,"external_GST":0,"item_CGST":5,"item_SGST":5,"item_IGST":0,"packaging_CGST":0.95,"packaging_SGST":0.95,"packaging_IGST":0,"service_charge_CGST":0,"service_charge_IGST":0,"service_charge_SGST":0}
/// cart_subtotal : 237.98
/// cart_subtotal_without_packing : 199.98
/// cart_total : 249.88
/// cart_total_count : 2
/// delivery_charges : 50
/// cartId : 4821151639



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



/// 65 : {"productId":65,"in_stock":1,"is_error":false,"allowed_quantity":4,"quantity":2,"name":"Murgh Kefta (Chicken Meatball Kebab)","is_veg":0,"product_imageUrl":"https://supergrydapi.ritikasingh.site/uploads/dish/PVHISEXG3VP6.jpeg","final_price":199.98,"effective_item_price":247.98,"packing_charge":38,"item_taxes":{"service_tax":0,"vat":0,"service_charges":0,"GST":10},"subtotal":199.98,"total":237.98,"added_by_user_id":-1,"added_by_user_name":"","addons":[],"addons_price":null,"subtotal_coupon_discount":0}


