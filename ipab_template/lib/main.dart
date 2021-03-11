import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ipab_template/localization/demo_localization.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:ipab_template/screens/intro_page.dart';
import 'package:ipab_template/services/service_locator.dart';
import 'package:ipab_template/values/theme.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'localization/language_constants.dart';
import 'package:ipab_template/util/theme_notifier.dart';
import 'package:flutter_downloader/flutter_downloader.dart';

void main() async {
  setupLocator();
  WidgetsFlutterBinding.ensureInitialized();
  await FlutterDownloader.initialize(
      debug: true // optional: set false to disable printing logs to console
      );
  SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]).then(
    (_) {
      SharedPreferences.getInstance().then(
        (prefs) {
          var lightModeOn = prefs.getBool('lightMode') ?? true;
          runApp(
            ChangeNotifierProvider<ThemeNotifier>(
              create: (_) =>
                  ThemeNotifier(lightModeOn ? lightTheme : darkTheme),
              child: MyApp(),
            ),
          );
        },
      );
    },
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key key}) : super(key: key);
  static void setLocale(BuildContext context, Locale newLocale) {
    _MyAppState state = context.findAncestorStateOfType<_MyAppState>();
    state.setLocale(newLocale);
  }

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Locale _locale;
  setLocale(Locale locale) {
    setState(
      () {
        _locale = locale;
      },
    );
  }

  @override
  void didChangeDependencies() {
    getLocale().then(
      (locale) {
        setState(
          () {
            this._locale = locale;
          },
        );
      },
    );
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    if (this._locale == null) {
      return Container(
        child: Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.blue[800]),
          ),
        ),
      );
    } else {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: themeNotifier.getTheme(),
        locale: _locale,
        supportedLocales: [Locale("en", "US"), Locale("hi", "IN")],
        localizationsDelegates: [
          DemoLocalization.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        localeResolutionCallback: (locale, supportedLocales) {
          for (var supportedLocale in supportedLocales) {
            if (supportedLocale.languageCode == locale.languageCode &&
                supportedLocale.countryCode == locale.countryCode) {
              return supportedLocale;
            }
          }
          return supportedLocales.first;
        },
        home: SwipPage(),
      );
    }
  }
}
