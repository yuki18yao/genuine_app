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
      height: 350.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        gradient: const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: <Color>[
            Color(0xff067d68),
            Color(0xff50d5b7),
          ],
        ),
      ),
    );
  }
}
