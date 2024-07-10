import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../app/modules/home/controllers/font_controller.dart';
import '../model/gryd_features.dart';

class SuperGrydBuilder extends StatelessWidget {
  final Function(BuildContext context, GrydFeatures grydFeatures) builder;

  const SuperGrydBuilder({super.key, required this.builder});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<FontController>();
    return Obx(() {
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
