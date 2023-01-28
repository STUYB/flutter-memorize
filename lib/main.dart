import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'routes/routes_lib.dart' as routes;

void main() {
  runApp(const Memorize());
}

class Memorize extends StatelessWidget {
  const Memorize({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        routerConfig: routes.getRoutes(),
        theme: ThemeData(
            scaffoldBackgroundColor: Colors.grey.shade300,
            pageTransitionsTheme: const PageTransitionsTheme(builders: {
              TargetPlatform.iOS: ZoomPageTransitionsBuilder(),
              TargetPlatform.android: CupertinoPageTransitionsBuilder(),
            })));
  }
}
