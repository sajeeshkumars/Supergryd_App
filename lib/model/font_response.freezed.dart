// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'font_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

FontResponse _$FontResponseFromJson(Map<String, dynamic> json) {
  return _FontResponse.fromJson(json);
}

/// @nodoc
mixin _$FontResponse {
  String? get font => throw _privateConstructorUsedError;
  List<FontItem>? get fontItems => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $FontResponseCopyWith<FontResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FontResponseCopyWith<$Res> {
  factory $FontResponseCopyWith(
          FontResponse value, $Res Function(FontResponse) then) =
      _$FontResponseCopyWithImpl<$Res, FontResponse>;
  @useResult
  $Res call({String? font, List<FontItem>? fontItems});
}

/// @nodoc
class _$FontResponseCopyWithImpl<$Res, $Val extends FontResponse>
    implements $FontResponseCopyWith<$Res> {
  _$FontResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? font = freezed,
    Object? fontItems = freezed,
  }) {
    return _then(_value.copyWith(
      font: freezed == font
          ? _value.font
          : font // ignore: cast_nullable_to_non_nullable
              as String?,
      fontItems: freezed == fontItems
          ? _value.fontItems
          : fontItems // ignore: cast_nullable_to_non_nullable
              as List<FontItem>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$FontResponseImplCopyWith<$Res>
    implements $FontResponseCopyWith<$Res> {
  factory _$$FontResponseImplCopyWith(
          _$FontResponseImpl value, $Res Function(_$FontResponseImpl) then) =
      __$$FontResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? font, List<FontItem>? fontItems});
}

/// @nodoc
class __$$FontResponseImplCopyWithImpl<$Res>
    extends _$FontResponseCopyWithImpl<$Res, _$FontResponseImpl>
    implements _$$FontResponseImplCopyWith<$Res> {
  __$$FontResponseImplCopyWithImpl(
      _$FontResponseImpl _value, $Res Function(_$FontResponseImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? font = freezed,
    Object? fontItems = freezed,
  }) {
    return _then(_$FontResponseImpl(
      font: freezed == font
          ? _value.font
          : font // ignore: cast_nullable_to_non_nullable
              as String?,
      fontItems: freezed == fontItems
          ? _value._fontItems
          : fontItems // ignore: cast_nullable_to_non_nullable
              as List<FontItem>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$FontResponseImpl implements _FontResponse {
  const _$FontResponseImpl({this.font, final List<FontItem>? fontItems})
      : _fontItems = fontItems;

  factory _$FontResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$FontResponseImplFromJson(json);

  @override
  final String? font;
  final List<FontItem>? _fontItems;
  @override
  List<FontItem>? get fontItems {
    final value = _fontItems;
    if (value == null) return null;
    if (_fontItems is EqualUnmodifiableListView) return _fontItems;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'FontResponse(font: $font, fontItems: $fontItems)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FontResponseImpl &&
            (identical(other.font, font) || other.font == font) &&
            const DeepCollectionEquality()
                .equals(other._fontItems, _fontItems));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, font, const DeepCollectionEquality().hash(_fontItems));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$FontResponseImplCopyWith<_$FontResponseImpl> get copyWith =>
      __$$FontResponseImplCopyWithImpl<_$FontResponseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$FontResponseImplToJson(
      this,
    );
  }
}

abstract class _FontResponse implements FontResponse {
  const factory _FontResponse(
      {final String? font,
      final List<FontItem>? fontItems}) = _$FontResponseImpl;

  factory _FontResponse.fromJson(Map<String, dynamic> json) =
      _$FontResponseImpl.fromJson;

  @override
  String? get font;
  @override
  List<FontItem>? get fontItems;
  @override
  @JsonKey(ignore: true)
  _$$FontResponseImplCopyWith<_$FontResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

FontItem _$FontItemFromJson(Map<String, dynamic> json) {
  return _FontItem.fromJson(json);
}

/// @nodoc
mixin _$FontItem {
  FontVarient? get fontVarient => throw _privateConstructorUsedError;
  FontFileData? get fontFile => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $FontItemCopyWith<FontItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FontItemCopyWith<$Res> {
  factory $FontItemCopyWith(FontItem value, $Res Function(FontItem) then) =
      _$FontItemCopyWithImpl<$Res, FontItem>;
  @useResult
  $Res call({FontVarient? fontVarient, FontFileData? fontFile});

  $FontVarientCopyWith<$Res>? get fontVarient;
  $FontFileDataCopyWith<$Res>? get fontFile;
}

/// @nodoc
class _$FontItemCopyWithImpl<$Res, $Val extends FontItem>
    implements $FontItemCopyWith<$Res> {
  _$FontItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? fontVarient = freezed,
    Object? fontFile = freezed,
  }) {
    return _then(_value.copyWith(
      fontVarient: freezed == fontVarient
          ? _value.fontVarient
          : fontVarient // ignore: cast_nullable_to_non_nullable
              as FontVarient?,
      fontFile: freezed == fontFile
          ? _value.fontFile
          : fontFile // ignore: cast_nullable_to_non_nullable
              as FontFileData?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $FontVarientCopyWith<$Res>? get fontVarient {
    if (_value.fontVarient == null) {
      return null;
    }

    return $FontVarientCopyWith<$Res>(_value.fontVarient!, (value) {
      return _then(_value.copyWith(fontVarient: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $FontFileDataCopyWith<$Res>? get fontFile {
    if (_value.fontFile == null) {
      return null;
    }

    return $FontFileDataCopyWith<$Res>(_value.fontFile!, (value) {
      return _then(_value.copyWith(fontFile: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$FontItemImplCopyWith<$Res>
    implements $FontItemCopyWith<$Res> {
  factory _$$FontItemImplCopyWith(
          _$FontItemImpl value, $Res Function(_$FontItemImpl) then) =
      __$$FontItemImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({FontVarient? fontVarient, FontFileData? fontFile});

  @override
  $FontVarientCopyWith<$Res>? get fontVarient;
  @override
  $FontFileDataCopyWith<$Res>? get fontFile;
}

/// @nodoc
class __$$FontItemImplCopyWithImpl<$Res>
    extends _$FontItemCopyWithImpl<$Res, _$FontItemImpl>
    implements _$$FontItemImplCopyWith<$Res> {
  __$$FontItemImplCopyWithImpl(
      _$FontItemImpl _value, $Res Function(_$FontItemImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? fontVarient = freezed,
    Object? fontFile = freezed,
  }) {
    return _then(_$FontItemImpl(
      fontVarient: freezed == fontVarient
          ? _value.fontVarient
          : fontVarient // ignore: cast_nullable_to_non_nullable
              as FontVarient?,
      fontFile: freezed == fontFile
          ? _value.fontFile
          : fontFile // ignore: cast_nullable_to_non_nullable
              as FontFileData?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$FontItemImpl implements _FontItem {
  const _$FontItemImpl({this.fontVarient, this.fontFile});

  factory _$FontItemImpl.fromJson(Map<String, dynamic> json) =>
      _$$FontItemImplFromJson(json);

  @override
  final FontVarient? fontVarient;
  @override
  final FontFileData? fontFile;

  @override
  String toString() {
    return 'FontItem(fontVarient: $fontVarient, fontFile: $fontFile)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FontItemImpl &&
            (identical(other.fontVarient, fontVarient) ||
                other.fontVarient == fontVarient) &&
            (identical(other.fontFile, fontFile) ||
                other.fontFile == fontFile));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, fontVarient, fontFile);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$FontItemImplCopyWith<_$FontItemImpl> get copyWith =>
      __$$FontItemImplCopyWithImpl<_$FontItemImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$FontItemImplToJson(
      this,
    );
  }
}

abstract class _FontItem implements FontItem {
  const factory _FontItem(
      {final FontVarient? fontVarient,
      final FontFileData? fontFile}) = _$FontItemImpl;

  factory _FontItem.fromJson(Map<String, dynamic> json) =
      _$FontItemImpl.fromJson;

  @override
  FontVarient? get fontVarient;
  @override
  FontFileData? get fontFile;
  @override
  @JsonKey(ignore: true)
  _$$FontItemImplCopyWith<_$FontItemImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

FontVarient _$FontVarientFromJson(Map<String, dynamic> json) {
  return _FontVarient.fromJson(json);
}

/// @nodoc
mixin _$FontVarient {
  FontVarientWeight? get fontWeight => throw _privateConstructorUsedError;
  FontVarientStyle? get fontStyle => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $FontVarientCopyWith<FontVarient> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FontVarientCopyWith<$Res> {
  factory $FontVarientCopyWith(
          FontVarient value, $Res Function(FontVarient) then) =
      _$FontVarientCopyWithImpl<$Res, FontVarient>;
  @useResult
  $Res call({FontVarientWeight? fontWeight, FontVarientStyle? fontStyle});
}

/// @nodoc
class _$FontVarientCopyWithImpl<$Res, $Val extends FontVarient>
    implements $FontVarientCopyWith<$Res> {
  _$FontVarientCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? fontWeight = freezed,
    Object? fontStyle = freezed,
  }) {
    return _then(_value.copyWith(
      fontWeight: freezed == fontWeight
          ? _value.fontWeight
          : fontWeight // ignore: cast_nullable_to_non_nullable
              as FontVarientWeight?,
      fontStyle: freezed == fontStyle
          ? _value.fontStyle
          : fontStyle // ignore: cast_nullable_to_non_nullable
              as FontVarientStyle?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$FontVarientImplCopyWith<$Res>
    implements $FontVarientCopyWith<$Res> {
  factory _$$FontVarientImplCopyWith(
          _$FontVarientImpl value, $Res Function(_$FontVarientImpl) then) =
      __$$FontVarientImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({FontVarientWeight? fontWeight, FontVarientStyle? fontStyle});
}

/// @nodoc
class __$$FontVarientImplCopyWithImpl<$Res>
    extends _$FontVarientCopyWithImpl<$Res, _$FontVarientImpl>
    implements _$$FontVarientImplCopyWith<$Res> {
  __$$FontVarientImplCopyWithImpl(
      _$FontVarientImpl _value, $Res Function(_$FontVarientImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? fontWeight = freezed,
    Object? fontStyle = freezed,
  }) {
    return _then(_$FontVarientImpl(
      fontWeight: freezed == fontWeight
          ? _value.fontWeight
          : fontWeight // ignore: cast_nullable_to_non_nullable
              as FontVarientWeight?,
      fontStyle: freezed == fontStyle
          ? _value.fontStyle
          : fontStyle // ignore: cast_nullable_to_non_nullable
              as FontVarientStyle?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$FontVarientImpl implements _FontVarient {
  const _$FontVarientImpl({this.fontWeight, this.fontStyle});

  factory _$FontVarientImpl.fromJson(Map<String, dynamic> json) =>
      _$$FontVarientImplFromJson(json);

  @override
  final FontVarientWeight? fontWeight;
  @override
  final FontVarientStyle? fontStyle;

  @override
  String toString() {
    return 'FontVarient(fontWeight: $fontWeight, fontStyle: $fontStyle)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FontVarientImpl &&
            (identical(other.fontWeight, fontWeight) ||
                other.fontWeight == fontWeight) &&
            (identical(other.fontStyle, fontStyle) ||
                other.fontStyle == fontStyle));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, fontWeight, fontStyle);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$FontVarientImplCopyWith<_$FontVarientImpl> get copyWith =>
      __$$FontVarientImplCopyWithImpl<_$FontVarientImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$FontVarientImplToJson(
      this,
    );
  }
}

abstract class _FontVarient implements FontVarient {
  const factory _FontVarient(
      {final FontVarientWeight? fontWeight,
      final FontVarientStyle? fontStyle}) = _$FontVarientImpl;

  factory _FontVarient.fromJson(Map<String, dynamic> json) =
      _$FontVarientImpl.fromJson;

  @override
  FontVarientWeight? get fontWeight;
  @override
  FontVarientStyle? get fontStyle;
  @override
  @JsonKey(ignore: true)
  _$$FontVarientImplCopyWith<_$FontVarientImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

FontFileData _$FontFileDataFromJson(Map<String, dynamic> json) {
  return _FontFileData.fromJson(json);
}

/// @nodoc
mixin _$FontFileData {
  FontVarient? get fontVarient => throw _privateConstructorUsedError;
  String? get sha256 => throw _privateConstructorUsedError;
  int? get sizeInBytes => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $FontFileDataCopyWith<FontFileData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FontFileDataCopyWith<$Res> {
  factory $FontFileDataCopyWith(
          FontFileData value, $Res Function(FontFileData) then) =
      _$FontFileDataCopyWithImpl<$Res, FontFileData>;
  @useResult
  $Res call({FontVarient? fontVarient, String? sha256, int? sizeInBytes});

  $FontVarientCopyWith<$Res>? get fontVarient;
}

/// @nodoc
class _$FontFileDataCopyWithImpl<$Res, $Val extends FontFileData>
    implements $FontFileDataCopyWith<$Res> {
  _$FontFileDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? fontVarient = freezed,
    Object? sha256 = freezed,
    Object? sizeInBytes = freezed,
  }) {
    return _then(_value.copyWith(
      fontVarient: freezed == fontVarient
          ? _value.fontVarient
          : fontVarient // ignore: cast_nullable_to_non_nullable
              as FontVarient?,
      sha256: freezed == sha256
          ? _value.sha256
          : sha256 // ignore: cast_nullable_to_non_nullable
              as String?,
      sizeInBytes: freezed == sizeInBytes
          ? _value.sizeInBytes
          : sizeInBytes // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $FontVarientCopyWith<$Res>? get fontVarient {
    if (_value.fontVarient == null) {
      return null;
    }

    return $FontVarientCopyWith<$Res>(_value.fontVarient!, (value) {
      return _then(_value.copyWith(fontVarient: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$FontFileDataImplCopyWith<$Res>
    implements $FontFileDataCopyWith<$Res> {
  factory _$$FontFileDataImplCopyWith(
          _$FontFileDataImpl value, $Res Function(_$FontFileDataImpl) then) =
      __$$FontFileDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({FontVarient? fontVarient, String? sha256, int? sizeInBytes});

  @override
  $FontVarientCopyWith<$Res>? get fontVarient;
}

/// @nodoc
class __$$FontFileDataImplCopyWithImpl<$Res>
    extends _$FontFileDataCopyWithImpl<$Res, _$FontFileDataImpl>
    implements _$$FontFileDataImplCopyWith<$Res> {
  __$$FontFileDataImplCopyWithImpl(
      _$FontFileDataImpl _value, $Res Function(_$FontFileDataImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? fontVarient = freezed,
    Object? sha256 = freezed,
    Object? sizeInBytes = freezed,
  }) {
    return _then(_$FontFileDataImpl(
      fontVarient: freezed == fontVarient
          ? _value.fontVarient
          : fontVarient // ignore: cast_nullable_to_non_nullable
              as FontVarient?,
      sha256: freezed == sha256
          ? _value.sha256
          : sha256 // ignore: cast_nullable_to_non_nullable
              as String?,
      sizeInBytes: freezed == sizeInBytes
          ? _value.sizeInBytes
          : sizeInBytes // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$FontFileDataImpl implements _FontFileData {
  const _$FontFileDataImpl({this.fontVarient, this.sha256, this.sizeInBytes});

  factory _$FontFileDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$FontFileDataImplFromJson(json);

  @override
  final FontVarient? fontVarient;
  @override
  final String? sha256;
  @override
  final int? sizeInBytes;

  @override
  String toString() {
    return 'FontFileData(fontVarient: $fontVarient, sha256: $sha256, sizeInBytes: $sizeInBytes)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FontFileDataImpl &&
            (identical(other.fontVarient, fontVarient) ||
                other.fontVarient == fontVarient) &&
            (identical(other.sha256, sha256) || other.sha256 == sha256) &&
            (identical(other.sizeInBytes, sizeInBytes) ||
                other.sizeInBytes == sizeInBytes));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, fontVarient, sha256, sizeInBytes);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$FontFileDataImplCopyWith<_$FontFileDataImpl> get copyWith =>
      __$$FontFileDataImplCopyWithImpl<_$FontFileDataImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$FontFileDataImplToJson(
      this,
    );
  }
}

abstract class _FontFileData implements FontFileData {
  const factory _FontFileData(
      {final FontVarient? fontVarient,
      final String? sha256,
      final int? sizeInBytes}) = _$FontFileDataImpl;

  factory _FontFileData.fromJson(Map<String, dynamic> json) =
      _$FontFileDataImpl.fromJson;

  @override
  FontVarient? get fontVarient;
  @override
  String? get sha256;
  @override
  int? get sizeInBytes;
  @override
  @JsonKey(ignore: true)
  _$$FontFileDataImplCopyWith<_$FontFileDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
