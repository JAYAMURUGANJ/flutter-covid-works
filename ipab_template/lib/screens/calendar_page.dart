import 'package:flutter/material.dart';
import 'package:ipab_template/custom_widgets/calendarPage_widget.dart';
import 'package:ipab_template/localization/language_constants.dart';
import 'package:intl/intl.dart';

import 'home_page.dart';

class YearCalendar extends StatefulWidget {
  @override
  _YearCalendarState createState() => _YearCalendarState();
}

class _YearCalendarState extends State<YearCalendar> {
  // Properties & Variables needed

  int currentTab = 0; // to keep track of active tab index
  final List<Widget> screens = [
    MyCalendar(
      benchName: 'chennai',
      topColor: Colors.green[600],
      buttomColor: Colors.green,
    ),
    MyCalendar(
      benchName: 'delhi',
      topColor: Colors.orange[600],
      buttomColor: Colors.orange,
    ),
  ]; // to store nested tabs
  final PageStorageBucket bucket = PageStorageBucket();
  Widget currentScreen = MyCalendar(
    benchName: 'chennai',
    topColor: Colors.green[600],
    buttomColor: Colors.green,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageStorage(
        child: currentScreen,
        bucket: bucket,
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.home),
        onPressed: () {
          Navigator.pop(context);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => HomePage(),
            ),
          );
        },
      ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterDocked,
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 10,
        child: Container(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  MaterialButton(
                    minWidth: 40,
                    onPressed: () {
                      setState(() {
                        currentScreen = MyCalendar(
                          benchName: 'chennai',
                          topColor: Colors.green[600],
                          buttomColor: Colors.green,
                        ); // if user taps on this dashboard tab will be active
                        currentTab = 0;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.dashboard,
                          color: currentTab == 0 ? Colors.green : Colors.grey,
                        ),
                        Text(
                          'Chennai',
                          style: TextStyle(
                            color: currentTab == 0 ? Colors.green : Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              // Right Tab bar icons

              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  MaterialButton(
                    minWidth: 40,
                    onPressed: () {
                      setState(() {
                        currentScreen = MyCalendar(
                          benchName: 'delhi',
                          topColor: Colors.orange[600],
                          buttomColor: Colors.orange,
                        ); // if user taps on this dashboard tab will be active
                        currentTab = 2;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.dashboard,
                          color: currentTab == 2 ? Colors.orange : Colors.grey,
                        ),
                        Text(
                          'Delhi',
                          style: TextStyle(
                            color:
                                currentTab == 2 ? Colors.orange : Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

List<String> year = [
  '2019',
  '2020',
];
var _chosenCauseListCatValue = year[1];

class MyCalendar extends StatefulWidget {
  final String benchName;
  final Color topColor;
  final Color buttomColor;
  MyCalendar({this.benchName, this.buttomColor, this.topColor});
  @override
  _MyCalendarState createState() => _MyCalendarState();
}

class _MyCalendarState extends State<MyCalendar>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    _tabController = new TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          title: Text(
            'IPAB ' +
                getTranslated(context, widget.benchName) +
                ' ' +
                getTranslated(context, 'calendar'),
          ),
        ),
        body: SingleChildScrollView(
            physics: ClampingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(children: <Widget>[
                Container(
                  child: Stack(
                    children: <Widget>[
                      Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [widget.topColor, widget.buttomColor]),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Center(
                                child: Text(
                                  'Select Calendar Year .',
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Column(
                                    children: <Widget>[
                                      Icon(
                                        Icons.date_range,
                                        size: 35,
                                        color: Colors.white,
                                      ),
                                      Text(
                                        'Year',
                                        style: TextStyle(
                                            fontSize: 10, color: Colors.white),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Container(
                                    width: 200,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        color: Colors.white),
                                    child: Center(
                                      child: DropdownButton<String>(
                                        dropdownColor: Colors.white,
                                        iconEnabledColor: Colors.black,
                                        value: _chosenCauseListCatValue,
                                        underline:
                                            Container(), // this is the magic
                                        items: year
                                            .map<DropdownMenuItem<String>>(
                                                (String value) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: Text(
                                              value,
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  color: Colors.black),
                                            ),
                                          );
                                        }).toList(),
                                        onChanged: (String value) {
                                          setState(() {
                                            _chosenCauseListCatValue = value;
                                          });
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  decoration: BoxDecoration(color: Colors.white),
                  child: TabBar(
                    unselectedLabelColor: Colors.grey,
                    labelColor: widget.topColor,
                    tabs: [
                      Tab(
                        child: Row(
                          children: <Widget>[
                            Icon(Icons.dashboard),
                            Text('Calendar',
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.bold))
                          ],
                        ),
                      ),
                      Tab(
                        child: Row(
                          children: <Widget>[
                            Icon(Icons.event_note),
                            Text('Holiday List',
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.bold))
                          ],
                        ),
                      )
                    ],
                    controller: _tabController,
                    indicatorColor: widget.topColor,
                    indicatorSize: TabBarIndicatorSize.tab,
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height / 1.5,
                  child: TabBarView(
                    controller: _tabController,
                    children: <Widget>[
                      Container(
                        height: 200.0,
                        child: CustomCalendar(
                            selectedYear: int.parse(_chosenCauseListCatValue),
                            listHighlight:
                                convertDateToHighlights(calendarEvents)),
                      ),
                      Container(
                        height: 200.0,
                        child: HolidayList(),
                      ),
                    ],
                  ),
                ),
              ]),
            )));
  }

  List<DateTime> convertDateToHighlights(List calendarEvents) {
    List<DateTime> list = [];
    for (int i = 0; i < calendarEvents.length; i++) {
      String date = calendarEvents[i]['holidayDate'] as String;
      DateTime dateTime1 = DateFormat('d/M/yyyy').parse(date);
      list.add(DateTime.utc(dateTime1.year, dateTime1.month, dateTime1.day));
    }
    return list;
  }
}
