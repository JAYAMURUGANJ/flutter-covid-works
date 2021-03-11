// import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:scrolling_years_calendar/scrolling_years_calendar.dart';

List calendarEvents = [
  {
    "sno": "1",
    "celebrationName": "Pongal",
    "holidayDate": "15/01/2020",
    "dayName": "Wendesday"
  },
  {
    "sno": "2",
    "celebrationName": "Republic Day",
    "holidayDate": "26/01/2020",
    "dayName": "Sunday"
  },
  {
    "sno": "3",
    "celebrationName": "Mahavir Jayanti",
    "holidayDate": "06/04/2020",
    "dayName": "Monday"
  },
  {
    "sno": "4",
    "celebrationName": "Good Friday",
    "holidayDate": "10/04/2020",
    "dayName": "Friday"
  },
  {
    "sno": "5",
    "celebrationName": "Buddha Purnima",
    "holidayDate": "07/05/2020",
    "dayName": "Thurday"
  },
  {
    "sno": "6",
    "celebrationName": "Independence Day",
    "holidayDate": "15/08/2020",
    "dayName": "Saturday"
  }
];

class CustomCalendar extends StatelessWidget {
  final int selectedYear;
  final List<DateTime> listHighlight;
  CustomCalendar({this.selectedYear, this.listHighlight});

  @override
  Widget build(BuildContext context) {
    return Container(
      //color: Colors.brown[100],
      child: ScrollingYearsCalendar(
        // Required properties
        context: context,
        initialDate: DateTime.utc(selectedYear, 1, 1),
        firstDate: DateTime.utc(selectedYear, 1, 1),
        lastDate: DateTime.utc(selectedYear, 12, 31),
        currentDateColor: Colors.blue,

        // Optional properties
        highlightedDates: listHighlight,
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
      //color: Colors.brown[100],
      child: ListView.builder(
          itemCount: calendarEvents.length,
          itemBuilder: (BuildContext context, int index) {
            return HolidayCard(
              celebrationName: calendarEvents[index]['celebrationName'],
              holidayDate: calendarEvents[index]['holidayDate'],
              dayName: calendarEvents[index]['dayName'],
            );
          }),
    );
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
          color: Theme.of(context).primaryColor,
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                width: 70,
                height: 70,
                child: Image.asset('assets/images/holiday.png'),
              ),
              SizedBox(width: 5),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
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
