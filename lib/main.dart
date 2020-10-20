import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:weather_example/screens/SplashScreen.dart';
import 'app_localizations.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SplashScreen(),
      supportedLocales: [
        Locale("en", "US"),
        Locale("ru", "RU"),
      ],
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      localeResolutionCallback: (locale, supportedLocales){
        for(var supportedLocale in supportedLocales){
          if(supportedLocale.languageCode == locale.languageCode &&
          supportedLocale.countryCode == locale.countryCode){
            return supportedLocale;
          }
        }
      },
    );
  }
}