import 'dart:developer';

import 'package:flutter/cupertino.dart';

import 'app_localizations.dart';

extension LocalizedBuildContext on BuildContext {
  AppLocalizations? get loc {
    try {
      return AppLocalizations.of(this);
    } catch (e, stack) {
      log("Exception occurred $e,stack$stack", name: "Localized");
      return null;
    }
  }
}
