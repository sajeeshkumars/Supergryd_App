import 'dart:convert';

/// status : 200
/// message : "Success."
/// data : [{"_id":"666569ff8e0cfcd234f83469","name":"Normal","capacity":4,"display_name":"Normal","short_description":"Normal is the budget economy ride","description":"Normal is the budget economy ride","image":"https://supergryd-files.s3.ap-south-1.amazonaws.com/icon/normal.png?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIA2UC3DT7G2FZCZCWA%2F20240624%2Fap-south-1%2Fs3%2Faws4_request&X-Amz-Date=20240624T093918Z&X-Amz-Expires=5000&X-Amz-Signature=08a8f32146e4f0da295bebc6f8f65f7a0bfad38ef3b02f36f66c9aa349cc68bc&X-Amz-SignedHeaders=host","mapping_products":[{"service_provider":"6646f2196538869d3399af46","product_id":"uber-go-a1111c8c-c720-46c3-8534-2fcdd730040d","product_name":"Uber Go"}],"estimation":{"localized_display_name":"Uber Go","display_name":"Uber Go","product_id":"uber-go-a1111c8c-c720-46c3-8534-2fcdd730040d","distance":3.37,"high_estimate":null,"low_estimate":null,"duration":202,"fare_id":332,"estimate":151.24,"currency_code":"INR"}},{"_id":"66656ddf8e0cfcd234f8346a","name":"Economy","capacity":4,"display_name":"Economy","short_description":"Economy is the budget economy ride","description":"Economy is the budget economy ride","image":"https://supergryd-files.s3.ap-south-1.amazonaws.com/icon/economy.png?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIA2UC3DT7G2FZCZCWA%2F20240624%2Fap-south-1%2Fs3%2Faws4_request&X-Amz-Date=20240624T093918Z&X-Amz-Expires=5000&X-Amz-Signature=563b18d589c9e196bd8a91ba4023a00f32e0b1dc928b045c5f5fb6ce19453467&X-Amz-SignedHeaders=host","mapping_products":[{"service_provider":"6646f2196538869d3399af46","product_id":"go-seden-8920cb5e-51a4-4fa4-acdf-dd86c5e18ae0","product_name":"Uber sedan"}],"estimation":{"localized_display_name":"Go Sedan","display_name":"Go Sedan","product_id":"go-seden-8920cb5e-51a4-4fa4-acdf-dd86c5e18ae0","distance":3.37,"high_estimate":null,"low_estimate":null,"duration":202,"fare_id":333,"estimate":162.99,"currency_code":"INR"}},{"_id":"66656e648e0cfcd234f8346b","name":"Comfort","capacity":4,"display_name":"Comfort","short_description":"Comfort is the Confort ride","description":"Comfort is the Confort ride","image":"https://supergryd-files.s3.ap-south-1.amazonaws.com/icon/comfort.png?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIA2UC3DT7G2FZCZCWA%2F20240624%2Fap-south-1%2Fs3%2Faws4_request&X-Amz-Date=20240624T093918Z&X-Amz-Expires=5000&X-Amz-Signature=5602adc7e004c0fb7ac2ae1d0c7f1cecbcaadc02a7a928c1e75e01310b4edb6e&X-Amz-SignedHeaders=host","mapping_products":[{"service_provider":"6646f2196538869d3399af46","product_id":"premier-8920cb5e-51a4-4fa4-acdf-dd86c5e18ae","product_name":"Uber XX"}],"estimation":{"localized_display_name":"Premier","display_name":"Premier","product_id":"premier-8920cb5e-51a4-4fa4-acdf-dd86c5e18ae","distance":3.37,"high_estimate":null,"low_estimate":null,"duration":202,"fare_id":335,"estimate":174.73,"currency_code":"INR"}}]

RideEstimationResponse rideEstimationResponseFromJson(String str) =>
    RideEstimationResponse.fromJson(json.decode(str));
String rideEstimationResponseToJson(RideEstimationResponse data) =>
    json.encode(data.toJson());

class RideEstimationResponse {
  RideEstimationResponse({
    int? status,
    String? message,
    List<RideEstimationList>? data,
  }) {
    _status = status;
    _message = message;
    _data = data;
  }

  RideEstimationResponse.fromJson(dynamic json) {
    _status = int.tryParse(json['status'].toString());
    _message = json['message'].toString();
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(RideEstimationList.fromJson(v));
      });
    }
  }
  int? _status;
  String? _message;
  List<RideEstimationList>? _data;
  RideEstimationResponse copyWith({
    int? status,
    String? message,
    List<RideEstimationList>? data,
  }) =>
      RideEstimationResponse(
        status: status ?? _status,
        message: message ?? _message,
        data: data ?? _data,
      );
  int? get status => _status;
  String? get message => _message;
  List<RideEstimationList>? get data => _data;

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

/// _id : "666569ff8e0cfcd234f83469"
/// name : "Normal"
/// capacity : 4
/// display_name : "Normal"
/// short_description : "Normal is the budget economy ride"
/// description : "Normal is the budget economy ride"
/// image : "https://supergryd-files.s3.ap-south-1.amazonaws.com/icon/normal.png?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIA2UC3DT7G2FZCZCWA%2F20240624%2Fap-south-1%2Fs3%2Faws4_request&X-Amz-Date=20240624T093918Z&X-Amz-Expires=5000&X-Amz-Signature=08a8f32146e4f0da295bebc6f8f65f7a0bfad38ef3b02f36f66c9aa349cc68bc&X-Amz-SignedHeaders=host"
/// mapping_products : [{"service_provider":"6646f2196538869d3399af46","product_id":"uber-go-a1111c8c-c720-46c3-8534-2fcdd730040d","product_name":"Uber Go"}]
/// estimation : {"localized_display_name":"Uber Go","display_name":"Uber Go","product_id":"uber-go-a1111c8c-c720-46c3-8534-2fcdd730040d","distance":3.37,"high_estimate":null,"low_estimate":null,"duration":202,"fare_id":332,"estimate":151.24,"currency_code":"INR"}

RideEstimationList dataFromJson(String str) =>
    RideEstimationList.fromJson(json.decode(str));
String dataToJson(RideEstimationList data) => json.encode(data.toJson());

class RideEstimationList {
  RideEstimationList({
    String? id,
    String? name,
    num? capacity,
    String? displayName,
    String? shortDescription,
    String? description,
    String? image,
    List<MappingProducts>? mappingProducts,
    Estimation? estimation,
  }) {
    _id = id;
    _name = name;
    _capacity = capacity;
    _displayName = displayName;
    _shortDescription = shortDescription;
    _description = description;
    _image = image;
    _mappingProducts = mappingProducts;
    _estimation = estimation;
  }

  RideEstimationList.fromJson(dynamic json) {
    _id = json['_id'].toString();
    _name = json['name'].toString();
    _capacity = num.parse(json['capacity'].toString());
    _displayName = json['display_name'].toString();
    _shortDescription = json['short_description'].toString();
    _description = json['description'].toString();
    _image = json['image'].toString();
    if (json['mapping_products'] != null) {
      _mappingProducts = [];
      json['mapping_products'].forEach((v) {
        _mappingProducts?.add(MappingProducts.fromJson(v));
      });
    }
    _estimation = json['estimation'] != null
        ? Estimation.fromJson(json['estimation'])
        : null;
  }
  String? _id;
  String? _name;
  num? _capacity;
  String? _displayName;
  String? _shortDescription;
  String? _description;
  String? _image;
  List<MappingProducts>? _mappingProducts;
  Estimation? _estimation;
  RideEstimationList copyWith({
    String? id,
    String? name,
    num? capacity,
    String? displayName,
    String? shortDescription,
    String? description,
    String? image,
    List<MappingProducts>? mappingProducts,
    Estimation? estimation,
  }) =>
      RideEstimationList(
        id: id ?? _id,
        name: name ?? _name,
        capacity: capacity ?? _capacity,
        displayName: displayName ?? _displayName,
        shortDescription: shortDescription ?? _shortDescription,
        description: description ?? _description,
        image: image ?? _image,
        mappingProducts: mappingProducts ?? _mappingProducts,
        estimation: estimation ?? _estimation,
      );
  String? get id => _id;
  String? get name => _name;
  num? get capacity => _capacity;
  String? get displayName => _displayName;
  String? get shortDescription => _shortDescription;
  String? get description => _description;
  String? get image => _image;
  List<MappingProducts>? get mappingProducts => _mappingProducts;
  Estimation? get estimation => _estimation;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['name'] = _name;
    map['capacity'] = _capacity;
    map['display_name'] = _displayName;
    map['short_description'] = _shortDescription;
    map['description'] = _description;
    map['image'] = _image;
    if (_mappingProducts != null) {
      map['mapping_products'] =
          _mappingProducts?.map((v) => v.toJson()).toList();
    }
    if (_estimation != null) {
      map['estimation'] = _estimation?.toJson();
    }
    return map;
  }
}

/// localized_display_name : "Uber Go"
/// display_name : "Uber Go"
/// product_id : "uber-go-a1111c8c-c720-46c3-8534-2fcdd730040d"
/// distance : 3.37
/// high_estimate : null
/// low_estimate : null
/// duration : 202
/// fare_id : 332
/// estimate : 151.24
/// currency_code : "INR"

Estimation estimationFromJson(String str) =>
    Estimation.fromJson(json.decode(str));
String estimationToJson(Estimation data) => json.encode(data.toJson());

class Estimation {
  Estimation({
    String? localizedDisplayName,
    String? displayName,
    String? productId,
    num? distance,
    dynamic highEstimate,
    dynamic lowEstimate,
    num? duration,
    num? fareId,
    num? estimate,
    String? currencyCode,
  }) {
    _localizedDisplayName = localizedDisplayName;
    _displayName = displayName;
    _productId = productId;
    _distance = distance;
    _highEstimate = highEstimate;
    _lowEstimate = lowEstimate;
    _duration = duration;
    _fareId = fareId;
    _estimate = estimate;
    _currencyCode = currencyCode;
  }

  Estimation.fromJson(dynamic json) {
    _localizedDisplayName = json['localized_display_name'].toString();
    _displayName = json['display_name'].toString();
    _productId = json['product_id'].toString();
    _distance = num.parse(json['distance'].toString());
    _highEstimate = json['high_estimate'];
    _lowEstimate = json['low_estimate'];
    _duration = num.parse(json['duration'].toString());
    _fareId = num.parse(json['fare_id'].toString());
    _estimate = num.parse(json['estimate'].toString());
    _currencyCode = json['currency_code'].toString();
  }
  String? _localizedDisplayName;
  String? _displayName;
  String? _productId;
  num? _distance;
  dynamic _highEstimate;
  dynamic _lowEstimate;
  num? _duration;
  num? _fareId;
  num? _estimate;
  String? _currencyCode;
  Estimation copyWith({
    String? localizedDisplayName,
    String? displayName,
    String? productId,
    num? distance,
    dynamic highEstimate,
    dynamic lowEstimate,
    num? duration,
    num? fareId,
    num? estimate,
    String? currencyCode,
  }) =>
      Estimation(
        localizedDisplayName: localizedDisplayName ?? _localizedDisplayName,
        displayName: displayName ?? _displayName,
        productId: productId ?? _productId,
        distance: distance ?? _distance,
        highEstimate: highEstimate ?? _highEstimate,
        lowEstimate: lowEstimate ?? _lowEstimate,
        duration: duration ?? _duration,
        fareId: fareId ?? _fareId,
        estimate: estimate ?? _estimate,
        currencyCode: currencyCode ?? _currencyCode,
      );
  String? get localizedDisplayName => _localizedDisplayName;
  String? get displayName => _displayName;
  String? get productId => _productId;
  num? get distance => _distance;
  dynamic get highEstimate => _highEstimate;
  dynamic get lowEstimate => _lowEstimate;
  num? get duration => _duration;
  num? get fareId => _fareId;
  num? get estimate => _estimate;
  String? get currencyCode => _currencyCode;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['localized_display_name'] = _localizedDisplayName;
    map['display_name'] = _displayName;
    map['product_id'] = _productId;
    map['distance'] = _distance;
    map['high_estimate'] = _highEstimate;
    map['low_estimate'] = _lowEstimate;
    map['duration'] = _duration;
    map['fare_id'] = _fareId;
    map['estimate'] = _estimate;
    map['currency_code'] = _currencyCode;
    return map;
  }
}

/// service_provider : "6646f2196538869d3399af46"
/// product_id : "uber-go-a1111c8c-c720-46c3-8534-2fcdd730040d"
/// product_name : "Uber Go"

MappingProducts mappingProductsFromJson(String str) =>
    MappingProducts.fromJson(json.decode(str));
String mappingProductsToJson(MappingProducts data) =>
    json.encode(data.toJson());

class MappingProducts {
  MappingProducts({
    String? serviceProvider,
    String? productId,
    String? productName,
  }) {
    _serviceProvider = serviceProvider;
    _productId = productId;
    _productName = productName;
  }

  MappingProducts.fromJson(dynamic json) {
    _serviceProvider = json['service_provider'].toString();
    _productId = json['product_id'].toString();
    _productName = json['product_name'].toString();
  }
  String? _serviceProvider;
  String? _productId;
  String? _productName;
  MappingProducts copyWith({
    String? serviceProvider,
    String? productId,
    String? productName,
  }) =>
      MappingProducts(
        serviceProvider: serviceProvider ?? _serviceProvider,
        productId: productId ?? _productId,
        productName: productName ?? _productName,
      );
  String? get serviceProvider => _serviceProvider;
  String? get productId => _productId;
  String? get productName => _productName;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['service_provider'] = _serviceProvider;
    map['product_id'] = _productId;
    map['product_name'] = _productName;
    return map;
  }
}
