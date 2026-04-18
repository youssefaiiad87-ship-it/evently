import 'package:evently/core/provider/app_config_provider.dart';
import 'package:evently/core/theme/app_theme.dart';
import 'package:evently/core/utils/shared_preferences_keys.dart';
import 'package:evently/ui/app_setup/app_setup.dart';
import 'package:evently/ui/splash_screen/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart' show GlobalWidgetsLocalizations, GlobalMaterialLocalizations, GlobalCupertinoLocalizations;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/l10n/app_localizations.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
   MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late AppConfigProvider provider;
  @override
  void initState() {
    init();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) {
        return AppConfigProvider();
      },
      child: Consumer<AppConfigProvider>(
        builder:(context , provider, _) {
          this.provider =provider;
          return MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          locale: Locale(provider.local),
          themeMode: provider.themeMode,
        theme:AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
            initialRoute: SplashScreen.routeName,
            routes: {
            SplashScreen.routeName: (_) => const SplashScreen(),
            AppSetup.routeName: (_) => const AppSetup(),
            },
            );
        },
      ),);
  }

  Future <void> init()async {
    final prefs = await SharedPreferences.getInstance();
    final locale = prefs.getString(SharedPreferencesKeys.locale.name) ??"en";
    final isDark = prefs.getBool(SharedPreferencesKeys.isDark.name)?? false ;
    provider.changeTheme(isDark?ThemeMode.dark : ThemeMode.light);
    provider.changeLocal(locale );




  }
}

