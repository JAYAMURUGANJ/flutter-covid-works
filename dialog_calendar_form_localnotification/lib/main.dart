import 'package:cached_network_image/cached_network_image.dart';
import 'package:dialog_calendar_form_localnotification/month_calendar.dart';
import 'package:dialog_calendar_form_localnotification/year_calendar.dart';
import 'package:flutter/material.dart';

import 'calendar.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  //Alert Dialog
  void _showDialog1() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Alert"),
          content: new Text("Want to View Calendar"),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            FlatButton(
              child: new Text("Yes"),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => YearCalendar()));
              },
            ),
            FlatButton(
              child: new Text("No"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _showDialog2() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Alert"),
          content: new Text("Want to View Calendar"),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            FlatButton(
              child: new Text("Yes"),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => MonthCalendar()));
              },
            ),
            FlatButton(
              child: new Text("No"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 50.0, horizontal: 10.0),
          child: Container(
            child: Column(
              children: <Widget>[
                CachedNetworkImage(
                  imageUrl:
                      "https://ouch-cdn.icons8.com/preview/270/2a30a948-bd4f-4430-8e81-99644405fca2.png",
                  placeholder: (context, url) => CircularProgressIndicator(),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
                Center(
                    child: MaterialButton(
                  color: Colors.orangeAccent,
                  hoverColor: Colors.yellow,
                  splashColor: Colors.pink,
                  focusColor: Colors.green,
                  highlightColor: Colors.redAccent,
                  child: Text(
                    'View Calendar',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) => MyCalendar()));
                  },
                )),
                Center(
                    child: MaterialButton(
                  color: Colors.orangeAccent,
                  hoverColor: Colors.yellow,
                  splashColor: Colors.pink,
                  focusColor: Colors.green,
                  highlightColor: Colors.redAccent,
                  child: Text(
                    'View Year Calendar',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    _showDialog1();
                  },
                )),
                Center(
                    child: MaterialButton(
                  color: Theme.of(context).primaryColor,
                  hoverColor: Colors.yellow,
                  splashColor: Colors.pink,
                  focusColor: Colors.green,
                  highlightColor: Colors.redAccent,
                  child: Text(
                    'View Month Calendar',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    _showDialog2();
                  },
                )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
//
