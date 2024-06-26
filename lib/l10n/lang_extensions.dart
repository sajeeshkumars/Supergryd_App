import 'package:flutter/cupertino.dart';

import 'app_localizations.dart';

extension LocalizedBuildContext on BuildContext {
  AppLocalizations? get loc => AppLocalizations.of(this);
}
