import 'dart:convert';
/// reason_id : 1
/// reason : "Expected a shorter wait time"

CancelReasonsResponse cancelReasonsResponseFromJson(String str) => CancelReasonsResponse.fromJson(json.decode(str));
String canceReasonsResponseToJson(CancelReasonsResponse data) => json.encode(data.toJson());
class CancelReasonsResponse {
  CancelReasonsResponse({
      num? reasonId, 
      String? reason,}){
    _reasonId = reasonId;
    _reason = reason;
}

  CancelReasonsResponse.fromJson(dynamic json) {
    _reasonId = json['reason_id'];
    _reason = json['reason'];
  }
  num? _reasonId;
  String? _reason;
CancelReasonsResponse copyWith({  num? reasonId,
  String? reason,
}) => CancelReasonsResponse(  reasonId: reasonId ?? _reasonId,
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