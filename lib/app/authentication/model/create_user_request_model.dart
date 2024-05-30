import 'dart:convert';
/// phone_number : "23232323"
/// phone_code : "232"

CreateUserRequestModel createUserRequestModelFromJson(String str) => CreateUserRequestModel.fromJson(json.decode(str));
String createUserRequestModelToJson(CreateUserRequestModel data) => json.encode(data.toJson());
class CreateUserRequestModel {
  CreateUserRequestModel({
    String? phoneNumber,
    String? phoneCode,
    String? name,
  }){
    _phoneNumber = phoneNumber;
    _phoneCode = phoneCode;
    _name = name;
  }

  CreateUserRequestModel.fromJson(dynamic json) {
    _phoneNumber = json['phone_number'];
    _phoneCode = json['phone_code'];
    _name = json['name'];
  }
  String? _phoneNumber;
  String? _phoneCode;
  String? _name;
  CreateUserRequestModel copyWith({  String? phoneNumber,
    String? phoneCode,
    String? name
  }) => CreateUserRequestModel(  phoneNumber: phoneNumber ?? _phoneNumber,
    phoneCode: phoneCode ?? _phoneCode,
    name: name ?? _name
  );
  String? get phoneNumber => _phoneNumber;
  String? get phoneCode => _phoneCode;
  String? get name => _name;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['phone_number'] = _phoneNumber;
    map['phone_code'] = _phoneCode;
    map['name'] = _name;
    return map;
  }

}