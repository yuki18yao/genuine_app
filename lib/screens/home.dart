import 'package:flutter/material.dart';

import '../widgets/home/mood_calendar.dart';
import '../widgets/home/mood_faces.dart';

/// Class for displaying MoodFaces() and MoodCalendar()
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Widget content = Container(
      child: const Column( // change column to scrollable widget since the page does not fit in one screen.
        children: [
          MoodFaces(),
          MoodCalendar(),
        ],
      ),
    );
    return content;
  }
}
