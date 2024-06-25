import 'package:flutter/material.dart';

class GrydFeatures {
  final TextTheme textTheme;
  final String fontFamily;
  final List<LocalizationsDelegate> localizationDelegates;
  final List<Locale> locales;

  GrydFeatures({
    required this.textTheme,
    required this.fontFamily,
    required this.localizationDelegates,
    required this.locales,
  });
}
