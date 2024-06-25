import 'dart:convert';

/// location : {"lat":13.094478,"long":77.720049}
/// page : 1
/// limit : 10
/// user_id : "664c32d3402b694d6b333fe6"
/// service_category_id : "6646f17c6538869d3399af45"

RestaurantListingRequest restaurantListingRequestFromJson(String str) =>
    RestaurantListingRequest.fromJson(json.decode(str));

String restaurantListingRequestToJson(RestaurantListingRequest data) =>
    json.encode(data.toJson());

class RestaurantListingRequest {
  RestaurantListingRequest({
    Location? location,
    num? page,
    num? limit,
    String? userId,
    String? serviceCategoryId,
  }) {
    _location = location;
    _page = page;
    _limit = limit;
    _userId = userId;
    _serviceCategoryId = serviceCategoryId;
  }

  RestaurantListingRequest.fromJson(dynamic json) {
    _location =
        json['location'] != null ? Location.fromJson(json['location']) : null;
    _page = int.parse(json['page'].toString());
    _limit = int.parse(json['limit'].toString());
    _userId = json['user_id'].toString();
    _serviceCategoryId = json['service_category_id'].toString();
  }

  Location? _location;
  num? _page;
  num? _limit;
  String? _userId;
  String? _serviceCategoryId;

  RestaurantListingRequest copyWith({
    Location? location,
    num? page,
    num? limit,
    String? userId,
    String? serviceCategoryId,
  }) =>
      RestaurantListingRequest(
        location: location ?? _location,
        page: page ?? _page,
        limit: limit ?? _limit,
        userId: userId ?? _userId,
        serviceCategoryId: serviceCategoryId ?? _serviceCategoryId,
      );

  Location? get location => _location;

  num? get page => _page;

  num? get limit => _limit;

  String? get userId => _userId;

  String? get serviceCategoryId => _serviceCategoryId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_location != null) {
      map['location'] = _location?.toJson();
    }
    map['page'] = _page;
    map['limit'] = _limit;
    map['user_id'] = _userId;
    map['service_category_id'] = _serviceCategoryId;
    return map;
  }
}

/// lat : 13.094478
/// long : 77.720049

Location locationFromJson(String str) => Location.fromJson(json.decode(str));

String locationToJson(Location data) => json.encode(data.toJson());

class Location {
  Location({
    num? lat,
    num? long,
  }) {
    _lat = lat;
    _long = long;
  }

  Location.fromJson(dynamic json) {
    _lat = num.parse(json['lat'].toString());
    _long = num.parse(json['long'].toString());
  }

  num? _lat;
  num? _long;

  Location copyWith({
    num? lat,
    num? long,
  }) =>
      Location(
        lat: lat ?? _lat,
        long: long ?? _long,
      );

  num? get lat => _lat;

  num? get long => _long;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['lat'] = _lat;
    map['long'] = _long;
    return map;
  }
}
