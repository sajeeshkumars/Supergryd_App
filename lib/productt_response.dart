import 'dart:convert';
/// page : 1
/// per_page : 6
/// total : 12
/// total_pages : 2
/// data : [{"id":1,"name":"cerulean","year":2000,"color":"#98B2D1","pantone_value":"15-4020"},{"id":2,"name":"fuchsia rose","year":2001,"color":"#C74375","pantone_value":"17-2031"},{"id":3,"name":"true red","year":2002,"color":"#BF1932","pantone_value":"19-1664"},{"id":4,"name":"aqua sky","year":2003,"color":"#7BC4C4","pantone_value":"14-4811"},{"id":5,"name":"tigerlily","year":2004,"color":"#E2583E","pantone_value":"17-1456"},{"id":6,"name":"blue turquoise","year":2005,"color":"#53B0AE","pantone_value":"15-5217"}]
/// support : {"url":"https://reqres.in/#support-heading","text":"To keep ReqRes free, contributions towards server costs are appreciated!"}

ProducttResponse producttResponseFromJson(String str) => ProducttResponse.fromJson(json.decode(str));
String producttResponseToJson(ProducttResponse data) => json.encode(data.toJson());
class ProducttResponse {
  ProducttResponse({
      num? page, 
      num? perPage, 
      num? total, 
      num? totalPages, 
      List<Data>? data, 
      Support? support,}){
    _page = page;
    _perPage = perPage;
    _total = total;
    _totalPages = totalPages;
    _data = data;
    _support = support;
}

  ProducttResponse.fromJson(dynamic json) {
    _page = json['page'];
    _perPage = json['per_page'];
    _total = json['total'];
    _totalPages = json['total_pages'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(Data.fromJson(v));
      });
    }
    _support = json['support'] != null ? Support.fromJson(json['support']) : null;
  }
  num? _page;
  num? _perPage;
  num? _total;
  num? _totalPages;
  List<Data>? _data;
  Support? _support;
ProducttResponse copyWith({  num? page,
  num? perPage,
  num? total,
  num? totalPages,
  List<Data>? data,
  Support? support,
}) => ProducttResponse(  page: page ?? _page,
  perPage: perPage ?? _perPage,
  total: total ?? _total,
  totalPages: totalPages ?? _totalPages,
  data: data ?? _data,
  support: support ?? _support,
);
  num? get page => _page;
  num? get perPage => _perPage;
  num? get total => _total;
  num? get totalPages => _totalPages;
  List<Data>? get data => _data;
  Support? get support => _support;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['page'] = _page;
    map['per_page'] = _perPage;
    map['total'] = _total;
    map['total_pages'] = _totalPages;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    if (_support != null) {
      map['support'] = _support?.toJson();
    }
    return map;
  }

}

/// url : "https://reqres.in/#support-heading"
/// text : "To keep ReqRes free, contributions towards server costs are appreciated!"

Support supportFromJson(String str) => Support.fromJson(json.decode(str));
String supportToJson(Support data) => json.encode(data.toJson());
class Support {
  Support({
      String? url, 
      String? text,}){
    _url = url;
    _text = text;
}

  Support.fromJson(dynamic json) {
    _url = json['url'];
    _text = json['text'];
  }
  String? _url;
  String? _text;
Support copyWith({  String? url,
  String? text,
}) => Support(  url: url ?? _url,
  text: text ?? _text,
);
  String? get url => _url;
  String? get text => _text;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['url'] = _url;
    map['text'] = _text;
    return map;
  }

}

/// id : 1
/// name : "cerulean"
/// year : 2000
/// color : "#98B2D1"
/// pantone_value : "15-4020"

Data dataFromJson(String str) => Data.fromJson(json.decode(str));
String dataToJson(Data data) => json.encode(data.toJson());
class Data {
  Data({
      num? id, 
      String? name, 
      num? year, 
      String? color, 
      String? pantoneValue,}){
    _id = id;
    _name = name;
    _year = year;
    _color = color;
    _pantoneValue = pantoneValue;
}

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _year = json['year'];
    _color = json['color'];
    _pantoneValue = json['pantone_value'];
  }
  num? _id;
  String? _name;
  num? _year;
  String? _color;
  String? _pantoneValue;
Data copyWith({  num? id,
  String? name,
  num? year,
  String? color,
  String? pantoneValue,
}) => Data(  id: id ?? _id,
  name: name ?? _name,
  year: year ?? _year,
  color: color ?? _color,
  pantoneValue: pantoneValue ?? _pantoneValue,
);
  num? get id => _id;
  String? get name => _name;
  num? get year => _year;
  String? get color => _color;
  String? get pantoneValue => _pantoneValue;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['year'] = _year;
    map['color'] = _color;
    map['pantone_value'] = _pantoneValue;
    return map;
  }

}