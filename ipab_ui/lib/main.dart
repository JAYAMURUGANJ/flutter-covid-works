import 'package:flutter/material.dart';
import 'package:ipab_ui/screens/homePage.dart';
import 'package:ipab_ui/screens/servicesPage.dart';
import 'package:ipab_ui/screens/splashPage.dart';
import 'package:ipab_ui/widgets/colors.dart';
import 'package:flutter_downloader/flutter_downloader.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FlutterDownloader.initialize(
      debug: true // optional: set false to disable printing logs to console
      );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: AppBarTheme(elevation: 0),
        brightness: Brightness.light,
        primaryColor: Colors.white,
        backgroundColor: kBackgroundColor,
      ),
      initialRoute: '/splash',
      routes: {
        '/splash': (context) => SwipPage(),
        '/home': (context) => HomePage(),
        '/service': (context) => ServicesPage(),
      },
    );
  }
}
