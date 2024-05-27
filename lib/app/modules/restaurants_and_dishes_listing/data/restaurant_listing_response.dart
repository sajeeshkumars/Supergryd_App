import 'dart:convert';
/// status : 200
/// message : "Data retrieve successfully."
/// data : {"totalCount":3,"restaurantData":[{"_id":"6641acefe25729974b4268a0","store_id":6,"branch_name":"KrPuram","created":"2024-05-22T10:40:00.815Z","location":{"type":"Point","coordinates":[77.7044,13.017]},"more_branch_details":[{"city_name":"Bengaluru","landmark":"KrPuram","locality_name":"KrPuram","society_name":"KrPuram","parent_store_id":111,"onTime":"11:00:00","offTime":"23:00:00","store_code":"PST641121155"}],"status":false,"store_address":"Rajarajeshwari Nagar","updated":"2024-05-22T10:40:00.815Z","offers":[{"offer":""}],"is_available":1,"images":[{"image":"https://supergrydapi.ritikasingh.site/uploads/category/3ccdc3fc-c5f7-47fd-b415-f2ee35160363.jpeg","description":"Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scramble"}],"rating":3,"total_rating":23,"distanceInKilometer":8.790125931241016},{"_id":"6641acefe25729974b426877","store_id":5,"branch_name":"BLR Airport","created":"2024-05-22T10:40:00.833Z","location":{"type":"Point","coordinates":[77.7069,13.1989]},"more_branch_details":[{"city_name":"Bengaluru","landmark":"BLR Airport","locality_name":"BLR Airport","society_name":"BLR Airport","parent_store_id":111,"onTime":"11:00:00","offTime":"23:00:00","store_code":"PST641121155"}],"status":false,"store_address":"Rajarajeshwari Nagar","updated":"2024-05-22T10:40:00.833Z","offers":[{"offer":"30 % off."}],"is_available":1,"images":[{"image":"https://supergrydapi.ritikasingh.site/uploads/category/3ccdc3fc-c5f7-47fd-b415-f2ee35160363.jpeg","description":"Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scramble"}],"rating":5,"total_rating":20,"distanceInKilometer":11.711200728895957}]}

RestaurantListingResponse restaurantListingResponseFromJson(String str) => RestaurantListingResponse.fromJson(json.decode(str));
String restaurantListingResponseToJson(RestaurantListingResponse data) => json.encode(data.toJson());
class RestaurantListingResponse {
  RestaurantListingResponse({
      num? status, 
      String? message, 
      RestaurantListingResult? data,}){
    _status = status;
    _message = message;
    _data = data;
}

  RestaurantListingResponse.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    _data = json['data'] != null ? RestaurantListingResult.fromJson(json['data']) : null;
  }
  num? _status;
  String? _message;
  RestaurantListingResult? _data;
RestaurantListingResponse copyWith({  num? status,
  String? message,
  RestaurantListingResult? data,
}) => RestaurantListingResponse(  status: status ?? _status,
  message: message ?? _message,
  data: data ?? _data,
);
  num? get status => _status;
  String? get message => _message;
  RestaurantListingResult? get data => _data;

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

/// totalCount : 3
/// restaurantData : [{"_id":"6641acefe25729974b4268a0","store_id":6,"branch_name":"KrPuram","created":"2024-05-22T10:40:00.815Z","location":{"type":"Point","coordinates":[77.7044,13.017]},"more_branch_details":[{"city_name":"Bengaluru","landmark":"KrPuram","locality_name":"KrPuram","society_name":"KrPuram","parent_store_id":111,"onTime":"11:00:00","offTime":"23:00:00","store_code":"PST641121155"}],"status":false,"store_address":"Rajarajeshwari Nagar","updated":"2024-05-22T10:40:00.815Z","offers":[{"offer":""}],"is_available":1,"images":[{"image":"https://supergrydapi.ritikasingh.site/uploads/category/3ccdc3fc-c5f7-47fd-b415-f2ee35160363.jpeg","description":"Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scramble"}],"rating":3,"total_rating":23,"distanceInKilometer":8.790125931241016},{"_id":"6641acefe25729974b426877","store_id":5,"branch_name":"BLR Airport","created":"2024-05-22T10:40:00.833Z","location":{"type":"Point","coordinates":[77.7069,13.1989]},"more_branch_details":[{"city_name":"Bengaluru","landmark":"BLR Airport","locality_name":"BLR Airport","society_name":"BLR Airport","parent_store_id":111,"onTime":"11:00:00","offTime":"23:00:00","store_code":"PST641121155"}],"status":false,"store_address":"Rajarajeshwari Nagar","updated":"2024-05-22T10:40:00.833Z","offers":[{"offer":"30 % off."}],"is_available":1,"images":[{"image":"https://supergrydapi.ritikasingh.site/uploads/category/3ccdc3fc-c5f7-47fd-b415-f2ee35160363.jpeg","description":"Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scramble"}],"rating":5,"total_rating":20,"distanceInKilometer":11.711200728895957}]

RestaurantListingResult dataFromJson(String str) => RestaurantListingResult.fromJson(json.decode(str));
String dataToJson(RestaurantListingResult data) => json.encode(data.toJson());
class RestaurantListingResult {
  RestaurantListingResult({
      num? totalCount, 
      List<RestaurantData>? restaurantData,}){
    _totalCount = totalCount;
    _restaurantData = restaurantData;
}

  RestaurantListingResult.fromJson(dynamic json) {
    _totalCount = json['totalCount'];
    if (json['restaurantData'] != null) {
      _restaurantData = [];
      json['restaurantData'].forEach((v) {
        _restaurantData?.add(RestaurantData.fromJson(v));
      });
    }
  }
  num? _totalCount;
  List<RestaurantData>? _restaurantData;
RestaurantListingResult copyWith({  num? totalCount,
  List<RestaurantData>? restaurantData,
}) => RestaurantListingResult(  totalCount: totalCount ?? _totalCount,
  restaurantData: restaurantData ?? _restaurantData,
);
  num? get totalCount => _totalCount;
  List<RestaurantData>? get restaurantData => _restaurantData;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['totalCount'] = _totalCount;
    if (_restaurantData != null) {
      map['restaurantData'] = _restaurantData?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// _id : "6641acefe25729974b4268a0"
/// store_id : 6
/// branch_name : "KrPuram"
/// created : "2024-05-22T10:40:00.815Z"
/// location : {"type":"Point","coordinates":[77.7044,13.017]}
/// more_branch_details : [{"city_name":"Bengaluru","landmark":"KrPuram","locality_name":"KrPuram","society_name":"KrPuram","parent_store_id":111,"onTime":"11:00:00","offTime":"23:00:00","store_code":"PST641121155"}]
/// status : false
/// store_address : "Rajarajeshwari Nagar"
/// updated : "2024-05-22T10:40:00.815Z"
/// offers : [{"offer":""}]
/// is_available : 1
/// images : [{"image":"https://supergrydapi.ritikasingh.site/uploads/category/3ccdc3fc-c5f7-47fd-b415-f2ee35160363.jpeg","description":"Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scramble"}]
/// rating : 3
/// total_rating : 23
/// distanceInKilometer : 8.790125931241016

RestaurantData restaurantDataFromJson(String str) => RestaurantData.fromJson(json.decode(str));
String restaurantDataToJson(RestaurantData data) => json.encode(data.toJson());
class RestaurantData {
  RestaurantData({
      String? id, 
      num? storeId, 
      String? branchName, 
      String? created, 
      Location? location, 
      List<MoreBranchDetails>? moreBranchDetails, 
      bool? status, 
      String? storeAddress, 
      String? updated, 
      List<Offers>? offers, 
      num? isAvailable, 
      List<Images>? images, 
      num? rating, 
      num? totalRating, 
      num? distanceInKilometer,}){
    _id = id;
    _storeId = storeId;
    _branchName = branchName;
    _created = created;
    _location = location;
    _moreBranchDetails = moreBranchDetails;
    _status = status;
    _storeAddress = storeAddress;
    _updated = updated;
    _offers = offers;
    _isAvailable = isAvailable;
    _images = images;
    _rating = rating;
    _totalRating = totalRating;
    _distanceInKilometer = distanceInKilometer;
}

  RestaurantData.fromJson(dynamic json) {
    _id = json['_id'];
    _storeId = json['store_id'];
    _branchName = json['branch_name'];
    _created = json['created'];
    _location = json['location'] != null ? Location.fromJson(json['location']) : null;
    if (json['more_branch_details'] != null) {
      _moreBranchDetails = [];
      json['more_branch_details'].forEach((v) {
        _moreBranchDetails?.add(MoreBranchDetails.fromJson(v));
      });
    }
    _status = json['status'];
    _storeAddress = json['store_address'];
    _updated = json['updated'];
    if (json['offers'] != null) {
      _offers = [];
      json['offers'].forEach((v) {
        _offers?.add(Offers.fromJson(v));
      });
    }
    _isAvailable = json['is_available'];
    if (json['images'] != null) {
      _images = [];
      json['images'].forEach((v) {
        _images?.add(Images.fromJson(v));
      });
    }
    _rating = json['rating'];
    _totalRating = json['total_rating'];
    _distanceInKilometer = json['distanceInKilometer'];
  }
  String? _id;
  num? _storeId;
  String? _branchName;
  String? _created;
  Location? _location;
  List<MoreBranchDetails>? _moreBranchDetails;
  bool? _status;
  String? _storeAddress;
  String? _updated;
  List<Offers>? _offers;
  num? _isAvailable;
  List<Images>? _images;
  num? _rating;
  num? _totalRating;
  num? _distanceInKilometer;
RestaurantData copyWith({  String? id,
  num? storeId,
  String? branchName,
  String? created,
  Location? location,
  List<MoreBranchDetails>? moreBranchDetails,
  bool? status,
  String? storeAddress,
  String? updated,
  List<Offers>? offers,
  num? isAvailable,
  List<Images>? images,
  num? rating,
  num? totalRating,
  num? distanceInKilometer,
}) => RestaurantData(  id: id ?? _id,
  storeId: storeId ?? _storeId,
  branchName: branchName ?? _branchName,
  created: created ?? _created,
  location: location ?? _location,
  moreBranchDetails: moreBranchDetails ?? _moreBranchDetails,
  status: status ?? _status,
  storeAddress: storeAddress ?? _storeAddress,
  updated: updated ?? _updated,
  offers: offers ?? _offers,
  isAvailable: isAvailable ?? _isAvailable,
  images: images ?? _images,
  rating: rating ?? _rating,
  totalRating: totalRating ?? _totalRating,
  distanceInKilometer: distanceInKilometer ?? _distanceInKilometer,
);
  String? get id => _id;
  num? get storeId => _storeId;
  String? get branchName => _branchName;
  String? get created => _created;
  Location? get location => _location;
  List<MoreBranchDetails>? get moreBranchDetails => _moreBranchDetails;
  bool? get status => _status;
  String? get storeAddress => _storeAddress;
  String? get updated => _updated;
  List<Offers>? get offers => _offers;
  num? get isAvailable => _isAvailable;
  List<Images>? get images => _images;
  num? get rating => _rating;
  num? get totalRating => _totalRating;
  num? get distanceInKilometer => _distanceInKilometer;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['store_id'] = _storeId;
    map['branch_name'] = _branchName;
    map['created'] = _created;
    if (_location != null) {
      map['location'] = _location?.toJson();
    }
    if (_moreBranchDetails != null) {
      map['more_branch_details'] = _moreBranchDetails?.map((v) => v.toJson()).toList();
    }
    map['status'] = _status;
    map['store_address'] = _storeAddress;
    map['updated'] = _updated;
    if (_offers != null) {
      map['offers'] = _offers?.map((v) => v.toJson()).toList();
    }
    map['is_available'] = _isAvailable;
    if (_images != null) {
      map['images'] = _images?.map((v) => v.toJson()).toList();
    }
    map['rating'] = _rating;
    map['total_rating'] = _totalRating;
    map['distanceInKilometer'] = _distanceInKilometer;
    return map;
  }

}

/// image : "https://supergrydapi.ritikasingh.site/uploads/category/3ccdc3fc-c5f7-47fd-b415-f2ee35160363.jpeg"
/// description : "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scramble"

Images imagesFromJson(String str) => Images.fromJson(json.decode(str));
String imagesToJson(Images data) => json.encode(data.toJson());
class Images {
  Images({
      String? image, 
      String? description,}){
    _image = image;
    _description = description;
}

  Images.fromJson(dynamic json) {
    _image = json['image'];
    _description = json['description'];
  }
  String? _image;
  String? _description;
Images copyWith({  String? image,
  String? description,
}) => Images(  image: image ?? _image,
  description: description ?? _description,
);
  String? get image => _image;
  String? get description => _description;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['image'] = _image;
    map['description'] = _description;
    return map;
  }

}

/// offer : ""

Offers offersFromJson(String str) => Offers.fromJson(json.decode(str));
String offersToJson(Offers data) => json.encode(data.toJson());
class Offers {
  Offers({
      String? offer,}){
    _offer = offer;
}

  Offers.fromJson(dynamic json) {
    _offer = json['offer'];
  }
  String? _offer;
Offers copyWith({  String? offer,
}) => Offers(  offer: offer ?? _offer,
);
  String? get offer => _offer;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['offer'] = _offer;
    return map;
  }

}

/// city_name : "Bengaluru"
/// landmark : "KrPuram"
/// locality_name : "KrPuram"
/// society_name : "KrPuram"
/// parent_store_id : 111
/// onTime : "11:00:00"
/// offTime : "23:00:00"
/// store_code : "PST641121155"

MoreBranchDetails moreBranchDetailsFromJson(String str) => MoreBranchDetails.fromJson(json.decode(str));
String moreBranchDetailsToJson(MoreBranchDetails data) => json.encode(data.toJson());
class MoreBranchDetails {
  MoreBranchDetails({
      String? cityName, 
      String? landmark, 
      String? localityName, 
      String? societyName, 
      num? parentStoreId, 
      String? onTime, 
      String? offTime, 
      String? storeCode,}){
    _cityName = cityName;
    _landmark = landmark;
    _localityName = localityName;
    _societyName = societyName;
    _parentStoreId = parentStoreId;
    _onTime = onTime;
    _offTime = offTime;
    _storeCode = storeCode;
}

  MoreBranchDetails.fromJson(dynamic json) {
    _cityName = json['city_name'];
    _landmark = json['landmark'];
    _localityName = json['locality_name'];
    _societyName = json['society_name'];
    _parentStoreId = json['parent_store_id'];
    _onTime = json['onTime'];
    _offTime = json['offTime'];
    _storeCode = json['store_code'];
  }
  String? _cityName;
  String? _landmark;
  String? _localityName;
  String? _societyName;
  num? _parentStoreId;
  String? _onTime;
  String? _offTime;
  String? _storeCode;
MoreBranchDetails copyWith({  String? cityName,
  String? landmark,
  String? localityName,
  String? societyName,
  num? parentStoreId,
  String? onTime,
  String? offTime,
  String? storeCode,
}) => MoreBranchDetails(  cityName: cityName ?? _cityName,
  landmark: landmark ?? _landmark,
  localityName: localityName ?? _localityName,
  societyName: societyName ?? _societyName,
  parentStoreId: parentStoreId ?? _parentStoreId,
  onTime: onTime ?? _onTime,
  offTime: offTime ?? _offTime,
  storeCode: storeCode ?? _storeCode,
);
  String? get cityName => _cityName;
  String? get landmark => _landmark;
  String? get localityName => _localityName;
  String? get societyName => _societyName;
  num? get parentStoreId => _parentStoreId;
  String? get onTime => _onTime;
  String? get offTime => _offTime;
  String? get storeCode => _storeCode;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['city_name'] = _cityName;
    map['landmark'] = _landmark;
    map['locality_name'] = _localityName;
    map['society_name'] = _societyName;
    map['parent_store_id'] = _parentStoreId;
    map['onTime'] = _onTime;
    map['offTime'] = _offTime;
    map['store_code'] = _storeCode;
    return map;
  }

}

/// type : "Point"
/// coordinates : [77.7044,13.017]

Location locationFromJson(String str) => Location.fromJson(json.decode(str));
String locationToJson(Location data) => json.encode(data.toJson());
class Location {
  Location({
      String? type, 
      List<num>? coordinates,}){
    _type = type;
    _coordinates = coordinates;
}

  Location.fromJson(dynamic json) {
    _type = json['type'];
    _coordinates = json['coordinates'] != null ? json['coordinates'].cast<num>() : [];
  }
  String? _type;
  List<num>? _coordinates;
Location copyWith({  String? type,
  List<num>? coordinates,
}) => Location(  type: type ?? _type,
  coordinates: coordinates ?? _coordinates,
);
  String? get type => _type;
  List<num>? get coordinates => _coordinates;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['type'] = _type;
    map['coordinates'] = _coordinates;
    return map;
  }

}