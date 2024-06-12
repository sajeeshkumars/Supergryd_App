// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'font_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$FontResponseImpl _$$FontResponseImplFromJson(Map<String, dynamic> json) =>
    _$FontResponseImpl(
      font: json['font'] as String?,
      fontItems: (json['fontItems'] as List<dynamic>?)
          ?.map((e) => FontItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$FontResponseImplToJson(_$FontResponseImpl instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('font', instance.font);
  writeNotNull(
      'fontItems', instance.fontItems?.map((e) => e.toJson()).toList());
  return val;
}

_$FontItemImpl _$$FontItemImplFromJson(Map<String, dynamic> json) =>
    _$FontItemImpl(
      fontVarient: json['fontVarient'] == null
          ? null
          : FontVarient.fromJson(json['fontVarient'] as Map<String, dynamic>),
      fontFile: json['fontFile'] == null
          ? null
          : FontFileData.fromJson(json['fontFile'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$FontItemImplToJson(_$FontItemImpl instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('fontVarient', instance.fontVarient?.toJson());
  writeNotNull('fontFile', instance.fontFile?.toJson());
  return val;
}

_$FontVarientImpl _$$FontVarientImplFromJson(Map<String, dynamic> json) =>
    _$FontVarientImpl(
      fontWeight:
          $enumDecodeNullable(_$FontVarientWeightEnumMap, json['fontWeight']),
      fontStyle:
          $enumDecodeNullable(_$FontVarientStyleEnumMap, json['fontStyle']),
    );

Map<String, dynamic> _$$FontVarientImplToJson(_$FontVarientImpl instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('fontWeight', _$FontVarientWeightEnumMap[instance.fontWeight]);
  writeNotNull('fontStyle', _$FontVarientStyleEnumMap[instance.fontStyle]);
  return val;
}

const _$FontVarientWeightEnumMap = {
  FontVarientWeight.w100: 'w100',
  FontVarientWeight.w200: 'w200',
  FontVarientWeight.w300: 'w300',
  FontVarientWeight.w400: 'w400',
  FontVarientWeight.w500: 'w500',
  FontVarientWeight.w600: 'w600',
  FontVarientWeight.w700: 'w700',
  FontVarientWeight.w800: 'w800',
  FontVarientWeight.w900: 'w900',
  FontVarientWeight.normal: 'normal',
  FontVarientWeight.bold: 'bold',
};

const _$FontVarientStyleEnumMap = {
  FontVarientStyle.regular: 'regular',
  FontVarientStyle.italic: 'italic',
};

_$FontFileDataImpl _$$FontFileDataImplFromJson(Map<String, dynamic> json) =>
    _$FontFileDataImpl(
      fontVarient: json['fontVarient'] == null
          ? null
          : FontVarient.fromJson(json['fontVarient'] as Map<String, dynamic>),
      sha256: json['sha256'] as String?,
      sizeInBytes: (json['sizeInBytes'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$FontFileDataImplToJson(_$FontFileDataImpl instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('fontVarient', instance.fontVarient?.toJson());
  writeNotNull('sha256', instance.sha256);
  writeNotNull('sizeInBytes', instance.sizeInBytes);
  return val;
}
