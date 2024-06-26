import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:mynewpackage/l10n/app_localizations_en.dart';

import 'app_localizations.dart';

extension LocalizedBuildContext on BuildContext {
  AppLocalizations get loc {
    try {
      return AppLocalizations.of(this) ?? AppLocalizationsEn();
    } catch (e, stack) {
      log("Exception occurred $e,stack$stack", name: "Localized");
      return AppLocalizationsEn();
    }
  }
}
