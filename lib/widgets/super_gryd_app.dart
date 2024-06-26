import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mynewpackage/l10n/app_localizations.dart';
import 'package:mynewpackage/model/gryd_features.dart';

import '../app/modules/home/controllers/font_controller.dart';

AppLocalizations? parentLocalizations;

class SuperGrydApp extends StatelessWidget {
  final Function(BuildContext context, GrydFeatures grydFeatures) builder;
  final AppLocalizations? appLocalizations;

  const SuperGrydApp({super.key, required this.builder, this.appLocalizations});

  static initialize() {
    final controller = Get.put(FontController());
    controller.registerFontsFromWeb();
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<FontController>();
    if (appLocalizations != null) {
      parentLocalizations = appLocalizations;
    }
    return Obx(() {
      log("rebuilded font in material ${controller.fontText.value}");
      return Builder(
        builder: (
          context,
        ) {
          return builder(
              context,
              GrydFeatures(
                  localizationDelegates:
                      AppLocalizations.localizationsDelegates,
                  locales: AppLocalizations.supportedLocales,
                  textTheme: controller.font.value,
                  fontFamily: controller.fontText.value));
        },
      );
    });
  }
}
