import 'dart:convert';

/// status : 200
/// message : "Data retrieve successfully."
/// data : {"accessToken":"eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJob3N0X2lkIjoiNjY0NzA1MzQwODIwNTAyYWUzOTlkOWI4IiwidGltZVpvbmUiOiJBc2lhL0tvbGthdGEiLCJpYXQiOjE3MTczODc0NjQsImV4cCI6MTcxNzM4ODM2NH0.4CmlAzHrkFLeGV9LBMs11baw7WQRHBU8lBD00wRKgHU","refreshToken":"eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJob3N0X2lkIjoiNjY0NzA1MzQwODIwNTAyYWUzOTlkOWI4IiwidGltZVpvbmUiOiJBc2lhL0tvbGthdGEiLCJpYXQiOjE3MTczODc0NjQsImV4cCI6MTcxNzk5MjI2NH0.aljhUXMc_gmM96ql2qRIGmZOHITRMz_P4aLv7ig99zk","accessTokenExpiry":"2024-06-03T05:04:24.344Z","refreshTokenExpiry":"2024-06-04T04:04:24.344Z","themes":[{"primary_color":"#e4de43","secondary_color":"#a0e5f6","accent_color":"#acc171","font":"roman","_id":"665c05aaaa1b50894a3f9066"}]}

AuthenticationResponse authenticationResponseFromJson(String str) =>
    AuthenticationResponse.fromJson(json.decode(str));
String authenticationResponseToJson(AuthenticationResponse data) =>
    json.encode(data.toJson());

class AuthenticationResponse {
  AuthenticationResponse({
    num? status,
    String? message,
    Data? data,
  }) {
    _status = status;
    _message = message;
    _data = data;
  }

  AuthenticationResponse.fromJson(dynamic json) {
    _status = int.tryParse(json['status'].toString());
    _message = json['message'].toString();
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  num? _status;
  String? _message;
  Data? _data;
  AuthenticationResponse copyWith({
    num? status,
    String? message,
    Data? data,
  }) =>
      AuthenticationResponse(
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

/// accessToken : "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJob3N0X2lkIjoiNjY0NzA1MzQwODIwNTAyYWUzOTlkOWI4IiwidGltZVpvbmUiOiJBc2lhL0tvbGthdGEiLCJpYXQiOjE3MTczODc0NjQsImV4cCI6MTcxNzM4ODM2NH0.4CmlAzHrkFLeGV9LBMs11baw7WQRHBU8lBD00wRKgHU"
/// refreshToken : "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJob3N0X2lkIjoiNjY0NzA1MzQwODIwNTAyYWUzOTlkOWI4IiwidGltZVpvbmUiOiJBc2lhL0tvbGthdGEiLCJpYXQiOjE3MTczODc0NjQsImV4cCI6MTcxNzk5MjI2NH0.aljhUXMc_gmM96ql2qRIGmZOHITRMz_P4aLv7ig99zk"
/// accessTokenExpiry : "2024-06-03T05:04:24.344Z"
/// refreshTokenExpiry : "2024-06-04T04:04:24.344Z"
/// themes : [{"primary_color":"#e4de43","secondary_color":"#a0e5f6","accent_color":"#acc171","font":"roman","_id":"665c05aaaa1b50894a3f9066"}]

Data dataFromJson(String str) => Data.fromJson(json.decode(str));
String dataToJson(Data data) => json.encode(data.toJson());

class Data {
  Data({
    String? accessToken,
    String? refreshToken,
    String? accessTokenExpiry,
    String? refreshTokenExpiry,
    List<Themes>? themes,
  }) {
    _accessToken = accessToken;
    _refreshToken = refreshToken;
    _accessTokenExpiry = accessTokenExpiry;
    _refreshTokenExpiry = refreshTokenExpiry;
    _themes = themes;
  }

  Data.fromJson(dynamic json) {
    _accessToken = json['accessToken'].toString();
    _refreshToken = json['refreshToken'].toString();
    _accessTokenExpiry = json['accessTokenExpiry'].toString();
    _refreshTokenExpiry = json['refreshTokenExpiry'].toString();
    if (json['themes'] != null) {
      _themes = [];
      json['themes'].forEach((v) {
        _themes?.add(Themes.fromJson(v));
      });
    }
  }
  String? _accessToken;
  String? _refreshToken;
  String? _accessTokenExpiry;
  String? _refreshTokenExpiry;
  List<Themes>? _themes;
  Data copyWith({
    String? accessToken,
    String? refreshToken,
    String? accessTokenExpiry,
    String? refreshTokenExpiry,
    List<Themes>? themes,
  }) =>
      Data(
        accessToken: accessToken ?? _accessToken,
        refreshToken: refreshToken ?? _refreshToken,
        accessTokenExpiry: accessTokenExpiry ?? _accessTokenExpiry,
        refreshTokenExpiry: refreshTokenExpiry ?? _refreshTokenExpiry,
        themes: themes ?? _themes,
      );
  String? get accessToken => _accessToken;
  String? get refreshToken => _refreshToken;
  String? get accessTokenExpiry => _accessTokenExpiry;
  String? get refreshTokenExpiry => _refreshTokenExpiry;
  List<Themes>? get themes => _themes;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['accessToken'] = _accessToken;
    map['refreshToken'] = _refreshToken;
    map['accessTokenExpiry'] = _accessTokenExpiry;
    map['refreshTokenExpiry'] = _refreshTokenExpiry;
    if (_themes != null) {
      map['themes'] = _themes?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// primary_color : "#e4de43"
/// secondary_color : "#a0e5f6"
/// accent_color : "#acc171"
/// font : "roman"
/// _id : "665c05aaaa1b50894a3f9066"

Themes themesFromJson(String str) => Themes.fromJson(json.decode(str));
String themesToJson(Themes data) => json.encode(data.toJson());

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
  Themes copyWith({
    String? primaryColor,
    String? secondaryColor,
    String? accentColor,
    String? font,
    String? id,
  }) =>
      Themes(
        primaryColor: primaryColor ?? _primaryColor,
        secondaryColor: secondaryColor ?? _secondaryColor,
        accentColor: accentColor ?? _accentColor,
        font: font ?? _font,
        id: id ?? _id,
      );
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
