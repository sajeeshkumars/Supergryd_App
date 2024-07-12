import 'dart:convert';
/// status : 200
/// message : "Success."
/// data : {"statusCode":1,"statusMessage":"ORDER_CREATED_SUCCESSFULLY","orderReferance":[{"order_id":11,"total_amount":500}]}

CreateOrderResponse createOrderResponseFromJson(String str) => CreateOrderResponse.fromJson(json.decode(str));
String createOrderResponseToJson(CreateOrderResponse data) => json.encode(data.toJson());
class CreateOrderResponse {
  CreateOrderResponse({
      num? status, 
      String? message, 
      Data? data,}){
    _status = status;
    _message = message;
    _data = data;
}

  CreateOrderResponse.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  num? _status;
  String? _message;
  Data? _data;
CreateOrderResponse copyWith({  num? status,
  String? message,
  Data? data,
}) => CreateOrderResponse(  status: status ?? _status,
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
/// statusMessage : "ORDER_CREATED_SUCCESSFULLY"
/// orderReferance : [{"order_id":11,"total_amount":500}]

Data dataFromJson(String str) => Data.fromJson(json.decode(str));
String dataToJson(Data data) => json.encode(data.toJson());
class Data {
  Data({
      num? statusCode, 
      String? statusMessage, 
      List<OrderReferance>? orderReferance,}){
    _statusCode = statusCode;
    _statusMessage = statusMessage;
    _orderReferance = orderReferance;
}

  Data.fromJson(dynamic json) {
    _statusCode = json['statusCode'];
    _statusMessage = json['statusMessage'];
    if (json['orderReferance'] != null) {
      _orderReferance = [];
      json['orderReferance'].forEach((v) {
        _orderReferance?.add(OrderReferance.fromJson(v));
      });
    }
  }
  num? _statusCode;
  String? _statusMessage;
  List<OrderReferance>? _orderReferance;
Data copyWith({  num? statusCode,
  String? statusMessage,
  List<OrderReferance>? orderReferance,
}) => Data(  statusCode: statusCode ?? _statusCode,
  statusMessage: statusMessage ?? _statusMessage,
  orderReferance: orderReferance ?? _orderReferance,
);
  num? get statusCode => _statusCode;
  String? get statusMessage => _statusMessage;
  List<OrderReferance>? get orderReferance => _orderReferance;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['statusCode'] = _statusCode;
    map['statusMessage'] = _statusMessage;
    if (_orderReferance != null) {
      map['orderReferance'] = _orderReferance?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// order_id : 11
/// total_amount : 500

OrderReferance orderReferanceFromJson(String str) => OrderReferance.fromJson(json.decode(str));
String orderReferanceToJson(OrderReferance data) => json.encode(data.toJson());
class OrderReferance {
  OrderReferance({
      num? orderId, 
      num? totalAmount,}){
    _orderId = orderId;
    _totalAmount = totalAmount;
}

  OrderReferance.fromJson(dynamic json) {
    _orderId = json['order_id'];
    _totalAmount = json['total_amount'];
  }
  num? _orderId;
  num? _totalAmount;
OrderReferance copyWith({  num? orderId,
  num? totalAmount,
}) => OrderReferance(  orderId: orderId ?? _orderId,
  totalAmount: totalAmount ?? _totalAmount,
);
  num? get orderId => _orderId;
  num? get totalAmount => _totalAmount;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['order_id'] = _orderId;
    map['total_amount'] = _totalAmount;
    return map;
  }

}