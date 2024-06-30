import 'dart:convert';
/// status : 200
/// message : "Success."
/// data : [{"_id":"66827d124d8df0c05da6328b","origin_address":[{"lat":"10.055348","long":"76.321888","address":"Devalokam,Thevakal","address_id":null,"_id":"66827d124d8df0c05da6328c"}],"destination_address":[{"lat":"10.064588","long":"76.351151","address":"Seeroo it solutions","address_id":null,"_id":"66827d124d8df0c05da6328d"}],"status":3,"estimated_price":151.24,"driver_details":[{"phone_number":"14155551214","rating":4.1,"picture_url":"https://supergrydapi.ritikasingh.site/uploads/drivers/driver-2.png","name":"S Kumar","sms_number":"14155551214"}],"vehicle_details":[{"make":"BMW","picture_url":"https://supergrydapi.ritikasingh.site/uploads/vehicle/bmw.png","model":"7-series","license_plate":"KL-123 456"}],"otp":2235}]

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

/// _id : "66827d124d8df0c05da6328b"
/// origin_address : [{"lat":"10.055348","long":"76.321888","address":"Devalokam,Thevakal","address_id":null,"_id":"66827d124d8df0c05da6328c"}]
/// destination_address : [{"lat":"10.064588","long":"76.351151","address":"Seeroo it solutions","address_id":null,"_id":"66827d124d8df0c05da6328d"}]
/// status : 3
/// estimated_price : 151.24
/// driver_details : [{"phone_number":"14155551214","rating":4.1,"picture_url":"https://supergrydapi.ritikasingh.site/uploads/drivers/driver-2.png","name":"S Kumar","sms_number":"14155551214"}]
/// vehicle_details : [{"make":"BMW","picture_url":"https://supergrydapi.ritikasingh.site/uploads/vehicle/bmw.png","model":"7-series","license_plate":"KL-123 456"}]
/// otp : 2235

Data dataFromJson(String str) => Data.fromJson(json.decode(str));
String dataToJson(Data data) => json.encode(data.toJson());
class Data {
  Data({
      String? id, 
      List<OriginAddress>? originAddress, 
      List<DestinationAddress>? destinationAddress, 
      num? status, 
      num? estimatedPrice, 
      List<DriverDetails>? driverDetails, 
      List<VehicleDetails>? vehicleDetails, 
      num? otp,}){
    _id = id;
    _originAddress = originAddress;
    _destinationAddress = destinationAddress;
    _status = status;
    _estimatedPrice = estimatedPrice;
    _driverDetails = driverDetails;
    _vehicleDetails = vehicleDetails;
    _otp = otp;
}

  Data.fromJson(dynamic json) {
    _id = json['_id'];
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
  }
  String? _id;
  List<OriginAddress>? _originAddress;
  List<DestinationAddress>? _destinationAddress;
  num? _status;
  num? _estimatedPrice;
  List<DriverDetails>? _driverDetails;
  List<VehicleDetails>? _vehicleDetails;
  num? _otp;
Data copyWith({  String? id,
  List<OriginAddress>? originAddress,
  List<DestinationAddress>? destinationAddress,
  num? status,
  num? estimatedPrice,
  List<DriverDetails>? driverDetails,
  List<VehicleDetails>? vehicleDetails,
  num? otp,
}) => Data(  id: id ?? _id,
  originAddress: originAddress ?? _originAddress,
  destinationAddress: destinationAddress ?? _destinationAddress,
  status: status ?? _status,
  estimatedPrice: estimatedPrice ?? _estimatedPrice,
  driverDetails: driverDetails ?? _driverDetails,
  vehicleDetails: vehicleDetails ?? _vehicleDetails,
  otp: otp ?? _otp,
);
  String? get id => _id;
  List<OriginAddress>? get originAddress => _originAddress;
  List<DestinationAddress>? get destinationAddress => _destinationAddress;
  num? get status => _status;
  num? get estimatedPrice => _estimatedPrice;
  List<DriverDetails>? get driverDetails => _driverDetails;
  List<VehicleDetails>? get vehicleDetails => _vehicleDetails;
  num? get otp => _otp;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    if (_originAddress != null) {
      map['origin_address'] = _originAddress?.map((v) => v.toJson()).toList();
    }
    if (_destinationAddress != null) {
      map['destination_address'] = _destinationAddress?.map((v) => v.toJson()).toList();
    }
    map['status'] = _status;
    map['estimated_price'] = _estimatedPrice;
    if (_driverDetails != null) {
      map['driver_details'] = _driverDetails?.map((v) => v.toJson()).toList();
    }
    if (_vehicleDetails != null) {
      map['vehicle_details'] = _vehicleDetails?.map((v) => v.toJson()).toList();
    }
    map['otp'] = _otp;
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
/// _id : "66827d124d8df0c05da6328d"

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
/// _id : "66827d124d8df0c05da6328c"

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