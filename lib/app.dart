import 'package:cosmospedia/config/theme.dart';
import 'package:cosmospedia/l10n/app_localizations_delegates.dart';
import 'package:cosmospedia/ui/screens/home_screen/home_screen.dart';
import 'package:cosmospedia/ui/screens/sign_in_screen/sign_in_screen.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter/material.dart';

import 'config/routes.dart';
import 'l10n/app_localizations.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: const [
        AppLocalizationsDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en', ''), //English
        // Add more locales as needed
      ],
      title: 'Cosmospedia', // Use a hardcoded fallback title
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      onGenerateRoute: AppRouter.onGenerateRoute,
      home: Builder(
        builder: (context) {
          // Use a fallback method to avoid null check
          final l10n = AppLocalizations.of(context) ?? AppLocalizations.of(context);
          return const SignInScreen();
        },
      )
    );
  }
}
