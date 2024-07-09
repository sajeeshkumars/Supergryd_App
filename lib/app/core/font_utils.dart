import 'dart:ui';

import 'package:dynamic_fonts/dynamic_fonts.dart';

import '../../model/common_font_file.dart';
import '../../model/font_response.dart';

class FontUtils {
  static Map<DynamicFontsVariant, DynamicFontsFile>
      convertFontResponseToDynamicFontVariant(FontResponse fontResponse) {
    Map<DynamicFontsVariant, DynamicFontsFile> map = {};

    if (fontResponse.font != null && fontResponse.fontItems != null) {
      List<FontItem> fontItems = fontResponse.fontItems ?? [];
      if (fontItems.isNotEmpty) {
        for (var e in fontItems) {
          if (e.fontFile?.sha256 != null &&
              e.fontFile?.fontVarient != null &&
              e.fontVarient != null &&
              e.fontFile?.sizeInBytes != null) {
            DynamicFontsVariant varient = DynamicFontsVariant(
                fontWeight: convertFontVariantWeightToFontWeight(
                    e.fontVarient!.fontWeight!),
                fontStyle: convertFontVariantStyleToFontStyle(
                    e.fontVarient!.fontStyle!));
            DynamicFontsFile fontsFile = CommonFontFile(
                e.fontFile!.sha256!,
                e.fontFile!.sizeInBytes!,
                fontResponse.font!,
                DynamicFontsVariant(
                  fontWeight: convertFontVariantWeightToFontWeight(
                      e.fontFile!.fontVarient!.fontWeight!),
                  fontStyle: convertFontVariantStyleToFontStyle(
                      e.fontFile!.fontVarient!.fontStyle!),
                ),
                extension: e.fontFile?.format);
            map[varient] = fontsFile;
          }
        }
        return map;
      } else {
        return map;
      }
    } else {
      return map;
    }
  }
}

FontWeight convertFontVariantWeightToFontWeight(FontVarientWeight weight) {
  return switch (weight) {
    FontVarientWeight.w100 => FontWeight.w100,
    FontVarientWeight.w200 => FontWeight.w200,
    FontVarientWeight.w300 => FontWeight.w300,
    FontVarientWeight.w400 => FontWeight.w400,
    FontVarientWeight.w500 => FontWeight.w500,
    FontVarientWeight.w600 => FontWeight.w600,
    FontVarientWeight.w700 => FontWeight.w700,
    FontVarientWeight.w800 => FontWeight.w800,
    FontVarientWeight.w900 => FontWeight.w900,
    FontVarientWeight.bold => FontWeight.bold,
    FontVarientWeight.normal => FontWeight.normal,
  };
}

FontStyle convertFontVariantStyleToFontStyle(FontVarientStyle style) {
  return switch (style) {
    FontVarientStyle.regular => FontStyle.normal,
    FontVarientStyle.italic => FontStyle.italic,
  };
}
