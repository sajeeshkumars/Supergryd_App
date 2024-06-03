import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../app_colors.dart';

class ColorController extends GetxController {
  var primaryColor = AppColors.primaryColor.obs;
  var accentColor = AppColors.accentColor.obs;

  void updateColors(String newPrimaryColor, String newAccentColor) {
    primaryColor.value = fromHex(newPrimaryColor);
    accentColor.value = fromHex(newAccentColor);
  }

  Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }
}