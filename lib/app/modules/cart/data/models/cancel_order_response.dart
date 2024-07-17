import 'dart:convert';
/// status : 200
/// message : "Success."
/// data : {"statusCode":1,"statusMessage":"ORDER_CANCELLED_SUCCESSFULLY"}

CancelOrderResponse cancelOrderResponseFromJson(String str) => CancelOrderResponse.fromJson(json.decode(str));
String cancelOrderResponseToJson(CancelOrderResponse data) => json.encode(data.toJson());
class CancelOrderResponse {
  CancelOrderResponse({
      num? status, 
      String? message, 
      Data? data,}){
    _status = status;
    _message = message;
    _data = data;
}

  CancelOrderResponse.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  num? _status;
  String? _message;
  Data? _data;
CancelOrderResponse copyWith({  num? status,
  String? message,
  Data? data,
}) => CancelOrderResponse(  status: status ?? _status,
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
/// statusMessage : "ORDER_CANCELLED_SUCCESSFULLY"

Data dataFromJson(String str) => Data.fromJson(json.decode(str));
String dataToJson(Data data) => json.encode(data.toJson());
class Data {
  Data({
      num? statusCode, 
      String? statusMessage,}){
    _statusCode = statusCode;
    _statusMessage = statusMessage;
}

  Data.fromJson(dynamic json) {
    _statusCode = json['statusCode'];
    _statusMessage = json['statusMessage'];
  }
  num? _statusCode;
  String? _statusMessage;
Data copyWith({  num? statusCode,
  String? statusMessage,
}) => Data(  statusCode: statusCode ?? _statusCode,
  statusMessage: statusMessage ?? _statusMessage,
);
  num? get statusCode => _statusCode;
  String? get statusMessage => _statusMessage;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['statusCode'] = _statusCode;
    map['statusMessage'] = _statusMessage;
    return map;
  }

}