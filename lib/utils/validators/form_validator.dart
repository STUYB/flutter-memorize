import 'package:flutter_gen/gen_l10n/app_localizations.dart';

String? Function(String?) cannotBeEmpty(AppLocalizations localizer) {
  return (String? value) {
    if (value == null || value.isEmpty) {
      return localizer.requiredField;
    }
    return null;
  };
}
