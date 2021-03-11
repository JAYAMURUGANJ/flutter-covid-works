import 'package:flutter/material.dart';
import 'package:flutter_calendar/flutter_calendar.dart';

class MonthCalendar extends StatelessWidget {
  void handleNewDate(date) {
    print("handleNewDate $date");
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      margin: new EdgeInsets.symmetric(
        horizontal: 5.0,
        vertical: 10.0,
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: Theme.of(context).dividerColor,
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: new Calendar(
            onSelectedRangeChange: (range) =>
                print("Range is $range.item1, $range.item2"),
            onDateSelected: (date) => handleNewDate(date),
            isExpandable: true,
            dayBuilder: (BuildContext context, DateTime day) {
              return new InkWell(
                onTap: () => print("OnTap $day"),
                child: new Container(
                  decoration: new BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: Theme.of(context).accentColor,
                      border: new Border.all(
                          color: Theme.of(context).primaryColor)),
                  child: Center(
                    child: new Text(
                      day.day.toString(),
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
