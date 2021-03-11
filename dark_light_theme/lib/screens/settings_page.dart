import 'package:dark_light_theme/util/theme_notifier.dart';
import 'package:dark_light_theme/values/strings.dart';
import 'package:dark_light_theme/values/theme.dart';
import 'package:day_night_switch/day_night_switch.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  var _lightTheme = true;

  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    _lightTheme = (themeNotifier.getTheme() == lightTheme);
    return Scaffold(
      appBar: AppBar(
        title: Text(Strings.titleSettings),
        actions: [
          Transform.scale(
            scale: 0.3,
            child: DayNightSwitch(
              moonImage: NetworkImage(
                  'https://dejpknyizje2n.cloudfront.net/marketplace/products/flat-sun-icon-sticker-1539211556.9485934.png'),
              sunImage: NetworkImage(
                  'https://www.pngarts.com/files/2/Half-Moon-PNG-Transparent-Image.png'),
              sunColor: Colors.white,
              moonColor: Colors.white,
              dayColor: Colors.white,
              nightColor: Colors.grey[100],
              dragStartBehavior: DragStartBehavior.down,
              value: _lightTheme,
              onChanged: (val) {
                setState(() {
                  _lightTheme = val;
                });
                onThemeChanged(val, themeNotifier);
              },
            ),
          ),
        ],
      ),
      body: ListView(
        children: <Widget>[
          ListTile(
            title: Text('Switch On Dark Theme'),
            contentPadding: const EdgeInsets.only(left: 16.0),
          )
        ],
      ),
    );
  }

  void onThemeChanged(bool value, ThemeNotifier themeNotifier) async {
    (value)
        ? themeNotifier.setTheme(lightTheme)
        : themeNotifier.setTheme(darkTheme);
    var prefs = await SharedPreferences.getInstance();
    prefs.setBool('lightMode', value);
  }
}
