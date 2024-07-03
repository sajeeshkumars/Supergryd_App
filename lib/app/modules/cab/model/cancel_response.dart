import 'dart:convert';
/// status : 200
/// message : "Success."
/// data : {"_id":"6684dc427af7a07a385b345b","unique_id":"SGRD-RIDEBK-1545-2024","user_id":"66595991f94a7ec05b88ebf9","service_category_id":"6646f2196538869d3399af46","origin_address":[{"lat":"10.055348","long":"76.321888","address":"Devalokam,Thevakal","address_id":null,"_id":"6684dc427af7a07a385b345c"}],"destination_address":[{"lat":"10.064588","long":"76.351151","address":"Seeroo it solutions","address_id":null,"_id":"6684dc427af7a07a385b345d"}],"status":7,"requested_time":"2024-07-03T05:06:10.947Z","requested_Id":555,"start_time":null,"end_time":null,"estimated_price":151.24,"driver_id":null,"driver_details":[{"phone_number":"14155551214","rating":4.1,"picture_url":"https://supergrydapi.ritikasingh.site/uploads/drivers/driver-2.png","name":"S Kumar","sms_number":"14155551214"}],"vehicle_details":[{"make":"BMW","picture_url":"https://supergrydapi.ritikasingh.site/uploads/vehicle/bmw.png","model":"7-series","license_plate":"KL-123 456"}],"service_provider_id":"6667ee14f4ef66615afa1186","otp":6605,"host_id":"664705340820502ae399d9b8","cancel_reason":"string","cancel_reason_id":1,"ride_review":[],"__v":0}

CancelResponse cancelResponseFromJson(String str) => CancelResponse.fromJson(json.decode(str));
String cancelResponseToJson(CancelResponse data) => json.encode(data.toJson());
class CancelResponse {
  CancelResponse({
      num? status, 
      String? message, 
      Data? data,}){
    _status = status;
    _message = message;
    _data = data;
}

  CancelResponse.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  num? _status;
  String? _message;
  Data? _data;
CancelResponse copyWith({  num? status,
  String? message,
  Data? data,
}) => CancelResponse(  status: status ?? _status,
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

/// _id : "6684dc427af7a07a385b345b"
/// unique_id : "SGRD-RIDEBK-1545-2024"
/// user_id : "66595991f94a7ec05b88ebf9"
/// service_category_id : "6646f2196538869d3399af46"
/// origin_address : [{"lat":"10.055348","long":"76.321888","address":"Devalokam,Thevakal","address_id":null,"_id":"6684dc427af7a07a385b345c"}]
/// destination_address : [{"lat":"10.064588","long":"76.351151","address":"Seeroo it solutions","address_id":null,"_id":"6684dc427af7a07a385b345d"}]
/// status : 7
/// requested_time : "2024-07-03T05:06:10.947Z"
/// requested_Id : 555
/// start_time : null
/// end_time : null
/// estimated_price : 151.24
/// driver_id : null
/// driver_details : [{"phone_number":"14155551214","rating":4.1,"picture_url":"https://supergrydapi.ritikasingh.site/uploads/drivers/driver-2.png","name":"S Kumar","sms_number":"14155551214"}]
/// vehicle_details : [{"make":"BMW","picture_url":"https://supergrydapi.ritikasingh.site/uploads/vehicle/bmw.png","model":"7-series","license_plate":"KL-123 456"}]
/// service_provider_id : "6667ee14f4ef66615afa1186"
/// otp : 6605
/// host_id : "664705340820502ae399d9b8"
/// cancel_reason : "string"
/// cancel_reason_id : 1
/// ride_review : []
/// __v : 0

Data dataFromJson(String str) => Data.fromJson(json.decode(str));
String dataToJson(Data data) => json.encode(data.toJson());
class Data {
  Data({
      String? id, 
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
      List<DriverDetails>? driverDetails, 
      List<VehicleDetails>? vehicleDetails, 
      String? serviceProviderId, 
      num? otp, 
      String? hostId, 
      String? cancelReason, 
      num? cancelReasonId, 
      List<dynamic>? rideReview, 
      num? v,}){
    _id = id;
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
    _cancelReasonId = cancelReasonId;
    _rideReview = rideReview;
    _v = v;
}

  Data.fromJson(dynamic json) {
    _id = json['_id'];
    _uniqueId = json['unique_id'];
    _userId = json['user_id'];
    _serviceCategoryId = json['service_category_id'];
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
    _status = json['status'];
    _requestedTime = json['requested_time'];
    _requestedId = json['requested_Id'];
    _startTime = json['start_time'];
    _endTime = json['end_time'];
    _estimatedPrice = json['estimated_price'];
    _driverId = json['driver_id'];
    if (json['driver_details'] != null) {
      _driverDetails = [];
      json['driver_details'].forEach((v) {
        _driverDetails?.add(DriverDetails.fromJson(v));
      });
    }
    if (json['vehicle_details'] != null) {
      _vehicleDetails = [];
      json['vehicle_details'].forEach((v) {
        _vehicleDetails?.add(VehicleDetails.fromJson(v));
      });
    }
    _serviceProviderId = json['service_provider_id'];
    _otp = json['otp'];
    _hostId = json['host_id'];
    _cancelReason = json['cancel_reason'];
    _cancelReasonId = json['cancel_reason_id'];
    // if (json['ride_review'] != null) {
    //   _rideReview = [];
    //   json['ride_review'].forEach((v) {
    //     _rideReview?.add(Dynamic.fromJson(v));
    //   });
    // }
    _v = json['__v'];
  }
  String? _id;
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
  List<DriverDetails>? _driverDetails;
  List<VehicleDetails>? _vehicleDetails;
  String? _serviceProviderId;
  num? _otp;
  String? _hostId;
  String? _cancelReason;
  num? _cancelReasonId;
  List<dynamic>? _rideReview;
  num? _v;
Data copyWith({  String? id,
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
  List<DriverDetails>? driverDetails,
  List<VehicleDetails>? vehicleDetails,
  String? serviceProviderId,
  num? otp,
  String? hostId,
  String? cancelReason,
  num? cancelReasonId,
  List<dynamic>? rideReview,
  num? v,
}) => Data(  id: id ?? _id,
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
  cancelReasonId: cancelReasonId ?? _cancelReasonId,
  rideReview: rideReview ?? _rideReview,
  v: v ?? _v,
);
  String? get id => _id;
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
  List<DriverDetails>? get driverDetails => _driverDetails;
  List<VehicleDetails>? get vehicleDetails => _vehicleDetails;
  String? get serviceProviderId => _serviceProviderId;
  num? get otp => _otp;
  String? get hostId => _hostId;
  String? get cancelReason => _cancelReason;
  num? get cancelReasonId => _cancelReasonId;
  List<dynamic>? get rideReview => _rideReview;
  num? get v => _v;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['unique_id'] = _uniqueId;
    map['user_id'] = _userId;
    map['service_category_id'] = _serviceCategoryId;
    if (_originAddress != null) {
      map['origin_address'] = _originAddress?.map((v) => v.toJson()).toList();
    }
    if (_destinationAddress != null) {
      map['destination_address'] = _destinationAddress?.map((v) => v.toJson()).toList();
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
    map['cancel_reason_id'] = _cancelReasonId;
    if (_rideReview != null) {
      map['ride_review'] = _rideReview?.map((v) => v.toJson()).toList();
    }
    map['__v'] = _v;
    return map;
  }

}

/// make : "BMW"
/// picture_url : "https://supergrydapi.ritikasingh.site/uploads/vehicle/bmw.png"
/// model : "7-series"
/// license_plate : "KL-123 456"

VehicleDetails vehicleDetailsFromJson(String str) => VehicleDetails.fromJson(json.decode(str));
String vehicleDetailsToJson(VehicleDetails data) => json.encode(data.toJson());
class VehicleDetails {
  VehicleDetails({
      String? make, 
      String? pictureUrl, 
      String? model, 
      String? licensePlate,}){
    _make = make;
    _pictureUrl = pictureUrl;
    _model = model;
    _licensePlate = licensePlate;
}

  VehicleDetails.fromJson(dynamic json) {
    _make = json['make'];
    _pictureUrl = json['picture_url'];
    _model = json['model'];
    _licensePlate = json['license_plate'];
  }
  String? _make;
  String? _pictureUrl;
  String? _model;
  String? _licensePlate;
VehicleDetails copyWith({  String? make,
  String? pictureUrl,
  String? model,
  String? licensePlate,
}) => VehicleDetails(  make: make ?? _make,
  pictureUrl: pictureUrl ?? _pictureUrl,
  model: model ?? _model,
  licensePlate: licensePlate ?? _licensePlate,
);
  String? get make => _make;
  String? get pictureUrl => _pictureUrl;
  String? get model => _model;
  String? get licensePlate => _licensePlate;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['make'] = _make;
    map['picture_url'] = _pictureUrl;
    map['model'] = _model;
    map['license_plate'] = _licensePlate;
    return map;
  }

}

/// phone_number : "14155551214"
/// rating : 4.1
/// picture_url : "https://supergrydapi.ritikasingh.site/uploads/drivers/driver-2.png"
/// name : "S Kumar"
/// sms_number : "14155551214"

DriverDetails driverDetailsFromJson(String str) => DriverDetails.fromJson(json.decode(str));
String driverDetailsToJson(DriverDetails data) => json.encode(data.toJson());
class DriverDetails {
  DriverDetails({
      String? phoneNumber, 
      num? rating, 
      String? pictureUrl, 
      String? name, 
      String? smsNumber,}){
    _phoneNumber = phoneNumber;
    _rating = rating;
    _pictureUrl = pictureUrl;
    _name = name;
    _smsNumber = smsNumber;
}

  DriverDetails.fromJson(dynamic json) {
    _phoneNumber = json['phone_number'];
    _rating = json['rating'];
    _pictureUrl = json['picture_url'];
    _name = json['name'];
    _smsNumber = json['sms_number'];
  }
  String? _phoneNumber;
  num? _rating;
  String? _pictureUrl;
  String? _name;
  String? _smsNumber;
DriverDetails copyWith({  String? phoneNumber,
  num? rating,
  String? pictureUrl,
  String? name,
  String? smsNumber,
}) => DriverDetails(  phoneNumber: phoneNumber ?? _phoneNumber,
  rating: rating ?? _rating,
  pictureUrl: pictureUrl ?? _pictureUrl,
  name: name ?? _name,
  smsNumber: smsNumber ?? _smsNumber,
);
  String? get phoneNumber => _phoneNumber;
  num? get rating => _rating;
  String? get pictureUrl => _pictureUrl;
  String? get name => _name;
  String? get smsNumber => _smsNumber;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['phone_number'] = _phoneNumber;
    map['rating'] = _rating;
    map['picture_url'] = _pictureUrl;
    map['name'] = _name;
    map['sms_number'] = _smsNumber;
    return map;
  }

}

/// lat : "10.064588"
/// long : "76.351151"
/// address : "Seeroo it solutions"
/// address_id : null
/// _id : "6684dc427af7a07a385b345d"

DestinationAddress destinationAddressFromJson(String str) => DestinationAddress.fromJson(json.decode(str));
String destinationAddressToJson(DestinationAddress data) => json.encode(data.toJson());
class DestinationAddress {
  DestinationAddress({
      String? lat, 
      String? long, 
      String? address, 
      dynamic addressId, 
      String? id,}){
    _lat = lat;
    _long = long;
    _address = address;
    _addressId = addressId;
    _id = id;
}

  DestinationAddress.fromJson(dynamic json) {
    _lat = json['lat'];
    _long = json['long'];
    _address = json['address'];
    _addressId = json['address_id'];
    _id = json['_id'];
  }
  String? _lat;
  String? _long;
  String? _address;
  dynamic _addressId;
  String? _id;
DestinationAddress copyWith({  String? lat,
  String? long,
  String? address,
  dynamic addressId,
  String? id,
}) => DestinationAddress(  lat: lat ?? _lat,
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

/// lat : "10.055348"
/// long : "76.321888"
/// address : "Devalokam,Thevakal"
/// address_id : null
/// _id : "6684dc427af7a07a385b345c"

OriginAddress originAddressFromJson(String str) => OriginAddress.fromJson(json.decode(str));
String originAddressToJson(OriginAddress data) => json.encode(data.toJson());
class OriginAddress {
  OriginAddress({
      String? lat, 
      String? long, 
      String? address, 
      dynamic addressId, 
      String? id,}){
    _lat = lat;
    _long = long;
    _address = address;
    _addressId = addressId;
    _id = id;
}

  OriginAddress.fromJson(dynamic json) {
    _lat = json['lat'];
    _long = json['long'];
    _address = json['address'];
    _addressId = json['address_id'];
    _id = json['_id'];
  }
  String? _lat;
  String? _long;
  String? _address;
  dynamic _addressId;
  String? _id;
OriginAddress copyWith({  String? lat,
  String? long,
  String? address,
  dynamic addressId,
  String? id,
}) => OriginAddress(  lat: lat ?? _lat,
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