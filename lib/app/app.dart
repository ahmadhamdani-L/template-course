import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import '../core/localization/app_localizations.dart';
import '../core/theme/theme_provider.dart';
import 'bootstrap.dart';
import 'routing/app_router.dart';

/// Root application widget
class EduApp extends ConsumerWidget {
  const EduApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final config = ref.watch(appConfigProvider);
    final themeMode = ref.watch(themeModeProvider);
    final locale = ref.watch(currentLocaleProvider);
    final router = ref.watch(appRouterProvider);
    
    return MaterialApp.router(
      title: config.identity.displayName,
      debugShowCheckedModeBanner: false,
      
      // Theming
      theme: ref.watch(lightThemeProvider),
      darkTheme: ref.watch(darkThemeProvider),
      themeMode: themeMode,
      
      // Routing
      routerConfig: router,
      
      // Localization
      locale: locale,
      supportedLocales: config.localization.supportedLocales
          .map((code) => Locale(code))
          .toList(),
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
    );
  }
}
