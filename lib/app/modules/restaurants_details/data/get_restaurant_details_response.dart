import 'dart:convert';

/// status : 200
/// message : "Data retrieve successfully."
/// data : {"restaurant":[{"_id":"6641ad10e25729974b4288a8","product_id":51,"description_big":"(Boneless, Served with 1 Gulab Jamun & Mint Raita) In this culinary jewel from Behrouz, Tender chicken pieces are marinated with exuberant bhuna spices that are freshly ground and dum pukht with aromatic rice.","description_small":"(Boneless, Served with 1 Gulab Jamun & Mint Raita) In this culinary jewel from Behrouz, Tender chicken pieces are marinated with exuberant bhuna spices that are freshly ground and dum pukht with aromatic rice.","images":{"product_imageUrl":"https://supergrydapi.ritikasingh.site/uploads/dish/WHTP0IVCRM.jpeg","image_small_size":"https://supergrydapi.ritikasingh.site/uploads/dish/WHTP0IVCRM.jpeg","image_mobile":"https://supergrydapi.ritikasingh.site/uploads/dish/WHTP0IVCRM.jpeg"},"is_active":1,"is_available":1,"name":"BLR Airport-Lazeez Bhuna Murgh Biryani (Dum Chicken Biryani - Serves 1)","price":"99.99","price_without_tax":"99.99","product_details":{"product_video_link":null,"count_of_rating":17295},"rating":4.4,"service_provider_id":"663c9cdaef610e62ce6f4add","service_provider_location_id":"6641acefe25729974b426877","product_category_id":"6641ad0e4689a408045dba5b","is_veg":2,"restaurantDetails":[{"_id":"663c9cdaef610e62ce6f4add","name":"Behrouz Biriyani","email":"info@bhrouzbiriyani.com","status":true,"is_deleted":false,"phone_number":"91989544063342","more_service_provider_details":[{}]}]},{"_id":"6642ed26671bdaae7b0acc5a","product_id":55,"description_big":"Minced chicken kebabs cooked into soft delicious meatballs served with Minty dip.","description_small":"Minced chicken kebabs cooked into soft delicious meatballs served with Minty dip.","images":{"product_imageUrl":"https://supergrydapi.ritikasingh.site/uploads/dish/PVHISEXG3VP6.jpeg","image_small_size":"https://supergrydapi.ritikasingh.site/uploads/dish/PVHISEXG3VP6.jpeg","image_mobile":"https://supergrydapi.ritikasingh.site/uploads/dish/PVHISEXG3VP6.jpeg"},"is_active":1,"is_available":1,"name":"BLR Airport-Murgh Kefta (Chicken Meatball Kebab)","price":"99.99","price_without_tax":"99.99","product_details":{"product_video_link":null,"count_of_rating":17295},"rating":4.4,"service_provider_id":"663c9cdaef610e62ce6f4add","service_provider_location_id":"6641acefe25729974b426877","product_category_id":"6641ad0e4689a408045dba5c","is_veg":2,"restaurantDetails":[{"_id":"663c9cdaef610e62ce6f4add","name":"Behrouz Biriyani","email":"info@bhrouzbiriyani.com","status":true,"is_deleted":false,"phone_number":"91989544063342","more_service_provider_details":[{}]}]}]}

GetRestaurantDetailsResponse getRestaurantDetailResponseFromJson(String str) =>
    GetRestaurantDetailsResponse.fromJson(json.decode(str));

String getRestaurantDetailResponseToJson(GetRestaurantDetailsResponse data) =>
    json.encode(data.toJson());

class GetRestaurantDetailsResponse {
  GetRestaurantDetailsResponse({
    num? status,
    String? message,
    Data? data,
  }) {
    _status = status;
    _message = message;
    _data = data;
  }

  GetRestaurantDetailsResponse.fromJson(dynamic json) {
    _status = int.parse(json['status'].toString());
    _message = json['message'].toString();
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  num? _status;
  String? _message;
  Data? _data;

  GetRestaurantDetailsResponse copyWith({
    num? status,
    String? message,
    Data? data,
  }) =>
      GetRestaurantDetailsResponse(
        status: status ?? _status,
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

/// restaurant : [{"_id":"6641ad10e25729974b4288a8","product_id":51,"description_big":"(Boneless, Served with 1 Gulab Jamun & Mint Raita) In this culinary jewel from Behrouz, Tender chicken pieces are marinated with exuberant bhuna spices that are freshly ground and dum pukht with aromatic rice.","description_small":"(Boneless, Served with 1 Gulab Jamun & Mint Raita) In this culinary jewel from Behrouz, Tender chicken pieces are marinated with exuberant bhuna spices that are freshly ground and dum pukht with aromatic rice.","images":{"product_imageUrl":"https://supergrydapi.ritikasingh.site/uploads/dish/WHTP0IVCRM.jpeg","image_small_size":"https://supergrydapi.ritikasingh.site/uploads/dish/WHTP0IVCRM.jpeg","image_mobile":"https://supergrydapi.ritikasingh.site/uploads/dish/WHTP0IVCRM.jpeg"},"is_active":1,"is_available":1,"name":"BLR Airport-Lazeez Bhuna Murgh Biryani (Dum Chicken Biryani - Serves 1)","price":"99.99","price_without_tax":"99.99","product_details":{"product_video_link":null,"count_of_rating":17295},"rating":4.4,"service_provider_id":"663c9cdaef610e62ce6f4add","service_provider_location_id":"6641acefe25729974b426877","product_category_id":"6641ad0e4689a408045dba5b","is_veg":2,"restaurantDetails":[{"_id":"663c9cdaef610e62ce6f4add","name":"Behrouz Biriyani","email":"info@bhrouzbiriyani.com","status":true,"is_deleted":false,"phone_number":"91989544063342","more_service_provider_details":[{}]}]},{"_id":"6642ed26671bdaae7b0acc5a","product_id":55,"description_big":"Minced chicken kebabs cooked into soft delicious meatballs served with Minty dip.","description_small":"Minced chicken kebabs cooked into soft delicious meatballs served with Minty dip.","images":{"product_imageUrl":"https://supergrydapi.ritikasingh.site/uploads/dish/PVHISEXG3VP6.jpeg","image_small_size":"https://supergrydapi.ritikasingh.site/uploads/dish/PVHISEXG3VP6.jpeg","image_mobile":"https://supergrydapi.ritikasingh.site/uploads/dish/PVHISEXG3VP6.jpeg"},"is_active":1,"is_available":1,"name":"BLR Airport-Murgh Kefta (Chicken Meatball Kebab)","price":"99.99","price_without_tax":"99.99","product_details":{"product_video_link":null,"count_of_rating":17295},"rating":4.4,"service_provider_id":"663c9cdaef610e62ce6f4add","service_provider_location_id":"6641acefe25729974b426877","product_category_id":"6641ad0e4689a408045dba5c","is_veg":2,"restaurantDetails":[{"_id":"663c9cdaef610e62ce6f4add","name":"Behrouz Biriyani","email":"info@bhrouzbiriyani.com","status":true,"is_deleted":false,"phone_number":"91989544063342","more_service_provider_details":[{}]}]}]

Data dataFromJson(String str) => Data.fromJson(json.decode(str));

String dataToJson(Data data) => json.encode(data.toJson());

class Data {
  Data({
    List<Restaurant>? restaurant,
  }) {
    _restaurant = restaurant;
  }

  Data.fromJson(dynamic json) {
    if (json['restaurant'] != null) {
      _restaurant = [];
      json['restaurant'].forEach((v) {
        _restaurant?.add(Restaurant.fromJson(v));
      });
    }
  }

  List<Restaurant>? _restaurant;

  Data copyWith({
    List<Restaurant>? restaurant,
  }) =>
      Data(
        restaurant: restaurant ?? _restaurant,
      );

  List<Restaurant>? get restaurant => _restaurant;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_restaurant != null) {
      map['restaurant'] = _restaurant?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// _id : "6641ad10e25729974b4288a8"
/// product_id : 51
/// description_big : "(Boneless, Served with 1 Gulab Jamun & Mint Raita) In this culinary jewel from Behrouz, Tender chicken pieces are marinated with exuberant bhuna spices that are freshly ground and dum pukht with aromatic rice."
/// description_small : "(Boneless, Served with 1 Gulab Jamun & Mint Raita) In this culinary jewel from Behrouz, Tender chicken pieces are marinated with exuberant bhuna spices that are freshly ground and dum pukht with aromatic rice."
/// images : {"product_imageUrl":"https://supergrydapi.ritikasingh.site/uploads/dish/WHTP0IVCRM.jpeg","image_small_size":"https://supergrydapi.ritikasingh.site/uploads/dish/WHTP0IVCRM.jpeg","image_mobile":"https://supergrydapi.ritikasingh.site/uploads/dish/WHTP0IVCRM.jpeg"}
/// is_active : 1
/// is_available : 1
/// name : "BLR Airport-Lazeez Bhuna Murgh Biryani (Dum Chicken Biryani - Serves 1)"
/// price : "99.99"
/// price_without_tax : "99.99"
/// product_details : {"product_video_link":null,"count_of_rating":17295}
/// rating : 4.4
/// service_provider_id : "663c9cdaef610e62ce6f4add"
/// service_provider_location_id : "6641acefe25729974b426877"
/// product_category_id : "6641ad0e4689a408045dba5b"
/// is_veg : 2
/// restaurantDetails : [{"_id":"663c9cdaef610e62ce6f4add","name":"Behrouz Biriyani","email":"info@bhrouzbiriyani.com","status":true,"is_deleted":false,"phone_number":"91989544063342","more_service_provider_details":[{}]}]

Restaurant restaurantFromJson(String str) =>
    Restaurant.fromJson(json.decode(str));

String restaurantToJson(Restaurant data) => json.encode(data.toJson());

class Restaurant {
  Restaurant({
    String? id,
    num? productId,
    String? descriptionBig,
    String? descriptionSmall,
    Images? images,
    num? isActive,
    num? isAvailable,
    String? name,
    String? price,
    String? priceWithoutTax,
    ProductDetails? productDetails,
    num? rating,
    String? serviceProviderId,
    String? serviceProviderLocationId,
    String? productCategoryId,
    num? isVeg,
    List<RestaurantDetails>? restaurantDetails,
  }) {
    _id = id;
    _productId = productId;
    _descriptionBig = descriptionBig;
    _descriptionSmall = descriptionSmall;
    _images = images;
    _isActive = isActive;
    _isAvailable = isAvailable;
    _name = name;
    _price = price;
    _priceWithoutTax = priceWithoutTax;
    _productDetails = productDetails;
    _rating = rating;
    _serviceProviderId = serviceProviderId;
    _serviceProviderLocationId = serviceProviderLocationId;
    _productCategoryId = productCategoryId;
    _isVeg = isVeg;
    _restaurantDetails = restaurantDetails;
  }

  Restaurant.fromJson(dynamic json) {
    _id = json['_id'].toString();
    _productId = int.parse(json['product_id'].toString());
    _descriptionBig = json['description_big'].toString();
    _descriptionSmall = json['description_small'].toString();
    _images = json['images'] != null ? Images.fromJson(json['images']) : null;
    _isActive = int.parse(json['is_active'].toString());
    _isAvailable = int.parse(json['is_available'].toString());
    _name = json['name'].toString();
    _price = json['price'].toString();
    _priceWithoutTax = json['price_without_tax'].toString();
    _productDetails = json['product_details'] != null
        ? ProductDetails.fromJson(json['product_details'])
        : null;
    _rating = double.parse(json['rating'].toString());
    _serviceProviderId = json['service_provider_id'].toString();
    _serviceProviderLocationId = json['service_provider_location_id'].toString();
    _productCategoryId = json['product_category_id'].toString();
    _isVeg = int.parse(json['is_veg'].toString());
    if (json['restaurantDetails'] != null) {
      _restaurantDetails = [];
      json['restaurantDetails'].forEach((v) {
        _restaurantDetails?.add(RestaurantDetails.fromJson(v));
      });
    }
  }

  String? _id;
  num? _productId;
  String? _descriptionBig;
  String? _descriptionSmall;
  Images? _images;
  num? _isActive;
  num? _isAvailable;
  String? _name;
  String? _price;
  String? _priceWithoutTax;
  ProductDetails? _productDetails;
  num? _rating;
  String? _serviceProviderId;
  String? _serviceProviderLocationId;
  String? _productCategoryId;
  num? _isVeg;
  List<RestaurantDetails>? _restaurantDetails;

  Restaurant copyWith({
    String? id,
    num? productId,
    String? descriptionBig,
    String? descriptionSmall,
    Images? images,
    num? isActive,
    num? isAvailable,
    String? name,
    String? price,
    String? priceWithoutTax,
    ProductDetails? productDetails,
    num? rating,
    String? serviceProviderId,
    String? serviceProviderLocationId,
    String? productCategoryId,
    num? isVeg,
    List<RestaurantDetails>? restaurantDetails,
  }) =>
      Restaurant(
        id: id ?? _id,
        productId: productId ?? _productId,
        descriptionBig: descriptionBig ?? _descriptionBig,
        descriptionSmall: descriptionSmall ?? _descriptionSmall,
        images: images ?? _images,
        isActive: isActive ?? _isActive,
        isAvailable: isAvailable ?? _isAvailable,
        name: name ?? _name,
        price: price ?? _price,
        priceWithoutTax: priceWithoutTax ?? _priceWithoutTax,
        productDetails: productDetails ?? _productDetails,
        rating: rating ?? _rating,
        serviceProviderId: serviceProviderId ?? _serviceProviderId,
        serviceProviderLocationId:
            serviceProviderLocationId ?? _serviceProviderLocationId,
        productCategoryId: productCategoryId ?? _productCategoryId,
        isVeg: isVeg ?? _isVeg,
        restaurantDetails: restaurantDetails ?? _restaurantDetails,
      );

  String? get id => _id;

  num? get productId => _productId;

  String? get descriptionBig => _descriptionBig;

  String? get descriptionSmall => _descriptionSmall;

  Images? get images => _images;

  num? get isActive => _isActive;

  num? get isAvailable => _isAvailable;

  String? get name => _name;

  String? get price => _price;

  String? get priceWithoutTax => _priceWithoutTax;

  ProductDetails? get productDetails => _productDetails;

  num? get rating => _rating;

  String? get serviceProviderId => _serviceProviderId;

  String? get serviceProviderLocationId => _serviceProviderLocationId;

  String? get productCategoryId => _productCategoryId;

  num? get isVeg => _isVeg;

  List<RestaurantDetails>? get restaurantDetails => _restaurantDetails;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['product_id'] = _productId;
    map['description_big'] = _descriptionBig;
    map['description_small'] = _descriptionSmall;
    if (_images != null) {
      map['images'] = _images?.toJson();
    }
    map['is_active'] = _isActive;
    map['is_available'] = _isAvailable;
    map['name'] = _name;
    map['price'] = _price;
    map['price_without_tax'] = _priceWithoutTax;
    if (_productDetails != null) {
      map['product_details'] = _productDetails?.toJson();
    }
    map['rating'] = _rating;
    map['service_provider_id'] = _serviceProviderId;
    map['service_provider_location_id'] = _serviceProviderLocationId;
    map['product_category_id'] = _productCategoryId;
    map['is_veg'] = _isVeg;
    if (_restaurantDetails != null) {
      map['restaurantDetails'] =
          _restaurantDetails?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// _id : "663c9cdaef610e62ce6f4add"
/// name : "Behrouz Biriyani"
/// email : "info@bhrouzbiriyani.com"
/// status : true
/// is_deleted : false
/// phone_number : "91989544063342"
/// more_service_provider_details : [{}]

RestaurantDetails restaurantDetailsFromJson(String str) =>
    RestaurantDetails.fromJson(json.decode(str));

String restaurantDetailsToJson(RestaurantDetails data) =>
    json.encode(data.toJson());

class RestaurantDetails {
  RestaurantDetails({
    String? id,
    String? name,
    String? email,
    bool? status,
    bool? isDeleted,
    String? phoneNumber,
    List<dynamic>? moreServiceProviderDetails,
  }) {
    _id = id;
    _name = name;
    _email = email;
    _status = status;
    _isDeleted = isDeleted;
    _phoneNumber = phoneNumber;
  }

  RestaurantDetails.fromJson(dynamic json) {
    _id = json['_id'].toString();
    _name = json['name'].toString();
    _email = json['email'].toString();
    _status = bool.parse(json['status'].toString());
    // _isDeleted = bool.parse(json['is_deleted'].toString());
    _phoneNumber = json['phone_number'].toString();
  }

  String? _id;
  String? _name;
  String? _email;
  bool? _status;
  bool? _isDeleted;
  String? _phoneNumber;

  RestaurantDetails copyWith({
    String? id,
    String? name,
    String? email,
    bool? status,
    bool? isDeleted,
    String? phoneNumber,
    List<dynamic>? moreServiceProviderDetails,
  }) =>
      RestaurantDetails(
        id: id ?? _id,
        name: name ?? _name,
        email: email ?? _email,
        status: status ?? _status,
        isDeleted: isDeleted ?? _isDeleted,
        phoneNumber: phoneNumber ?? _phoneNumber,
      );

  String? get id => _id;

  String? get name => _name;

  String? get email => _email;

  bool? get status => _status;

  bool? get isDeleted => _isDeleted;

  String? get phoneNumber => _phoneNumber;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['name'] = _name;
    map['email'] = _email;
    map['status'] = _status;
    map['is_deleted'] = _isDeleted;
    map['phone_number'] = _phoneNumber;
    return map;
  }
}

/// product_video_link : null
/// count_of_rating : 17295

ProductDetails productDetailsFromJson(String str) =>
    ProductDetails.fromJson(json.decode(str));

String productDetailsToJson(ProductDetails data) => json.encode(data.toJson());

class ProductDetails {
  ProductDetails({
    dynamic productVideoLink,
    num? countOfRating,
  }) {
    _productVideoLink = productVideoLink;
    _countOfRating = countOfRating;
  }

  ProductDetails.fromJson(dynamic json) {
    _productVideoLink = json['product_video_link'];
    _countOfRating = int.parse(json['count_of_rating'].toString());
  }

  dynamic _productVideoLink;
  num? _countOfRating;

  ProductDetails copyWith({
    dynamic productVideoLink,
    num? countOfRating,
  }) =>
      ProductDetails(
        productVideoLink: productVideoLink ?? _productVideoLink,
        countOfRating: countOfRating ?? _countOfRating,
      );

  dynamic get productVideoLink => _productVideoLink;

  num? get countOfRating => _countOfRating;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['product_video_link'] = _productVideoLink;
    map['count_of_rating'] = _countOfRating;
    return map;
  }
}

/// product_imageUrl : "https://supergrydapi.ritikasingh.site/uploads/dish/WHTP0IVCRM.jpeg"
/// image_small_size : "https://supergrydapi.ritikasingh.site/uploads/dish/WHTP0IVCRM.jpeg"
/// image_mobile : "https://supergrydapi.ritikasingh.site/uploads/dish/WHTP0IVCRM.jpeg"

Images imagesFromJson(String str) => Images.fromJson(json.decode(str));

String imagesToJson(Images data) => json.encode(data.toJson());

class Images {
  Images({
    String? productImageUrl,
    String? imageSmallSize,
    String? imageMobile,
  }) {
    _productImageUrl = productImageUrl;
    _imageSmallSize = imageSmallSize;
    _imageMobile = imageMobile;
  }

  Images.fromJson(dynamic json) {
    _productImageUrl = json['product_imageUrl'].toString();
    _imageSmallSize = json['image_small_size'].toString();
    _imageMobile = json['image_mobile'].toString();
  }

  String? _productImageUrl;
  String? _imageSmallSize;
  String? _imageMobile;

  Images copyWith({
    String? productImageUrl,
    String? imageSmallSize,
    String? imageMobile,
  }) =>
      Images(
        productImageUrl: productImageUrl ?? _productImageUrl,
        imageSmallSize: imageSmallSize ?? _imageSmallSize,
        imageMobile: imageMobile ?? _imageMobile,
      );

  String? get productImageUrl => _productImageUrl;

  String? get imageSmallSize => _imageSmallSize;

  String? get imageMobile => _imageMobile;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['product_imageUrl'] = _productImageUrl;
    map['image_small_size'] = _imageSmallSize;
    map['image_mobile'] = _imageMobile;
    return map;
  }
}
