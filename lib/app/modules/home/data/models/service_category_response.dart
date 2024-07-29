import 'dart:convert';

ServiceCategoryResponse serviceCategoryResponseFromJson(String str) =>
    ServiceCategoryResponse.fromJson(json.decode(str));

String serviceCategoryResponseToJson(ServiceCategoryResponse data) =>
    json.encode(data.toJson());

class ServiceCategoryResponse {
  ServiceCategoryResponse({
    num? status,
    String? message,
    Data? data,
  }) {
    _status = status;
    _message = message;
    _data = data;
  }

  ServiceCategoryResponse.fromJson(dynamic json) {
    _status = int.tryParse(json['status'].toString());
    _message = json['message'].toString();
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  num? _status;
  String? _message;
  Data? _data;

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

class Data {
  Data({
    String? id,
    List<ServiceCategories>? serviceCategories,
    List<Themes>? themes,
  }) {
    _id = id;
    _serviceCategories = serviceCategories;
    _themes = themes;
  }

  Data.fromJson(dynamic json) {
    _id = json['_id'].toString();
    if (json['ServiceCategories'] != null) {
      _serviceCategories = [];
      json['ServiceCategories'].forEach((v) {
        _serviceCategories?.add(ServiceCategories.fromJson(v));
      });
    }
    if (json['themes'] != null) {
      _themes = [];
      json['themes'].forEach((v) {
        _themes?.add(Themes.fromJson(v));
      });
    }
  }

  String? _id;
  List<ServiceCategories>? _serviceCategories;
  List<Themes>? _themes;

  String? get id => _id;
  List<ServiceCategories>? get serviceCategories => _serviceCategories;
  List<Themes>? get themes => _themes;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    if (_serviceCategories != null) {
      map['ServiceCategories'] =
          _serviceCategories?.map((v) => v.toJson()).toList();
    }
    if (_themes != null) {
      map['themes'] = _themes?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class ServiceCategories {
  ServiceCategories({
    String? id,
    String? categoryName,
    String? categoryCode,
    num? status,
    List<Images>? images,
  }) {
    _id = id;
    _categoryName = categoryName;
    _categoryCode = categoryCode;
    _status = status;
    _images = images;
  }

  ServiceCategories.fromJson(dynamic json) {
    _id = json['_id'].toString();
    _categoryName = json['category_name'].toString();
    _categoryCode = json['category_code'].toString();
    _status = int.parse(json['status'].toString());
    if (json['images'] != null) {
      _images = [];
      json['images'].forEach((v) {
        _images?.add(Images.fromJson(v));
      });
    }
  }

  String? _id;
  String? _categoryName;
  String? _categoryCode;
  num? _status;
  List<Images>? _images;

  String? get id => _id;
  String? get categoryName => _categoryName;
  String? get categoryCode => _categoryCode;
  num? get status => _status;
  List<Images>? get images => _images;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['category_name'] = _categoryName;
    map['category_code'] = _categoryCode;
    map['status'] = _status;
    if (_images != null) {
      map['images'] = _images?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class Images {
  Images({
    String? primary,
    String? id,
  }) {
    _primary = primary;
    _id = id;
  }

  Images.fromJson(dynamic json) {
    _primary = json['primary'].toString();
    _id = json['_id'].toString();
  }

  String? _primary;
  String? _id;

  String? get primary => _primary;
  String? get id => _id;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['primary'] = _primary;
    map['_id'] = _id;
    return map;
  }
}

class Themes {
  Themes({
    String? primaryColor,
    String? secondaryColor,
    String? accentColor,
    String? font,
    String? id,
  }) {
    _primaryColor = primaryColor;
    _secondaryColor = secondaryColor;
    _accentColor = accentColor;
    _font = font;
    _id = id;
  }

  Themes.fromJson(dynamic json) {
    _primaryColor = json['primary_color'].toString();
    _secondaryColor = json['secondary_color'].toString();
    _accentColor = json['accent_color'].toString();
    _font = json['font'].toString();
    _id = json['_id'].toString();
  }

  String? _primaryColor;
  String? _secondaryColor;
  String? _accentColor;
  String? _font;
  String? _id;

  String? get primaryColor => _primaryColor;
  String? get secondaryColor => _secondaryColor;
  String? get accentColor => _accentColor;
  String? get font => _font;
  String? get id => _id;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['primary_color'] = _primaryColor;
    map['secondary_color'] = _secondaryColor;
    map['accent_color'] = _accentColor;
    map['font'] = _font;
    map['_id'] = _id;
    return map;
  }
}
