import 'dart:convert';
/// status : 2
/// message : "Restaurant accepted the order"
/// code : "order_accepted"
/// order_id : "21"

OrderTrackResponse orderTrackResponseFromJson(String str) => OrderTrackResponse.fromJson(json.decode(str));
String orderTrackResponseToJson(OrderTrackResponse data) => json.encode(data.toJson());
class OrderTrackResponse {
  OrderTrackResponse({
      num? status,
      String? message, 
      String? code, 
      String? orderId,}){
    _status = status;
    _message = message;
    _code = code;
    _orderId = orderId;
}

  OrderTrackResponse.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    _code = json['code'];
    _orderId = json['order_id'];
  }
  num? _status;
  String? _message;
  String? _code;
  String? _orderId;
OrderTrackResponse copyWith({  num? status,
  String? message,
  String? code,
  String? orderId,
}) => OrderTrackResponse(  status: status ?? _status,
  message: message ?? _message,
  code: code ?? _code,
  orderId: orderId ?? _orderId,
);
  num? get status => _status;
  String? get message => _message;
  String? get code => _code;
  String? get orderId => _orderId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    map['code'] = _code;
    map['order_id'] = _orderId;
    return map;
  }

}