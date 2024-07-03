import 'dart:convert';
/// data : [{"reason_id":1,"reason":"Expected a shorter wait time"},{"reason_id":2,"reason":"Unable to contact the driver"},{"reason_id":3,"reason":"Driver denied duty"},{"reason_id":4,"reason":"Cab is not moving in my direction"},{"reason_id":10,"reason":"My reason is not listed"}]

CancelReasonsResponse cancelReasonsResponseFromJson(String str) => CancelReasonsResponse.fromJson(json.decode(str));
String cancelReasonsResponseToJson(CancelReasonsResponse data) => json.encode(data.toJson());
class CancelReasonsResponse {
  CancelReasonsResponse({
      List<CancelReasons>? data,}){
    _data = data;
}

  CancelReasonsResponse.fromJson(dynamic json) {
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(CancelReasons.fromJson(v));
      });
    }
  }
  List<CancelReasons>? _data;
CancelReasonsResponse copyWith({  List<CancelReasons>? data,
}) => CancelReasonsResponse(  data: data ?? _data,
);
  List<CancelReasons>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// reason_id : 1
/// reason : "Expected a shorter wait time"

CancelReasons dataFromJson(String str) => CancelReasons.fromJson(json.decode(str));
String dataToJson(CancelReasons data) => json.encode(data.toJson());
class CancelReasons {
  CancelReasons({
      num? reasonId, 
      String? reason,}){
    _reasonId = reasonId;
    _reason = reason;
}

  CancelReasons.fromJson(dynamic json) {
    _reasonId = json['reason_id'];
    _reason = json['reason'];
  }
  num? _reasonId;
  String? _reason;
CancelReasons copyWith({  num? reasonId,
  String? reason,
}) => CancelReasons(  reasonId: reasonId ?? _reasonId,
  reason: reason ?? _reason,
);
  num? get reasonId => _reasonId;
  String? get reason => _reason;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['reason_id'] = _reasonId;
    map['reason'] = _reason;
    return map;
  }

}