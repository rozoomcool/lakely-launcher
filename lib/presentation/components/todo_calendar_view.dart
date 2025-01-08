import 'dart:io';

import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class TodoCalendarView extends StatefulWidget {
  const TodoCalendarView({super.key});

  @override
  State<TodoCalendarView> createState() => _TodoCalendarViewState();
}

class _TodoCalendarViewState extends State<TodoCalendarView> {
  CalendarFormat format = CalendarFormat.week;
  DateTime selected = DateTime.now();

  void changeFormat(CalendarFormat value) {
    setState(() {
      format = value;
    });
  }

  void changeDateTime(DateTime old, DateTime neww) {
    setState(() {
      selected = neww;
    });
  }

  @override
  Widget build(BuildContext context) {
    var currentDateTime = DateTime.now();
    return TableCalendar(
      focusedDay: selected,
      firstDay: currentDateTime,
      lastDay: DateTime.utc(currentDateTime.year + 2),
      calendarFormat: format,
      onFormatChanged: changeFormat,
      onDaySelected: changeDateTime,
      availableCalendarFormats: {
        CalendarFormat.week: "Week",
        CalendarFormat.month: "Month"
      },
    );
  }
}
