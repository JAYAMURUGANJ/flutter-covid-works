import 'dart:async';
import 'package:custom_radio_grouped_button/custom_radio_grouped_button.dart';
import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
import 'ResultCard/resultCard.dart';
import 'User.dart';
import 'Services.dart';
import 'ipabsearchtest.dart';

void main() {
  runApp(
    Home(),
  );
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyApps(),
    );
  }
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class Debouncer {
  final int milliseconds;
  VoidCallback action;
  Timer _timer;

  Debouncer({this.milliseconds});

  run(VoidCallback action) {
    if (null != _timer) {
      _timer.cancel();
    }
    _timer = Timer(Duration(milliseconds: milliseconds), action);
  }
}

class _MyAppState extends State<MyApp> {
  final _debouncer = Debouncer(milliseconds: 150);
  List<User> users = List();
  List<User> filteredUsers = List();
  Icon customIcon = Icon(Icons.search);

  int searchUid = 1;

  @override
  void initState() {
    super.initState();
    Services.getUsers().then((usersFromServer) {
      setState(() {
        users = usersFromServer;
        filteredUsers = users
            .where((u) => (u.id.toString().contains(searchUid.toString())))
            .toList();
      });
    });
  }

  searchCategory(id) {
    _debouncer.run(() {
      setState(() {
        searchUid = id;
        filteredUsers = users
            .where((u) => (u.id.toString().contains(searchUid.toString())))
            .toList();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // TextStyle submenuFontStyle = GoogleFonts.aBeeZee(
    //     fontSize: 15,
    //     fontWeight: FontWeight.bold,
    //     color: Theme.of(context).accentColor);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('Offline & online'),
        actions: [
          IconButton(
              icon: Icon(Icons.ac_unit),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => IpabResultCard(),
                  ),
                );
              }),
        ],
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(14.0),
            child: SizedBox(
              height: 50, // constrain height
              child: CustomRadioButton(
                elevation: 0,
                unSelectedColor: Theme.of(context).canvasColor,
                buttonLables: [
                  '1',
                  '2',
                  '3',
                  '4',
                  '5',
                ],
                buttonValues: [
                  1,
                  2,
                  3,
                  4,
                  5,
                ],
                defaultSelected: 1,
                buttonTextStyle: ButtonTextStyle(
                    selectedColor: Colors.white,
                    unSelectedColor: Colors.black,
                    textStyle: TextStyle(fontSize: 16)),
                radioButtonValue: (value) {
                  searchCategory(value);
                },
                selectedColor: Theme.of(context).accentColor,
                enableShape: true,
              ),
            ),
          ),
          Expanded(
              child: ListView.builder(
                  padding: EdgeInsets.all(10.0),
                  itemCount: filteredUsers.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Card(
                      child: Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                filteredUsers[index].name,
                                style: TextStyle(
                                  fontSize: 16.0,
                                  color: Colors.black,
                                ),
                              ),
                              SizedBox(
                                height: 5.0,
                              ),
                              Text(
                                filteredUsers[index].email,
                                style: TextStyle(
                                  fontSize: 12.0,
                                  color: Colors.grey,
                                ),
                              ),
                            ]),
                      ),
                    );
                  })),
        ],
      ),
    );
  }
}
