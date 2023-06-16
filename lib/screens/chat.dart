import 'package:flutter/material.dart';
import 'package:genuine_app/widgets/chat/new_message.dart';

/// Class for displaying the ChatScreen
/// Returns: Container with NewMessage() as a child
///          NewMessage() returns Column that is wraped with Padding() with 
///             1. ListView.builder -> for displaying messages from the user and the ChatGPT response
///             2. Row -> for displaying the textfield and the send button 
class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Widget content = Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: <Color>[
            Color(0xff067d68),
            Color(0xff50d5b7),
          ],
          tileMode: TileMode.mirror,
        ),
      ),
      child: const NewMessage(),
    );

    return content;
  }
}
