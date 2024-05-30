import 'dart:convert';
/// location : {"lat":13.094478,"long":77.720049}
/// user_id : "664dd2b2402b694d6bd0e6ab"
/// page : 1
/// limit : 10
/// service_category_id : "6646f17c6538869d3399af45"
/// filter : {"isVeg":null}

DishListingRequest dishListingRequestFromJson(String str) => DishListingRequest.fromJson(json.decode(str));
String dishListingRequestToJson(DishListingRequest data) => json.encode(data.toJson());
class DishListingRequest {
  DishListingRequest({
      Location? location, 
      String? userId, 
      num? page, 
      num? limit, 
      String? serviceCategoryId, 
      Filter? filter,}){
    _location = location;
    _userId = userId;
    _page = page;
    _limit = limit;
    _serviceCategoryId = serviceCategoryId;
    _filter = filter;
}

  DishListingRequest.fromJson(dynamic json) {
    _location = json['location'] != null ? Location.fromJson(json['location']) : null;
    _userId = json['user_id'];
    _page = json['page'];
    _limit = json['limit'];
    _serviceCategoryId = json['service_category_id'];
    _filter = json['filter'] != null ? Filter.fromJson(json['filter']) : null;
  }
  Location? _location;
  String? _userId;
  num? _page;
  num? _limit;
  String? _serviceCategoryId;
  Filter? _filter;
DishListingRequest copyWith({  Location? location,
  String? userId,
  num? page,
  num? limit,
  String? serviceCategoryId,
  Filter? filter,
}) => DishListingRequest(  location: location ?? _location,
  userId: userId ?? _userId,
  page: page ?? _page,
  limit: limit ?? _limit,
  serviceCategoryId: serviceCategoryId ?? _serviceCategoryId,
  filter: filter ?? _filter,
);
  Location? get location => _location;
  String? get userId => _userId;
  num? get page => _page;
  num? get limit => _limit;
  String? get serviceCategoryId => _serviceCategoryId;
  Filter? get filter => _filter;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_location != null) {
      map['location'] = _location?.toJson();
    }
    map['user_id'] = _userId;
    map['page'] = _page;
    map['limit'] = _limit;
    map['service_category_id'] = _serviceCategoryId;
    if (_filter != null) {
      map['filter'] = _filter?.toJson();
    }
    return map;
  }

}

/// isVeg : null

Filter filterFromJson(String str) => Filter.fromJson(json.decode(str));
String filterToJson(Filter data) => json.encode(data.toJson());
class Filter {
  Filter({
      dynamic isVeg,}){
    _isVeg = isVeg;
}

  Filter.fromJson(dynamic json) {
    _isVeg = json['isVeg'];
  }
  dynamic _isVeg;
Filter copyWith({  dynamic isVeg,
}) => Filter(  isVeg: isVeg ?? _isVeg,
);
  dynamic get isVeg => _isVeg;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['isVeg'] = _isVeg;
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
      num? long,}){
    _lat = lat;
    _long = long;
}

  Location.fromJson(dynamic json) {
    _lat = json['lat'];
    _long = json['long'];
  }
  num? _lat;
  num? _long;
Location copyWith({  num? lat,
  num? long,
}) => Location(  lat: lat ?? _lat,
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