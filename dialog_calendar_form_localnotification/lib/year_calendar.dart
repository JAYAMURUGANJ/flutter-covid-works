import 'package:flutter/material.dart';
import 'package:scrolling_years_calendar/scrolling_years_calendar.dart';

class YearCalendar extends StatefulWidget {
  @override
  _YearCalendarState createState() => _YearCalendarState();
}

class _YearCalendarState extends State<YearCalendar> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: DefaultTabController(
      length: 2,
      child: Scaffold(
          appBar: AppBar(
            title: Text('Chennai Calendar'),
            bottom: TabBar(
              tabs: [
                Tab(icon: Icon(Icons.directions_car)),
                Tab(icon: Icon(Icons.directions_bike)),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              CustomCalendar(selectedYear: 2019),
              CustomCalendar(selectedYear: 2020),
            ],
          )),
    ));
  }
}

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
