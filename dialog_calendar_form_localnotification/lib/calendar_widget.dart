import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:scrolling_years_calendar/scrolling_years_calendar.dart';

class CustomCalendar extends StatelessWidget {
  final int selectedYear;
  CustomCalendar({this.selectedYear});
  List<DateTime> getHighlightedDates() {
    return List<DateTime>.of([
      DateTime.utc(selectedYear, 7, 24),
      DateTime.utc(selectedYear, 12, 12),
      DateTime.utc(selectedYear, 11, 12)
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ScrollingYearsCalendar(
        // Required properties
        context: context,
        initialDate: DateTime.utc(selectedYear, 1, 1),
        firstDate: DateTime.utc(selectedYear, 1, 1),
        lastDate: DateTime.utc(selectedYear, 12, 31),
        currentDateColor: Colors.blue,

        // Optional properties
        highlightedDates: getHighlightedDates(),
        highlightedDateColor: Colors.deepOrange,
        monthNames: const <String>[
          'Jan',
          'Feb',
          'Mar',
          'Apr',
          'May',
          'Jun',
          'Jul',
          'Aug',
          'Sep',
          'Oct',
          'Nov',
          'Dec',
        ],
        onMonthTap: (int year, int month) => print('Tapped $month/$year'),
      ),
    );
  }
}

class HolidayList extends StatefulWidget {
  @override
  _HolidayListState createState() => _HolidayListState();
}

class _HolidayListState extends State<HolidayList> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: FutureBuilder(
      builder: (context, snapshot) {
        var showData = json.decode(snapshot.data.toString());
        return ListView.builder(
          itemBuilder: (BuildContext context, int index) {
            return HolidayCard(
              celebrationName: showData[index]['celebrationName'],
              holidayDate: showData[index]['holidayDate'],
              dayName: showData[index]['dayName'],
            );
          },
          itemCount: showData.length,
        );
      },
      future:
          DefaultAssetBundle.of(context).loadString("assets/holidaylist.json"),
    ));
  }
}

class HolidayCard extends StatelessWidget {
  final String celebrationName;
  final String holidayDate;
  final String dayName;
  HolidayCard({this.celebrationName, this.dayName, this.holidayDate});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.white,
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Icon(
                Icons.calendar_today,
                color: Colors.green,
                size: 60,
              ),
              Column(
                children: <Widget>[
                  Text(
                    celebrationName,
                    style: TextStyle(fontSize: 20),
                  ),
                  Text(
                    holidayDate,
                    style: TextStyle(fontSize: 18),
                  ),
                  Text(
                    dayName,
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
