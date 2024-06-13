import 'dart:developer';

import 'package:dynamic_fonts/dynamic_fonts.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mynewpackage/app/modules/home/data/font_service.dart';

import '../../../../model/font_response.dart';
import '../../../core/font_utils.dart';

class FontController extends GetxController {
  RxBool isLoading = false.obs;
  RxString fontText = "".obs;
  RxString requestedFontText = "".obs;
  RxBool fontExists = false.obs;
  static FontService apiService = FontService();
  RxList<String> supportedFonts = <String>[].obs;
  Rx<TextTheme> font = const TextTheme().obs;

  @override
  void onInit() {
    super.onInit();
    registerFontsFromWeb();
  }

  setFont(String fontName) {
    isLoading(true);
    log("setFont $fontName called", name: "FONTCONTROLLER");
    requestedFontText(fontName);
    log("supportedFonts $supportedFonts called", name: "FONTCONTROLLER");

    if (supportedFonts.contains(fontName)) {
      fontText(fontName);
      if (fontName.isNotEmpty) {
        font.value = DynamicFonts.getTextTheme(
            fontText.value,
            TextTheme(
                bodyLarge: TextStyle(
                  fontFamily: fontName,
                ),
                bodyMedium: TextStyle(
                  fontFamily: fontName,
                ),
                bodySmall: TextStyle(
                  fontFamily: fontName,
                ),
                displayLarge: TextStyle(
                  fontFamily: fontName,
                ),
                displayMedium: TextStyle(
                  fontFamily: fontName,
                ),
                displaySmall: TextStyle(
                  fontFamily: fontName,
                ),
                headlineLarge: TextStyle(
                  fontFamily: fontName,
                ),
                headlineMedium: TextStyle(
                  fontFamily: fontName,
                ),
                headlineSmall: TextStyle(
                  fontFamily: fontName,
                ),
                labelLarge: TextStyle(
                  fontFamily: fontName,
                ),
                labelMedium: TextStyle(
                  fontFamily: fontName,
                ),
                labelSmall: TextStyle(
                  fontFamily: fontName,
                ),
                titleLarge: TextStyle(
                  fontFamily: fontName,
                ),
                titleMedium: TextStyle(
                  fontFamily: fontName,
                ),
                titleSmall: TextStyle(
                  fontFamily: fontName,
                )));
      } else {
        font.value = const TextTheme();
      }
    } else {
      if (supportedFonts.isEmpty) {
        registerFontsFromWeb();
      }
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
    supportedFonts.clear();
    List<FontResponse> list = await apiService.getFontForRegistration();
    for (var e in list) {
      Map<DynamicFontsVariant, DynamicFontsFile> map =
          FontUtils.convertFontResponseToDynamicFontVarient(e);
      print("getFontForRegistrationCalled ${map}");
      if (map.isNotEmpty && e.font != null) {
        supportedFonts.add(e.font!);
        DynamicFonts.register(e.font!, map);
      }
      if (e.font == requestedFontText.value) {
        setFont(requestedFontText.value);
      }
    }
    // fetchFont();
  }
}
