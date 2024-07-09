import 'dart:convert';

/// request_id : "50"
/// status : "inprogress"
/// message : "Driver on the way to destination location"
/// code : "inprogress"
/// ride_status : 5
/// driver_lat : "10.055840"
/// driver_lng : "76.322294"
/// driver_details : {"phone_number":"14155551214","rating":4.1,"picture_url":"https://supergrydapi.ritikasingh.site/uploads/drivers/driver-2.png","name":"S Kumar","sms_number":"14155551214"}
/// vehicle : {"make":"BMW","picture_url":"https://supergrydapi.ritikasingh.site/uploads/vehicle/bmw.png","model":"7-series","license_plate":"KL-123 456"}
/// otp : "123456"

RideTrackResponse rideTrackResponseFromJson(String str) => RideTrackResponse.fromJson(json.decode(str));
String rideTrackResponseToJson(RideTrackResponse data) => json.encode(data.toJson());

class RideTrackResponse {
  RideTrackResponse({
    String? requestId,
    String? status,
    String? message,
    String? code,
    num? rideStatus,
    String? driverLat,
    String? driverLng,
    DriverDetails? driverDetails,
    Vehicle? vehicle,
    String? otp,
  }){
    _requestId = requestId;
    _status = status;
    _message = message;
    _code = code;
    _rideStatus = rideStatus;
    _driverLat = driverLat;
    _driverLng = driverLng;
    _driverDetails = driverDetails;
    _vehicle = vehicle;
    _otp = otp;
  }

  RideTrackResponse.fromJson(dynamic json) {
    _requestId = json['request_id'];
    _status = json['status'];
    _message = json['message'];
    _code = json['code'];
    _rideStatus = json['ride_status'];
    _driverLat = json['driver_lat'];
    _driverLng = json['driver_lng'];
    _driverDetails = json['driver_details'] != null ? DriverDetails.fromJson(json['driver_details']) : null;
    _vehicle = json['vehicle'] != null ? Vehicle.fromJson(json['vehicle']) : null;
    _otp = json['otp'].toString();
  }

  String? _requestId;
  String? _status;
  String? _message;
  String? _code;
  num? _rideStatus;
  String? _driverLat;
  String? _driverLng;
  DriverDetails? _driverDetails;
  Vehicle? _vehicle;
  String? _otp;

  RideTrackResponse copyWith({
    String? requestId,
    String? status,
    String? message,
    String? code,
    num? rideStatus,
    String? driverLat,
    String? driverLng,
    DriverDetails? driverDetails,
    Vehicle? vehicle,
    String? otp,
  }) => RideTrackResponse(
    requestId: requestId ?? _requestId,
    status: status ?? _status,
    message: message ?? _message,
    code: code ?? _code,
    rideStatus: rideStatus ?? _rideStatus,
    driverLat: driverLat ?? _driverLat,
    driverLng: driverLng ?? _driverLng,
    driverDetails: driverDetails ?? _driverDetails,
    vehicle: vehicle ?? _vehicle,
    otp: otp ?? _otp,
  );

  String? get requestId => _requestId;
  String? get status => _status;
  String? get message => _message;
  String? get code => _code;
  num? get rideStatus => _rideStatus;
  String? get driverLat => _driverLat;
  String? get driverLng => _driverLng;
  DriverDetails? get driverDetails => _driverDetails;
  Vehicle? get vehicle => _vehicle;
  String? get otp => _otp;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['request_id'] = _requestId;
    map['status'] = _status;
    map['message'] = _message;
    map['code'] = _code;
    map['ride_status'] = _rideStatus;
    map['driver_lat'] = _driverLat;
    map['driver_lng'] = _driverLng;
    if (_driverDetails != null) {
      map['driver_details'] = _driverDetails?.toJson();
    }
    if (_vehicle != null) {
      map['vehicle'] = _vehicle?.toJson();
    }
    map['otp'] = _otp;
    return map;
  }
}

/// make : "BMW"
/// picture_url : "https://supergrydapi.ritikasingh.site/uploads/vehicle/bmw.png"
/// model : "7-series"
/// license_plate : "KL-123 456"

Vehicle vehicleFromJson(String str) => Vehicle.fromJson(json.decode(str));
String vehicleToJson(Vehicle data) => json.encode(data.toJson());

class Vehicle {
  Vehicle({
    String? make,
    String? pictureUrl,
    String? model,
    String? licensePlate,
  }){
    _make = make;
    _pictureUrl = pictureUrl;
    _model = model;
    _licensePlate = licensePlate;
  }

  Vehicle.fromJson(dynamic json) {
    _make = json['make'];
    _pictureUrl = json['picture_url'];
    _model = json['model'];
    _licensePlate = json['license_plate'];
  }

  String? _make;
  String? _pictureUrl;
  String? _model;
  String? _licensePlate;

  Vehicle copyWith({
    String? make,
    String? pictureUrl,
    String? model,
    String? licensePlate,
  }) => Vehicle(
    make: make ?? _make,
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
    String? smsNumber,
  }){
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

  DriverDetails copyWith({
    String? phoneNumber,
    num? rating,
    String? pictureUrl,
    String? name,
    String? smsNumber,
  }) => DriverDetails(
    phoneNumber: phoneNumber ?? _phoneNumber,
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
