import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:mynewpackage/l10n/app_localizations_en.dart';
import 'package:mynewpackage/widgets/super_gryd_app.dart';

import 'app_localizations.dart';

extension LocalizedBuildContext on BuildContext {
  AppLocalizations get loc {
    try {
      return parentLocalizations ??
          AppLocalizations.of(this) ??
          AppLocalizationsEn();
    } catch (e, stack) {
      log("Exception occurred $e,stack$stack", name: "Localized");
      return AppLocalizationsEn();
    }
  }
}
