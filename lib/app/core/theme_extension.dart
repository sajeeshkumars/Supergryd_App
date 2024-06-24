import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mynewpackage/app/modules/home/controllers/font_controller.dart';

final fontController = Get.find<FontController>();

extension ThemeExtension on BuildContext {
  ColorScheme get parentColorScheme => Theme.of(this).colorScheme;
  TextTheme get myTextTheme => fontController.font.value;
  TextTheme get parentTextTheme => Theme.of(this).textTheme;
  TextButtonThemeData get parentTextButtonThemeData =>
      Theme.of(this).textButtonTheme;
  ElevatedButtonThemeData get parentElevatedButtonThemeData =>
      Theme.of(this).elevatedButtonTheme;
  OutlinedButtonThemeData get parentOutlinedButtonThemeData =>
      Theme.of(this).outlinedButtonTheme;
}
