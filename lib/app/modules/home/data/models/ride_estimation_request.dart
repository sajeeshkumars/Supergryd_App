import 'dart:convert';
/// start_location : {"lat":"12.9147399","long":"77.5972174"}
/// end_location : {"lat":"12.90","long":"77.57"}

RideEstimationRequest rideEstimationRequestFromJson(String str) => RideEstimationRequest.fromJson(json.decode(str));
String rideEstimationRequestToJson(RideEstimationRequest data) => json.encode(data.toJson());
class RideEstimationRequest {
  RideEstimationRequest({
      StartLocation? startLocation, 
      EndLocation? endLocation,}){
    _startLocation = startLocation;
    _endLocation = endLocation;
}

  RideEstimationRequest.fromJson(dynamic json) {
    _startLocation = json['start_location'] != null ? StartLocation.fromJson(json['start_location']) : null;
    _endLocation = json['end_location'] != null ? EndLocation.fromJson(json['end_location']) : null;
  }
  StartLocation? _startLocation;
  EndLocation? _endLocation;
RideEstimationRequest copyWith({  StartLocation? startLocation,
  EndLocation? endLocation,
}) => RideEstimationRequest(  startLocation: startLocation ?? _startLocation,
  endLocation: endLocation ?? _endLocation,
);
  StartLocation? get startLocation => _startLocation;
  EndLocation? get endLocation => _endLocation;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_startLocation != null) {
      map['start_location'] = _startLocation?.toJson();
    }
    if (_endLocation != null) {
      map['end_location'] = _endLocation?.toJson();
    }
    return map;
  }

}

/// lat : "12.90"
/// long : "77.57"

EndLocation endLocationFromJson(String str) => EndLocation.fromJson(json.decode(str));
String endLocationToJson(EndLocation data) => json.encode(data.toJson());
class EndLocation {
  EndLocation({
      String? lat, 
      String? long,}){
    _lat = lat;
    _long = long;
}

  EndLocation.fromJson(dynamic json) {
    _lat = json['lat'].toString();
    _long = json['long'].toString();
  }
  String? _lat;
  String? _long;
EndLocation copyWith({  String? lat,
  String? long,
}) => EndLocation(  lat: lat ?? _lat,
  long: long ?? _long,
);
  String? get lat => _lat;
  String? get long => _long;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['lat'] = _lat;
    map['long'] = _long;
    return map;
  }

}

/// lat : "12.9147399"
/// long : "77.5972174"

StartLocation startLocationFromJson(String str) => StartLocation.fromJson(json.decode(str));
String startLocationToJson(StartLocation data) => json.encode(data.toJson());
class StartLocation {
  StartLocation({
      String? lat, 
      String? long,}){
    _lat = lat;
    _long = long;
}

  StartLocation.fromJson(dynamic json) {
    _lat = json['lat'].toString();
    _long = json['long'].toString();
  }
  String? _lat;
  String? _long;
StartLocation copyWith({  String? lat,
  String? long,
}) => StartLocation(  lat: lat ?? _lat,
  long: long ?? _long,
);
  String? get lat => _lat;
  String? get long => _long;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['lat'] = _lat;
    map['long'] = _long;
    return map;
  }

}