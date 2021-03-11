import 'package:flutter/material.dart';

import 'calendar_widget.dart';

List<String> year = [
  '2019',
  '2020',
];
var _chosenCauseListCatValue = year[0];

class MyCalendar extends StatefulWidget {
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
          title: Text('IPAB Calendar', style: TextStyle(color: Colors.black)),
          backgroundColor: Colors.white,
        ),
        body: SingleChildScrollView(
            physics: ClampingScrollPhysics(),
            child: Column(children: <Widget>[
              Container(
                child: Stack(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [Colors.green, Colors.lightGreen]),
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
                    ),
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    color: Colors.white),
                child: TabBar(
                  unselectedLabelColor: Colors.grey,
                  labelColor: Colors.amber,
                  tabs: [
                    Tab(
                      child: Row(
                        children: <Widget>[
                          Icon(Icons.calendar_today),
                          Text('Calendar',
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold))
                        ],
                      ),
                    ),
                    Tab(
                      child: Row(
                        children: <Widget>[
                          Icon(Icons.calendar_view_day),
                          Text('Holiday List',
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold))
                        ],
                      ),
                    )
                  ],
                  controller: _tabController,
                  indicatorColor: Colors.yellow,
                  indicatorSize: TabBarIndicatorSize.tab,
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height / 1.5,
                child: TabBarView(
                  controller: _tabController,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 10.0),
                      height: 200.0,
                      child: CustomCalendar(
                        selectedYear: int.parse(_chosenCauseListCatValue),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 10.0),
                      height: 200.0,
                      child: HolidayList(),
                    ),
                  ],
                ),
              ),
            ])));
  }
}
