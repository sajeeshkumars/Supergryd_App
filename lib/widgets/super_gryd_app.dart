import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mynewpackage/model/gryd_features.dart';

import '../app/modules/home/controllers/font_controller.dart';

class SuperGrydApp extends StatelessWidget {
  final Function(BuildContext context, GrydFeatures grydFeatures) builder;

  const SuperGrydApp({super.key, required this.builder});

  static initialize() {
    final controller = Get.put(FontController());
    controller.registerFontsFromWeb();
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<FontController>();
    return Obx(() {
      log("rebuilded font in material ${controller.fontText.value}");
      return Builder(
        builder: (
          context,
        ) {
          return builder(
              context,
              GrydFeatures(
                  textTheme: controller.font.value,
                  fontFamily: controller.fontText.value));
        },
      );
    });
  }
}
