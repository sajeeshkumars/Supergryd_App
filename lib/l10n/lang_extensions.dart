import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:mynewpackage/l10n/app_localizations_en.dart';
import 'package:mynewpackage/widgets/super_gryd_app.dart';

import 'app_localizations.dart';

extension LocalizedBuildContext on BuildContext {
  AppLocalizations get loc {
    try {
      log("parentLocalizations $parentLocalizations ${Localizations.of(this, AppLocalizations)}",
          name: "Localized");
      return parentLocalizations ??
          Localizations.of(this, AppLocalizations) ??
          AppLocalizationsEn();
    } catch (e, stack) {
      log("Exception occurred $e,stack$stack", name: "Localized");
      return AppLocalizationsEn();
    }
  }
}
