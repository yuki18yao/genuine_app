import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:genuine_app/screens/chat.dart';
import 'package:genuine_app/screens/journal.dart';
import 'package:genuine_app/screens/home.dart';
import 'package:genuine_app/screens/explore.dart';
import 'package:genuine_app/screens/settings.dart';

/// Class which handles scene switching from the
/// NavigationBar buttons
class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});

  @override
  State<TabsScreen> createState() {
    return _TabsScreenState();
  }
}

class _TabsScreenState extends State<TabsScreen> {
  int _selectedPageIndex = 2; // Index to point to each pages

  /// Method that takes the index and stores it to
  /// the _selectedPageIndex
  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  /// build method that returns Scaffold
  /// with each page that is selected
  @override
  Widget build(BuildContext context) {
    Widget activePage = const HomeScreen(); // Set initial activePage as HomeScreen
    var activePageTitle = 'Home'; // Set initial activePageTitle as 'Home'

    /// Determine which page to show based on
    /// the index of _selectedPageIndex
    if (_selectedPageIndex == 0) {
      activePage = const ChatScreen();
      activePageTitle = 'AI Chatbot';
    }
    if (_selectedPageIndex == 1) {
      activePage = const JournalScreen();
      activePageTitle = 'Journal';
    }
    if (_selectedPageIndex == 2) {
      activePage = const HomeScreen();
      activePageTitle = 'Home';
    }
    if (_selectedPageIndex == 3) {
      activePage = const ExploreScreen();
      activePageTitle = 'Explore';
    }
    if (_selectedPageIndex == 4) {
      activePage = const SettingsScreen();
      activePageTitle = 'Settings';
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff067d68),
        title: Text(
          activePageTitle,
          style: const TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                FirebaseAuth.instance
                    .signOut(); // Sign out user when the button is pressed
              },
              icon: const Icon(
                Icons.exit_to_app,
                color: Colors.white,
              ))
        ],
      ),
      body: activePage, // set the body to the activePage selected
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: const Color.fromARGB(255, 4, 159, 89),
        unselectedItemColor: Colors.grey,
        onTap: _selectPage,
        currentIndex: _selectedPageIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            label: 'Chat',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.groups),
            label: 'Journal',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.video_library),
            label: 'Explore',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}
