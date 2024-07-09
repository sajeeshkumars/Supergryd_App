import 'dart:convert';
/// status : 200
/// message : "Success."
/// data : [{"_id":"66866d7af1a68d09bae948da","unique_id":"SGRD-RIDEBK-1105-2024","origin_address":[{"lat":"10.055348","long":"76.321888","address":"Devalokam,Thevakal","address_id":null,"_id":"66866d7af1a68d09bae948db"}],"destination_address":[{"lat":"10.064588","long":"76.351151","address":"Seeroo it solutions","address_id":null,"_id":"66866d7af1a68d09bae948dc"}],"status":6,"requested_time":"2024-07-04T09:38:02.203Z","start_time":"2024-07-04T09:40:02.486Z","end_time":"2024-07-04T09:43:02.643Z","estimated_price":151.24,"driver_details":[{"phone_number":"14155551229","rating":4.1,"picture_url":"https://supergrydapi.ritikasingh.site/uploads/drivers/driver-5.png","name":"Rimpa","sms_number":"14155551229"}],"vehicle_details":[{"make":"BMW","picture_url":"https://supergrydapi.ritikasingh.site/uploads/vehicle/bmw.png","model":"9-series","license_plate":"KL-568 258"}],"otp":3820,"cancel_reason":null,"duration":202,"distance":3.36,"ride_review":[]}]

RideDetailsResponse rideDetailsResponseFromJson(String str) => RideDetailsResponse.fromJson(json.decode(str));
String rideDetailsResponseToJson(RideDetailsResponse data) => json.encode(data.toJson());
class RideDetailsResponse {
  RideDetailsResponse({
      num? status, 
      String? message, 
      List<Data>? data,}){
    _status = status;
    _message = message;
    _data = data;
}

  RideDetailsResponse.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(Data.fromJson(v));
      });
    }
  }
  num? _status;
  String? _message;
  List<Data>? _data;
RideDetailsResponse copyWith({  num? status,
  String? message,
  List<Data>? data,
}) => RideDetailsResponse(  status: status ?? _status,
  message: message ?? _message,
  data: data ?? _data,
);
  num? get status => _status;
  String? get message => _message;
  List<Data>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// _id : "66866d7af1a68d09bae948da"
/// unique_id : "SGRD-RIDEBK-1105-2024"
/// origin_address : [{"lat":"10.055348","long":"76.321888","address":"Devalokam,Thevakal","address_id":null,"_id":"66866d7af1a68d09bae948db"}]
/// destination_address : [{"lat":"10.064588","long":"76.351151","address":"Seeroo it solutions","address_id":null,"_id":"66866d7af1a68d09bae948dc"}]
/// status : 6
/// requested_time : "2024-07-04T09:38:02.203Z"
/// start_time : "2024-07-04T09:40:02.486Z"
/// end_time : "2024-07-04T09:43:02.643Z"
/// estimated_price : 151.24
/// driver_details : [{"phone_number":"14155551229","rating":4.1,"picture_url":"https://supergrydapi.ritikasingh.site/uploads/drivers/driver-5.png","name":"Rimpa","sms_number":"14155551229"}]
/// vehicle_details : [{"make":"BMW","picture_url":"https://supergrydapi.ritikasingh.site/uploads/vehicle/bmw.png","model":"9-series","license_plate":"KL-568 258"}]
/// otp : 3820
/// cancel_reason : null
/// duration : 202
/// distance : 3.36
/// ride_review : []

Data dataFromJson(String str) => Data.fromJson(json.decode(str));
String dataToJson(Data data) => json.encode(data.toJson());
class Data {
  Data({
      String? id, 
      String? uniqueId, 
      List<OriginAddress>? originAddress, 
      List<DestinationAddress>? destinationAddress, 
      num? status, 
      String? requestedTime,
    int? requestId,
      String? startTime, 
      String? endTime, 
      num? estimatedPrice, 
      List<DriverDetails>? driverDetails, 
      List<VehicleDetails>? vehicleDetails, 
      num? otp, 
      dynamic cancelReason, 
      num? duration, 
      num? distance, 
      List<dynamic>? rideReview,}){
    _id = id;
    _uniqueId = uniqueId;
    _originAddress = originAddress;
    _destinationAddress = destinationAddress;
    _status = status;
    _requestedTime = requestedTime;
    _requestId = requestId;
    _startTime = startTime;
    _endTime = endTime;
    _estimatedPrice = estimatedPrice;
    _driverDetails = driverDetails;
    _vehicleDetails = vehicleDetails;
    _otp = otp;
    _cancelReason = cancelReason;
    _duration = duration;
    _distance = distance;
    _rideReview = rideReview;
}

  Data.fromJson(dynamic json) {
    _id = json['_id'];
    _uniqueId = json['unique_id'];
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
    _requestId = json['requested_Id'];
    _startTime = json['start_time'];
    _endTime = json['end_time'];
    _estimatedPrice = json['estimated_price'];
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
    _otp = json['otp'];
    _cancelReason = json['cancel_reason'];
    _duration = json['duration'];
    _distance = json['distance'];
    // if (json['ride_review'] != null) {
    //   _rideReview = [];
    //   json['ride_review'].forEach((v) {
    //     _rideReview?.add(Dynamic.fromJson(v));
    //   });
    // }
  }
  String? _id;
  String? _uniqueId;
  List<OriginAddress>? _originAddress;
  List<DestinationAddress>? _destinationAddress;
  num? _status;
  String? _requestedTime;
  int? _requestId;
  String? _startTime;
  String? _endTime;
  num? _estimatedPrice;
  List<DriverDetails>? _driverDetails;
  List<VehicleDetails>? _vehicleDetails;
  num? _otp;
  dynamic _cancelReason;
  num? _duration;
  num? _distance;
  List<dynamic>? _rideReview;
Data copyWith({  String? id,
  String? uniqueId,
  List<OriginAddress>? originAddress,
  List<DestinationAddress>? destinationAddress,
  num? status,
  String? requestedTime,
  int? requestId,
  String? startTime,
  String? endTime,
  num? estimatedPrice,
  List<DriverDetails>? driverDetails,
  List<VehicleDetails>? vehicleDetails,
  num? otp,
  dynamic cancelReason,
  num? duration,
  num? distance,
  List<dynamic>? rideReview,
}) => Data(  id: id ?? _id,
  uniqueId: uniqueId ?? _uniqueId,
  originAddress: originAddress ?? _originAddress,
  destinationAddress: destinationAddress ?? _destinationAddress,
  status: status ?? _status,
  requestedTime: requestedTime ?? _requestedTime,
  requestId: requestId ?? _requestId,
  startTime: startTime ?? _startTime,
  endTime: endTime ?? _endTime,
  estimatedPrice: estimatedPrice ?? _estimatedPrice,
  driverDetails: driverDetails ?? _driverDetails,
  vehicleDetails: vehicleDetails ?? _vehicleDetails,
  otp: otp ?? _otp,
  cancelReason: cancelReason ?? _cancelReason,
  duration: duration ?? _duration,
  distance: distance ?? _distance,
  rideReview: rideReview ?? _rideReview,
);
  String? get id => _id;
  String? get uniqueId => _uniqueId;
  List<OriginAddress>? get originAddress => _originAddress;
  List<DestinationAddress>? get destinationAddress => _destinationAddress;
  num? get status => _status;
  String? get requestedTime => _requestedTime;
  int? get requestId => _requestId;
  String? get startTime => _startTime;
  String? get endTime => _endTime;
  num? get estimatedPrice => _estimatedPrice;
  List<DriverDetails>? get driverDetails => _driverDetails;
  List<VehicleDetails>? get vehicleDetails => _vehicleDetails;
  num? get otp => _otp;
  dynamic get cancelReason => _cancelReason;
  num? get duration => _duration;
  num? get distance => _distance;
  List<dynamic>? get rideReview => _rideReview;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['unique_id'] = _uniqueId;
    if (_originAddress != null) {
      map['origin_address'] = _originAddress?.map((v) => v.toJson()).toList();
    }
    if (_destinationAddress != null) {
      map['destination_address'] = _destinationAddress?.map((v) => v.toJson()).toList();
    }
    map['status'] = _status;
    map['requested_time'] = _requestedTime;
    map['requested_Id'] = _requestId;
    map['start_time'] = _startTime;
    map['end_time'] = _endTime;
    map['estimated_price'] = _estimatedPrice;
    if (_driverDetails != null) {
      map['driver_details'] = _driverDetails?.map((v) => v.toJson()).toList();
    }
    if (_vehicleDetails != null) {
      map['vehicle_details'] = _vehicleDetails?.map((v) => v.toJson()).toList();
    }
    map['otp'] = _otp;
    map['cancel_reason'] = _cancelReason;
    map['duration'] = _duration;
    map['distance'] = _distance;
    if (_rideReview != null) {
      map['ride_review'] = _rideReview?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// make : "BMW"
/// picture_url : "https://supergrydapi.ritikasingh.site/uploads/vehicle/bmw.png"
/// model : "9-series"
/// license_plate : "KL-568 258"

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

/// phone_number : "14155551229"
/// rating : 4.1
/// picture_url : "https://supergrydapi.ritikasingh.site/uploads/drivers/driver-5.png"
/// name : "Rimpa"
/// sms_number : "14155551229"

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
/// _id : "66866d7af1a68d09bae948dc"

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
/// _id : "66866d7af1a68d09bae948db"

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