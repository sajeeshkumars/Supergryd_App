import 'dart:ui';

import 'package:dynamic_fonts/dynamic_fonts.dart';

class CommonFontFile extends DynamicFontsFile {
  CommonFontFile(
      super.expectedFileHash, super.expectedLength, this.fontName, this.variant,
      {this.extension});
  final String fontName;
  final String? extension;

  final DynamicFontsVariant variant;

  String get _dir {
    switch (variant.fontStyle) {
      case FontStyle.normal:
        return 'Regular';
      case FontStyle.italic:
        return 'Italic';
    }
  }

  @override
  String get url =>
      "https://github.com/AdarshKSeeroo/fonts/raw/master/$fontName/$_dir/$fontName-${variant.toApiFilenamePart()}.${extension ?? "ttf"}";
  // 'https://github.com/AdarshKSeeroo/fonts/raw/64f8a771b7510e1fcc698e674318c96d312dfd62/$fontName/$_dir/$fontName-${variant.toApiFilenamePart()}.ttf';
}
