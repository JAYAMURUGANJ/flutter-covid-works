import 'package:flutter/material.dart';
import 'package:flutter_calendar/flutter_calendar.dart';

class MonthCalendar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(),
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text('Flutter Calendar'),
        ),
        body: new Container(
          margin: new EdgeInsets.symmetric(
            horizontal: 5.0,
            vertical: 10.0,
          ),
          child: new ListView(
            shrinkWrap: true,
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: Colors.green[100],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: new Calendar(
                    onSelectedRangeChange: (range) =>
                        print("Range is ${range.item1}, ${range.item2}"),
                    isExpandable: true,
                    dayBuilder: (BuildContext context, DateTime day) {
                      return new InkWell(
                        onTap: () => print("OnTap $day"),
                        child: new Container(
                          decoration: new BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              color: Colors.green[200],
                              border: new Border.all(color: Colors.white)),
                          child: Center(
                            child: new Text(
                              day.day.toString(),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
