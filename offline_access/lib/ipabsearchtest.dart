import 'dart:async';
import 'package:flutter/material.dart';
import 'ResultCard/resultCard.dart';
import 'User.dart';
import 'Services.dart';
import 'package:intl/intl.dart';

class MyApps extends StatefulWidget {
  @override
  _MyAppsState createState() => _MyAppsState();
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

class _MyAppsState extends State<MyApps> {
  List<int> reportList = [1, 2, 3, 4, 5, 6];
  List<String> alphaOrder = ["a", "b", "c", "d", "e", "f"];
  final userName = TextEditingController();
  final userEmail = TextEditingController();
  String uName = '';
  String uEmail = '';

  int selectedReportList;
  String selectedAlphaOrderList;

  String selectedDate;
  String selectedTime;
  Future<void> _showDatePicker() async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null) {
      setState(() {
        selectedDate = DateFormat("dd/MM/yyyy").format(picked);
      });
    }
  }

  final _debouncer = Debouncer(milliseconds: 150);
  List<User> users = List();
  List<User> filteredUsers = List();
  Icon customIcon = Icon(Icons.search);

  @override
  void initState() {
    super.initState();
    Services.getUsers().then((usersFromServer) {
      setState(() {
        users = usersFromServer;
        filteredUsers = users;
      });
    });
  }

  Widget space = CustomeText();
  bool check = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      drawer: MultileveDrawer(),
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
            padding: const EdgeInsets.all(8.0),
            child: Container(
                width: 220,
                child: Column(
                  children: [
                    TextField(
                      controller: userName,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Enter the name or email',
                        hintText: 'Enter the name or email',
                      ),
                      autofocus: false,
                      // onChanged: getFirstSearcgText(),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextField(
                      controller: userEmail,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Enter the name',
                        hintText: 'Enter the name',
                      ),
                      autofocus: false,
                      onTap: () async {
                        final date = await showDatePicker(
                            context: context,
                            firstDate: DateTime(1960),
                            initialDate: DateTime.now(),
                            lastDate: DateTime(2100));
                        if (date != null) {
                          print(date);
                        }
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    MultiSelectChip(
                      reportList,
                      onSelectionChanged: (selectedList) {
                        setState(() {
                          selectedReportList = selectedList;
                        });
                      },
                    ),
                    Text(
                      " ${selectedDate ?? "Selected Time"}",
                      style:
                          TextStyle(fontSize: 17, fontWeight: FontWeight.w800),
                    ),
                    RaisedButton(
                      onPressed: () => _showDatePicker(),
                      child: Text("Show Date Picker"),
                    ),
                    Divider(),
                    // MultiSelectChip(
                    //   alphaOrder,
                    //   onSelectionChanged: (selectedList) {
                    //     setState(() {
                    //       selectedAlphaOrderList = selectedList;
                    //     });
                    //   },
                    // ),
                  ],
                )),
          ),
          RaisedButton(
            onPressed: () {
              _debouncer.run(() {
                setState(() {
                  uName = selectedAlphaOrderList;
                  uEmail = userEmail.text;
                  int uId = selectedReportList;

                  filteredUsers =
                      users.where((u) => (u.id >= uId && u.id <= 5)).toList();
                  selectedReportList = 0;
                });
              });
            },
            color: Color(0xffFF1744),
            textColor: Colors.white,
            padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
            child: Text('Search'),
          ),
          IconButton(
            icon: Icon(Icons.sort_by_alpha),
            color: Colors.blue,
            onPressed: () {
              setState(() {
                filteredUsers = filteredUsers.reversed.toList();
              });
            },
          ),
          Expanded(
              child: filteredUsers.length == 0
                  ? Text("No Records Found")
                  : ListView.builder(
                      itemCount: filteredUsers?.length,
                      padding: EdgeInsets.all(10.0),
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

class MultiSelectChip extends StatefulWidget {
  final List<int> reportList;
  final Function(int) onSelectionChanged;

  MultiSelectChip(this.reportList, {this.onSelectionChanged});
  @override
  _MultiSelectChipState createState() => _MultiSelectChipState();
}

class _MultiSelectChipState extends State<MultiSelectChip> {
  int selectedChoice;
  // this function will build and return the choice list
  _buildChoiceList() {
    List<Widget> choices = List();
    widget.reportList.forEach((item) {
      choices.add(Container(
        padding: const EdgeInsets.all(2.0),
        child: ChoiceChip(
          label: Text(item.toString()),
          selected: selectedChoice == item,
          onSelected: (selected) {
            setState(() {
              selectedChoice = item;

              widget.onSelectionChanged(selectedChoice);
            });
          },
        ),
      ));
    });
    return choices;
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: _buildChoiceList(),
    );
  }
}

class CustomeText extends StatelessWidget {
  const CustomeText({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      'Search Result',
      style: ktitlefontstyle,
    );
  }
}

class MultileveDrawer extends StatefulWidget {
  @override
  _MultileveDrawerState createState() => _MultileveDrawerState();
}

class _MultileveDrawerState extends State<MultileveDrawer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 210,
      child: Drawer(
          child: ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 100,
              width: 180,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Image.network('https://www.ipab.gov.in/img/logo.jpg'),
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.account_balance),
            title: Text("About IPAB"),
            onTap: () {},
          ),
          Divider(
            color: Colors.black,
          ),
          ExpansionTile(
            leading: Icon(Icons.people),
            title: Text(
              "Chairman & Members",
            ),
            children: <Widget>[
              ListTile(
                title: Text('Chairman'),
                onTap: () {},
              ),
              ListTile(
                title: Text('Technical Members'),
                onTap: () {},
              ),
              ListTile(
                title: Text('Former Chairman'),
                onTap: () {},
              )
            ],
          ),
          Divider(
            color: Colors.black,
          ),
          ExpansionTile(
            leading: Icon(Icons.local_offer),
            title: Text(
              "Acts & Rules",
            ),
            children: <Widget>[
              ListTile(
                title: Text('Trade Marks'),
                onTap: () {},
              ),
              ListTile(
                title: Text('Patents'),
                onTap: () {},
              ),
              ListTile(
                title: Text('Geographical Indication'),
                onTap: () {},
              ),
              ListTile(
                title: Text('Copyrights'),
                onTap: () {},
              ),
              ListTile(
                title: Text('PVPAT'),
                onTap: () {},
              )
            ],
          ),
          Divider(
            color: Colors.black,
          ),
          ExpansionTile(
            leading: Icon(Icons.table_chart),
            title: Text(
              "Services",
            ),
            children: <Widget>[
              ListTile(
                title: Text('Cause List'),
                onTap: () {},
              ),
              ListTile(
                title: Text('Daily Order'),
                onTap: () {},
              ),
              ListTile(
                title: Text('Orders'),
                onTap: () {},
              )
            ],
          ),
          Divider(
            color: Colors.black,
          ),
          ExpansionTile(
            leading: Icon(Icons.filter_frames),
            title: Text(
              "Forms & Fees",
            ),
            children: <Widget>[
              ListTile(
                title: Text('Trade Marks'),
                onTap: () {},
              ),
              ListTile(
                title: Text('Patents'),
                onTap: () {},
              ),
              ListTile(
                title: Text('Geographical Indication'),
                onTap: () {},
              ),
              ListTile(
                title: Text('Copyrights'),
                onTap: () {},
              ),
              ListTile(
                title: Text('PVPAT'),
                onTap: () {},
              )
            ],
          ),
          Divider(
            color: Colors.black,
          ),
          ListTile(
            leading: Icon(Icons.calendar_today),
            title: Text("Calendar"),
            onTap: () {},
          ),
          Divider(
            color: Colors.black,
          ),
        ],
      )),
    );
  }
}
