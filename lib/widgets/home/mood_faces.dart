import 'package:flutter/material.dart';
import 'package:genuine_app/widgets/journal/input_journal.dart';

/// Class for mood chack-in buttons
/// User will jump to journal input screen 
/// once they click a mood button
class MoodFaces extends StatefulWidget {
  const MoodFaces({super.key});

  @override
  State<MoodFaces> createState() {
    return _MoodFacesState();
  }
}

class _MoodFacesState extends State<MoodFaces> {
  /// Method to display the InputJournal screen once clicked
  onInputJournal() {
    Navigator.push(
        context,
        InputJournal.route());
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(15.0),
      height: 168.0,
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
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'How are you feeling?',
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  color: Colors.white,
                ),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              InkWell(
                onTap: onInputJournal, // Jump to journal input screen once tapped
                child: IconButton(
                  padding: const EdgeInsets.symmetric(),
                  icon: Image.asset('assets/images/very_bad.png'),
                  iconSize: 45,
                  onPressed: () {
                    print('very bad');
                  },
                ),
              ),
              IconButton(
                padding: const EdgeInsets.symmetric(),
                icon: Image.asset('assets/images/poor.png'),
                iconSize: 45,
                onPressed: onInputJournal,
              ),
              IconButton(
                padding: const EdgeInsets.symmetric(),
                icon: Image.asset('assets/images/medium.png'),
                iconSize: 45,
                onPressed: () {
                  print('medium');
                },
              ),
              IconButton(
                padding: const EdgeInsets.symmetric(),
                icon: Image.asset('assets/images/good.png'),
                iconSize: 45,
                onPressed: () {
                  print('good');
                },
              ),
              IconButton(
                padding: const EdgeInsets.symmetric(),
                icon: Image.asset('assets/images/excellent.png'),
                iconSize: 45,
                onPressed: () {
                  print('excellent');
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
