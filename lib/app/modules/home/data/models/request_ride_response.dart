import 'dart:convert';

/// status : 200
/// message : "Success."
/// data : {"unique_id":"SGRD-RIDEBK-1002-2024","user_id":"66595991f94a7ec05b88ebf9","service_category_id":"6646f2196538869d3399af46","origin_address":[{"lat":"12.9147399","long":"77.5972174","address":"Kochi","address_id":null,"_id":"667ab2081a333f86b41462df"}],"destination_address":[{"lat":"12.90","long":"77.57","address":"Kochi airport","address_id":null,"_id":"667ab2081a333f86b41462e0"}],"status":1,"requested_time":"2024-06-25T12:03:20.402Z","requested_Id":7,"start_time":null,"end_time":null,"estimated_price":245.7,"driver_id":null,"driver_details":[],"vehicle_details":[],"service_provider_id":"6667ee14f4ef66615afa1186","otp":null,"host_id":"664705340820502ae399d9b8","cancel_reason":null,"_id":"667ab2081a333f86b41462de","ride_review":[],"__v":0}

RequestRideResponse requestRideResponseFromJson(String str) =>
    RequestRideResponse.fromJson(json.decode(str));
String requestRideResponseToJson(RequestRideResponse data) =>
    json.encode(data.toJson());

class RequestRideResponse {
  RequestRideResponse({
    num? status,
    String? message,
    String? messages,
    RequestRideData? data,
  }) {
    _status = status;
    _message = message;
    _data = data;
  }

  RequestRideResponse.fromJson(dynamic json) {
    _status = int.parse(json['status'].toString());
    _message = json['message'].toString();
    _messages = json['messages'].toString();
    _data =
        json['data'] != null ? RequestRideData.fromJson(json['data']) : null;
  }
  num? _status;
  String? _message;
  String? _messages;
  RequestRideData? _data;
  RequestRideResponse copyWith(
          {num? status,
          String? message,
          RequestRideData? data,
          String? messages}) =>
      RequestRideResponse(
        status: status ?? _status,
        message: message ?? _message,
        messages: messages ?? _messages,
        data: data ?? _data,
      );
  num? get status => _status;
  String? get message => _message;
  String? get messages => _messages;
  RequestRideData? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    map['messages'] = _messages;
    if (_data != null) {
      map['data'] = _data?.toJson();
    }
    return map;
  }
}

/// unique_id : "SGRD-RIDEBK-1002-2024"
/// user_id : "66595991f94a7ec05b88ebf9"
/// service_category_id : "6646f2196538869d3399af46"
/// origin_address : [{"lat":"12.9147399","long":"77.5972174","address":"Kochi","address_id":null,"_id":"667ab2081a333f86b41462df"}]
/// destination_address : [{"lat":"12.90","long":"77.57","address":"Kochi airport","address_id":null,"_id":"667ab2081a333f86b41462e0"}]
/// status : 1
/// requested_time : "2024-06-25T12:03:20.402Z"
/// requested_Id : 7
/// start_time : null
/// end_time : null
/// estimated_price : 245.7
/// driver_id : null
/// driver_details : []
/// vehicle_details : []
/// service_provider_id : "6667ee14f4ef66615afa1186"
/// otp : null
/// host_id : "664705340820502ae399d9b8"
/// cancel_reason : null
/// _id : "667ab2081a333f86b41462de"
/// ride_review : []
/// __v : 0

RequestRideData dataFromJson(String str) =>
    RequestRideData.fromJson(json.decode(str));
String dataToJson(RequestRideData data) => json.encode(data.toJson());

class RequestRideData {
  RequestRideData({
    String? uniqueId,
    String? userId,
    String? serviceCategoryId,
    List<OriginAddress>? originAddress,
    List<DestinationAddress>? destinationAddress,
    num? status,
    String? requestedTime,
    num? requestedId,
    dynamic startTime,
    dynamic endTime,
    num? estimatedPrice,
    dynamic driverId,
    List<dynamic>? driverDetails,
    List<dynamic>? vehicleDetails,
    String? serviceProviderId,
    dynamic otp,
    String? hostId,
    dynamic cancelReason,
    String? id,
    List<dynamic>? rideReview,
    num? v,
  }) {
    _uniqueId = uniqueId;
    _userId = userId;
    _serviceCategoryId = serviceCategoryId;
    _originAddress = originAddress;
    _destinationAddress = destinationAddress;
    _status = status;
    _requestedTime = requestedTime;
    _requestedId = requestedId;
    _startTime = startTime;
    _endTime = endTime;
    _estimatedPrice = estimatedPrice;
    _driverId = driverId;
    _driverDetails = driverDetails;
    _vehicleDetails = vehicleDetails;
    _serviceProviderId = serviceProviderId;
    _otp = otp;
    _hostId = hostId;
    _cancelReason = cancelReason;
    _id = id;
    _rideReview = rideReview;
    _v = v;
  }

  RequestRideData.fromJson(dynamic json) {
    _uniqueId = json['unique_id'].toString();
    _userId = json['user_id'].toString();
    _serviceCategoryId = json['service_category_id'].toString();
    if (json['origin_address'] != null) {
      _originAddress = [];
      json['origin_address'].forEach((v) {
        _originAddress?.add(OriginAddress.fromJson(v));
      });
    }
    if (json['destination_address'] != null) {
      _destinationAddress = [];
      json['destination_address'].forEach((v) {
        _destinationAddress?.add(DestinationAddress.fromJson(v));
      });
    }
    _status = num.parse(json['status'].toString());
    _requestedTime = json['requested_time'].toString();
    _requestedId = num.parse(json['requested_Id'].toString());
    _startTime = json['start_time'];
    _endTime = json['end_time'];
    _estimatedPrice = num.parse(json['estimated_price'].toString());
    _driverId = json['driver_id'];
    // if (json['driver_details'] != null) {
    //   _driverDetails = [];
    //   json['driver_details'].forEach((v) {
    //     _driverDetails?.add(Dynamic.fromJson(v));
    //   });
    // }
    // if (json['vehicle_details'] != null) {
    //   _vehicleDetails = [];
    //   json['vehicle_details'].forEach((v) {
    //     _vehicleDetails?.add(Dynamic.fromJson(v));
    //   });
    // }
    _serviceProviderId = json['service_provider_id'].toString();
    _otp = json['otp'];
    _hostId = json['host_id'].toString();
    _cancelReason = json['cancel_reason'];
    _id = json['_id'].toString();
    // if (json['ride_review'] != null) {
    //   _rideReview = [];
    //   json['ride_review'].forEach((v) {
    //     _rideReview?.add(Dynamic.fromJson(v));
    //   });
    // }
    // _v = json['__v'];
  }
  String? _uniqueId;
  String? _userId;
  String? _serviceCategoryId;
  List<OriginAddress>? _originAddress;
  List<DestinationAddress>? _destinationAddress;
  num? _status;
  String? _requestedTime;
  num? _requestedId;
  dynamic _startTime;
  dynamic _endTime;
  num? _estimatedPrice;
  dynamic _driverId;
  List<dynamic>? _driverDetails;
  List<dynamic>? _vehicleDetails;
  String? _serviceProviderId;
  dynamic _otp;
  String? _hostId;
  dynamic _cancelReason;
  String? _id;
  List<dynamic>? _rideReview;
  num? _v;
  RequestRideData copyWith({
    String? uniqueId,
    String? userId,
    String? serviceCategoryId,
    List<OriginAddress>? originAddress,
    List<DestinationAddress>? destinationAddress,
    num? status,
    String? requestedTime,
    num? requestedId,
    dynamic startTime,
    dynamic endTime,
    num? estimatedPrice,
    dynamic driverId,
    List<dynamic>? driverDetails,
    List<dynamic>? vehicleDetails,
    String? serviceProviderId,
    dynamic otp,
    String? hostId,
    dynamic cancelReason,
    String? id,
    List<dynamic>? rideReview,
    num? v,
  }) =>
      RequestRideData(
        uniqueId: uniqueId ?? _uniqueId,
        userId: userId ?? _userId,
        serviceCategoryId: serviceCategoryId ?? _serviceCategoryId,
        originAddress: originAddress ?? _originAddress,
        destinationAddress: destinationAddress ?? _destinationAddress,
        status: status ?? _status,
        requestedTime: requestedTime ?? _requestedTime,
        requestedId: requestedId ?? _requestedId,
        startTime: startTime ?? _startTime,
        endTime: endTime ?? _endTime,
        estimatedPrice: estimatedPrice ?? _estimatedPrice,
        driverId: driverId ?? _driverId,
        driverDetails: driverDetails ?? _driverDetails,
        vehicleDetails: vehicleDetails ?? _vehicleDetails,
        serviceProviderId: serviceProviderId ?? _serviceProviderId,
        otp: otp ?? _otp,
        hostId: hostId ?? _hostId,
        cancelReason: cancelReason ?? _cancelReason,
        id: id ?? _id,
        rideReview: rideReview ?? _rideReview,
        v: v ?? _v,
      );
  String? get uniqueId => _uniqueId;
  String? get userId => _userId;
  String? get serviceCategoryId => _serviceCategoryId;
  List<OriginAddress>? get originAddress => _originAddress;
  List<DestinationAddress>? get destinationAddress => _destinationAddress;
  num? get status => _status;
  String? get requestedTime => _requestedTime;
  num? get requestedId => _requestedId;
  dynamic get startTime => _startTime;
  dynamic get endTime => _endTime;
  num? get estimatedPrice => _estimatedPrice;
  dynamic get driverId => _driverId;
  List<dynamic>? get driverDetails => _driverDetails;
  List<dynamic>? get vehicleDetails => _vehicleDetails;
  String? get serviceProviderId => _serviceProviderId;
  dynamic get otp => _otp;
  String? get hostId => _hostId;
  dynamic get cancelReason => _cancelReason;
  String? get id => _id;
  List<dynamic>? get rideReview => _rideReview;
  num? get v => _v;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['unique_id'] = _uniqueId;
    map['user_id'] = _userId;
    map['service_category_id'] = _serviceCategoryId;
    if (_originAddress != null) {
      map['origin_address'] = _originAddress?.map((v) => v.toJson()).toList();
    }
    if (_destinationAddress != null) {
      map['destination_address'] =
          _destinationAddress?.map((v) => v.toJson()).toList();
    }
    map['status'] = _status;
    map['requested_time'] = _requestedTime;
    map['requested_Id'] = _requestedId;
    map['start_time'] = _startTime;
    map['end_time'] = _endTime;
    map['estimated_price'] = _estimatedPrice;
    map['driver_id'] = _driverId;
    if (_driverDetails != null) {
      map['driver_details'] = _driverDetails?.map((v) => v.toJson()).toList();
    }
    if (_vehicleDetails != null) {
      map['vehicle_details'] = _vehicleDetails?.map((v) => v.toJson()).toList();
    }
    map['service_provider_id'] = _serviceProviderId;
    map['otp'] = _otp;
    map['host_id'] = _hostId;
    map['cancel_reason'] = _cancelReason;
    map['_id'] = _id;
    if (_rideReview != null) {
      map['ride_review'] = _rideReview?.map((v) => v.toJson()).toList();
    }
    map['__v'] = _v;
    return map;
  }
}

/// lat : "12.90"
/// long : "77.57"
/// address : "Kochi airport"
/// address_id : null
/// _id : "667ab2081a333f86b41462e0"

DestinationAddress destinationAddressFromJson(String str) =>
    DestinationAddress.fromJson(json.decode(str));
String destinationAddressToJson(DestinationAddress data) =>
    json.encode(data.toJson());

class DestinationAddress {
  DestinationAddress({
    String? lat,
    String? long,
    String? address,
    dynamic addressId,
    String? id,
  }) {
    _lat = lat;
    _long = long;
    _address = address;
    _addressId = addressId;
    _id = id;
  }

  DestinationAddress.fromJson(dynamic json) {
    _lat = json['lat'].toString();
    _long = json['long'].toString();
    _address = json['address'].toString();
    _addressId = json['address_id'];
    _id = json['_id'].toString();
  }
  String? _lat;
  String? _long;
  String? _address;
  dynamic _addressId;
  String? _id;
  DestinationAddress copyWith({
    String? lat,
    String? long,
    String? address,
    dynamic addressId,
    String? id,
  }) =>
      DestinationAddress(
        lat: lat ?? _lat,
        long: long ?? _long,
        address: address ?? _address,
        addressId: addressId ?? _addressId,
        id: id ?? _id,
      );
  String? get lat => _lat;
  String? get long => _long;
  String? get address => _address;
  dynamic get addressId => _addressId;
  String? get id => _id;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['lat'] = _lat;
    map['long'] = _long;
    map['address'] = _address;
    map['address_id'] = _addressId;
    map['_id'] = _id;
    return map;
  }
}

/// lat : "12.9147399"
/// long : "77.5972174"
/// address : "Kochi"
/// address_id : null
/// _id : "667ab2081a333f86b41462df"

OriginAddress originAddressFromJson(String str) =>
    OriginAddress.fromJson(json.decode(str));
String originAddressToJson(OriginAddress data) => json.encode(data.toJson());

class OriginAddress {
  OriginAddress({
    String? lat,
    String? long,
    String? address,
    dynamic addressId,
    String? id,
  }) {
    _lat = lat;
    _long = long;
    _address = address;
    _addressId = addressId;
    _id = id;
  }

  OriginAddress.fromJson(dynamic json) {
    _lat = json['lat'].toString();
    _long = json['long'].toString();
    _address = json['address'].toString();
    _addressId = json['address_id'];
    _id = json['_id'].toString();
  }
  String? _lat;
  String? _long;
  String? _address;
  dynamic _addressId;
  String? _id;
  OriginAddress copyWith({
    String? lat,
    String? long,
    String? address,
    dynamic addressId,
    String? id,
  }) =>
      OriginAddress(
        lat: lat ?? _lat,
        long: long ?? _long,
        address: address ?? _address,
        addressId: addressId ?? _addressId,
        id: id ?? _id,
      );
  String? get lat => _lat;
  String? get long => _long;
  String? get address => _address;
  dynamic get addressId => _addressId;
  String? get id => _id;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['lat'] = _lat;
    map['long'] = _long;
    map['address'] = _address;
    map['address_id'] = _addressId;
    map['_id'] = _id;
    return map;
  }
}
