import 'package:flutter/material.dart';

import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:genuine_app/screens/tabs.dart';

final theme = ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(
    //brightness: Brightness.dark,
    seedColor: const Color.fromARGB(255, 0, 131, 79),
  ),
  //textTheme: GoogleFonts.latoTextTheme(),
);

Future<void> main() async {
  await dotenv.load(fileName: "assets/.env"); // Accessing .env file to obtain the API Key
  runApp(const App());
}

/// This is the main App class for the genuine app.
class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: theme,
      home: const TabsScreen(),
    );
  }
}