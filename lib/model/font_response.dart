import 'package:freezed_annotation/freezed_annotation.dart';

part 'font_response.freezed.dart';
part 'font_response.g.dart';

@freezed
class FontResponse with _$FontResponse {
  const factory FontResponse({
    final String? font,
    final List<FontItem>? fontItems,
  }) = _FontResponse;

  factory FontResponse.fromJson(Map<String, dynamic> json) =>
      _$FontResponseFromJson(json);
}

@freezed
class FontItem with _$FontItem {
  const factory FontItem({
    final FontVarient? fontVarient,
    final FontFileData? fontFile,
  }) = _FontItem;

  factory FontItem.fromJson(Map<String, dynamic> json) =>
      _$FontItemFromJson(json);
}

@freezed
class FontVarient with _$FontVarient {
  const factory FontVarient({
    final FontVarientWeight? fontWeight,
    final FontVarientStyle? fontStyle,
  }) = _FontVarient;

  factory FontVarient.fromJson(Map<String, dynamic> json) =>
      _$FontVarientFromJson(json);
}

@freezed
class FontFileData with _$FontFileData {
  const factory FontFileData(
      {final FontVarient? fontVarient,
      final String? sha256,
      final int? sizeInBytes,
      final String? format}) = _FontFileData;

  factory FontFileData.fromJson(Map<String, dynamic> json) =>
      _$FontFileDataFromJson(json);
}

enum FontVarientWeight {
  w100,
  w200,
  w300,
  w400,
  w500,
  w600,
  w700,
  w800,
  w900,
  normal,
  bold
}

enum FontVarientStyle { regular, italic }
