import 'package:flutter/material.dart';

/// Class for displaying user input moods in a calendar format
class MoodCalendar extends StatefulWidget {
  const MoodCalendar({super.key});

  @override
  State<MoodCalendar> createState() {
    return _MoodCalendarState();
  }
}

// TODO: Implement features
class _MoodCalendarState extends State<MoodCalendar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(15.0),
      width: double.maxFinite,
      height: 500.0,
      child: Image.asset('assets/images/calendar.png'),
    );
  }
}
