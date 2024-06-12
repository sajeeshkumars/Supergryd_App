import 'package:dynamic_fonts/dynamic_fonts.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mynewpackage/app/modules/home/data/font_service.dart';

import '../../../../model/font_response.dart';
import '../../../core/font_utils.dart';

class FontController extends GetxController {
  RxBool isLoading = false.obs;
  RxString fontText = "".obs;
  static FontService apiService = FontService();

  Rx<TextTheme> font = const TextTheme().obs;

  @override
  void onInit() {
    super.onInit();
    registerFontsFromWeb();
  }

  setFont(String fontName) {
    isLoading(true);
    if (fontName.isNotEmpty) {
      fontText(fontName);
      font.value = DynamicFonts.getTextTheme(
        fontText.value,
      );
    } else {
      font.value = const TextTheme();
    }
    isLoading(false);
  }

  // fetchFont() async {
  //   isLoading(true);
  //   await Future.delayed(const Duration(seconds: 2));
  //   Map<String, String> map = await apiService.getFont();
  //   if (map.isNotEmpty) {
  //     fontText.value = map.keys.first;
  //
  //     font.value = DynamicFonts.getTextTheme(
  //       fontText.value,
  //     );
  //   } else {
  //     font.value = const TextTheme();
  //   }
  //   isLoading(false);
  // }
  // fetchFont() async {
  //   isLoading(true);
  //   await Future.delayed(const Duration(seconds: 2));
  //   Map<String, String> map = await apiService.getFont();
  //   if (map.isNotEmpty) {
  //     fontText.value = map.keys.first;
  //
  //     font.value = DynamicFonts.getTextTheme(
  //       fontText.value,
  //     );
  //   } else {
  //     font.value = const TextTheme();
  //   }
  //   isLoading(false);
  // }

  registerFontsFromWeb() async {
    List<FontResponse> list = await apiService.getFontForRegistration();
    for (var e in list) {
      Map<DynamicFontsVariant, DynamicFontsFile> map =
          FontUtils.convertFontResponseToDynamicFontVarient(e);
      print("getFontForRegistrationCalled ${map}");

      if (map.isNotEmpty && e.font != null) {
        DynamicFonts.register(e.font!, map);
      }
    }
    // fetchFont();
  }
}
