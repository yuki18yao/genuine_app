import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:genuine_app/screens/auth.dart';
import 'package:genuine_app/screens/splash.dart';
import 'package:genuine_app/screens/tabs.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'firebase_options.dart';

final theme = ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(
    //brightness: Brightness.dark,
    seedColor: const Color.fromARGB(255, 0, 131, 79),
  ),
  //textTheme: GoogleFonts.latoTextTheme(),
);

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await dotenv.load(
      fileName: "assets/.env"); // Accessing .env file to obtain the API Key
  runApp(const ProviderScope(
    child: App(),
  ));
}

/// This is the main App class for the genuine app.
class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      theme: theme,
      // Using StreamBuilder to change the screen
      // to display based on user authentication state
      // if the snapshot contains any data, that means
      // the user Authentication Token exists.
      // Therefore, display the home screen.
      // Else, jump to AuthScreen().
      // Also jumps to AuthScreen() when user presses sign-out.
      home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            // Displaying the splash screen while the Firebase is
            // figuring out the user authentication state
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const SplashScreen();
            }
            if (snapshot.hasData) {
              return const TabsScreen();
            }
            return const AuthScreen();
          }),
    );
  }
}
