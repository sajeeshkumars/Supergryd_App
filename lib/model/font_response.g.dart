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

Map<String, dynamic> _$$FontResponseImplToJson(_$FontResponseImpl instance) =>
    <String, dynamic>{
      'font': instance.font,
      'fontItems': instance.fontItems,
    };

_$FontItemImpl _$$FontItemImplFromJson(Map<String, dynamic> json) =>
    _$FontItemImpl(
      fontVarient: json['fontVarient'] == null
          ? null
          : FontVarient.fromJson(json['fontVarient'] as Map<String, dynamic>),
      fontFile: json['fontFile'] == null
          ? null
          : FontFileData.fromJson(json['fontFile'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$FontItemImplToJson(_$FontItemImpl instance) =>
    <String, dynamic>{
      'fontVarient': instance.fontVarient,
      'fontFile': instance.fontFile,
    };

_$FontVarientImpl _$$FontVarientImplFromJson(Map<String, dynamic> json) =>
    _$FontVarientImpl(
      fontWeight:
          $enumDecodeNullable(_$FontVarientWeightEnumMap, json['fontWeight']),
      fontStyle:
          $enumDecodeNullable(_$FontVarientStyleEnumMap, json['fontStyle']),
    );

Map<String, dynamic> _$$FontVarientImplToJson(_$FontVarientImpl instance) =>
    <String, dynamic>{
      'fontWeight': _$FontVarientWeightEnumMap[instance.fontWeight],
      'fontStyle': _$FontVarientStyleEnumMap[instance.fontStyle],
    };

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
      format: json['format'] as String?,
    );

Map<String, dynamic> _$$FontFileDataImplToJson(_$FontFileDataImpl instance) =>
    <String, dynamic>{
      'fontVarient': instance.fontVarient,
      'sha256': instance.sha256,
      'sizeInBytes': instance.sizeInBytes,
      'format': instance.format,
    };
