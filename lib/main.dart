import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:salam/splash_screen.dart';
import 'package:theme_provider/theme_provider.dart';
import 'global/theme.dart';

void main() => runApp(MyApp());

AppTheme lightTheme() {
  return AppTheme(
    id: "light_theme",
    description: "light Color Scheme",
    data: lightThemee,
  );
}

AppTheme darkTheme() {
  return AppTheme(
    id: "dark_theme",
    description: "dark Color Scheme",
    data: darkThemee,
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ThemeProvider(
      saveThemesOnChange: true,
      loadThemeOnInit: true,
      defaultThemeId: "light_theme",
      themes: <AppTheme>[
        lightTheme(),
        darkTheme(),
      ],
      child: MaterialApp(
        themeMode: ThemeMode.system,
        title: "سلام",
        theme: lightThemee,
        darkTheme: darkThemee,
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: [
          Locale("ar", "EG"),
        ],
        locale: Locale("ar", "EG"),
        debugShowCheckedModeBanner: false,
        home: ThemeConsumer(
          child: SplashScreen(),
        ),
      ),
    );
  }
}
