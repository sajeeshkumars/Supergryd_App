import 'dart:convert';
/// store_id : 1
/// cart_id : 8929418426
/// device_id : "632325a54a669ec98b30ccf765977602"
/// address_data : [{"lat":12.9091,"lng":77.5242,"address":"Rajarajeshwari Nagar Bengaluru, Karnataka, 560098","door_flat_no":"369/3","landmark":""}]
/// user_data : [{"name":"Ritika Singh","contact_number":1234567890}]
/// user_id : "66826ba73ff1d692ff0ef51c"
/// provider_code : null
/// location : {"lat":12.9091,"lng":77.5242}
/// food_remark : "test"

CreateOrderRequest createOrderRequestFromJson(String str) => CreateOrderRequest.fromJson(json.decode(str));
String createOrderRequestToJson(CreateOrderRequest data) => json.encode(data.toJson());
class CreateOrderRequest {
  CreateOrderRequest({
      num? storeId, 
      num? cartId, 
      String? deviceId, 
      List<AddressData>? addressData, 
      List<UserData>? userData, 
      String? userId, 
      dynamic providerCode, 
      Location? location, 
      String? foodRemark,}){
    _storeId = storeId;
    _cartId = cartId;
    _deviceId = deviceId;
    _addressData = addressData;
    _userData = userData;
    _userId = userId;
    _providerCode = providerCode;
    _location = location;
    _foodRemark = foodRemark;
}

  CreateOrderRequest.fromJson(dynamic json) {
    _storeId = json['store_id'];
    _cartId = json['cart_id'];
    _deviceId = json['device_id'];
    if (json['address_data'] != null) {
      _addressData = [];
      json['address_data'].forEach((v) {
        _addressData?.add(AddressData.fromJson(v));
      });
    }
    if (json['user_data'] != null) {
      _userData = [];
      json['user_data'].forEach((v) {
        _userData?.add(UserData.fromJson(v));
      });
    }
    _userId = json['user_id'];
    _providerCode = json['provider_code'];
    _location = json['location'] != null ? Location.fromJson(json['location']) : null;
    _foodRemark = json['food_remark'];
  }
  num? _storeId;
  num? _cartId;
  String? _deviceId;
  List<AddressData>? _addressData;
  List<UserData>? _userData;
  String? _userId;
  dynamic _providerCode;
  Location? _location;
  String? _foodRemark;
CreateOrderRequest copyWith({  num? storeId,
  num? cartId,
  String? deviceId,
  List<AddressData>? addressData,
  List<UserData>? userData,
  String? userId,
  dynamic providerCode,
  Location? location,
  String? foodRemark,
}) => CreateOrderRequest(  storeId: storeId ?? _storeId,
  cartId: cartId ?? _cartId,
  deviceId: deviceId ?? _deviceId,
  addressData: addressData ?? _addressData,
  userData: userData ?? _userData,
  userId: userId ?? _userId,
  providerCode: providerCode ?? _providerCode,
  location: location ?? _location,
  foodRemark: foodRemark ?? _foodRemark,
);
  num? get storeId => _storeId;
  num? get cartId => _cartId;
  String? get deviceId => _deviceId;
  List<AddressData>? get addressData => _addressData;
  List<UserData>? get userData => _userData;
  String? get userId => _userId;
  dynamic get providerCode => _providerCode;
  Location? get location => _location;
  String? get foodRemark => _foodRemark;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['store_id'] = _storeId;
    map['cart_id'] = _cartId;
    map['device_id'] = _deviceId;
    if (_addressData != null) {
      map['address_data'] = _addressData?.map((v) => v.toJson()).toList();
    }
    if (_userData != null) {
      map['user_data'] = _userData?.map((v) => v.toJson()).toList();
    }
    map['user_id'] = _userId;
    map['provider_code'] = _providerCode;
    if (_location != null) {
      map['location'] = _location?.toJson();
    }
    map['food_remark'] = _foodRemark;
    return map;
  }

}

/// lat : 12.9091
/// lng : 77.5242

Location locationFromJson(String str) => Location.fromJson(json.decode(str));
String locationToJson(Location data) => json.encode(data.toJson());
class Location {
  Location({
      num? lat, 
      num? lng,}){
    _lat = lat;
    _lng = lng;
}

  Location.fromJson(dynamic json) {
    _lat = json['lat'];
    _lng = json['lng'];
  }
  num? _lat;
  num? _lng;
Location copyWith({  num? lat,
  num? lng,
}) => Location(  lat: lat ?? _lat,
  lng: lng ?? _lng,
);
  num? get lat => _lat;
  num? get lng => _lng;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['lat'] = _lat;
    map['lng'] = _lng;
    return map;
  }

}

/// name : "Ritika Singh"
/// contact_number : 1234567890

UserData userDataFromJson(String str) => UserData.fromJson(json.decode(str));
String userDataToJson(UserData data) => json.encode(data.toJson());
class UserData {
  UserData({
      String? name, 
      num? contactNumber,}){
    _name = name;
    _contactNumber = contactNumber;
}

  UserData.fromJson(dynamic json) {
    _name = json['name'];
    _contactNumber = json['contact_number'];
  }
  String? _name;
  num? _contactNumber;
UserData copyWith({  String? name,
  num? contactNumber,
}) => UserData(  name: name ?? _name,
  contactNumber: contactNumber ?? _contactNumber,
);
  String? get name => _name;
  num? get contactNumber => _contactNumber;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = _name;
    map['contact_number'] = _contactNumber;
    return map;
  }

}

/// lat : 12.9091
/// lng : 77.5242
/// address : "Rajarajeshwari Nagar Bengaluru, Karnataka, 560098"
/// door_flat_no : "369/3"
/// landmark : ""

AddressData addressDataFromJson(String str) => AddressData.fromJson(json.decode(str));
String addressDataToJson(AddressData data) => json.encode(data.toJson());
class AddressData {
  AddressData({
      num? lat, 
      num? lng, 
      String? address, 
      String? doorFlatNo, 
      String? landmark,}){
    _lat = lat;
    _lng = lng;
    _address = address;
    _doorFlatNo = doorFlatNo;
    _landmark = landmark;
}

  AddressData.fromJson(dynamic json) {
    _lat = json['lat'];
    _lng = json['lng'];
    _address = json['address'];
    _doorFlatNo = json['door_flat_no'];
    _landmark = json['landmark'];
  }
  num? _lat;
  num? _lng;
  String? _address;
  String? _doorFlatNo;
  String? _landmark;
AddressData copyWith({  num? lat,
  num? lng,
  String? address,
  String? doorFlatNo,
  String? landmark,
}) => AddressData(  lat: lat ?? _lat,
  lng: lng ?? _lng,
  address: address ?? _address,
  doorFlatNo: doorFlatNo ?? _doorFlatNo,
  landmark: landmark ?? _landmark,
);
  num? get lat => _lat;
  num? get lng => _lng;
  String? get address => _address;
  String? get doorFlatNo => _doorFlatNo;
  String? get landmark => _landmark;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['lat'] = _lat;
    map['lng'] = _lng;
    map['address'] = _address;
    map['door_flat_no'] = _doorFlatNo;
    map['landmark'] = _landmark;
    return map;
  }

}