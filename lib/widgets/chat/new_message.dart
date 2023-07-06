import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:genuine_app/models/chat_message_model.dart';
//import 'package:intl/intl.dart';

import 'package:genuine_app/widgets/chat/message_bubble.dart';

/// A class for receiving & displaying user input, 
/// communicating with OpenAI API, 
/// and displaying the response from the API 
class NewMessage extends StatefulWidget {
  const NewMessage({super.key});

  @override
  State<NewMessage> createState() {
    return _NewMessageState();
  }
}

class _NewMessageState extends State<NewMessage> {
  late final OpenAI _openAI; // instantiating OpenAI class
  late bool _isLoading; // boolean class for seeing if the chat is loading. Needed for displaying loading icon to the screen. 

  final _messageController = TextEditingController(); 

  // List of ChatMessage class. ChatMessage contains:
  // 1. final String text;
  // 2. final bool isSentByMe;
  // 3. final DateTime timestamp;
  late List<ChatMessage> _messages; 

  @override
  void initState() {
    _messages = []; // initializing empty list
    _isLoading = false;

    // Initialize ChatGPT SDK
    _openAI = OpenAI.instance.build(
      token: dotenv.env['OPENAI_API_KEY'], // Getting OPENAI_API_KEY from .env file
      baseOption: HttpSetup(
        receiveTimeout: const Duration(seconds: 30),
      ),
    );

    // This tells ChatGPT what his role is
    _handleInitialMessage(
      'You are a digital psychotherapist. Use a tone that is empathetic and humorous. Please send a very short intro message. Reply with questions until the user agrees on your message.',
    );

    super.initState();
  }

  /// Method for handling initial prompt for OpenAI
  Future<void> _handleInitialMessage(String character) async {
    setState(() {
      _isLoading = true;
    });

    final request = ChatCompleteText(
      messages: [
        Map.of({"role": "assistant", "content": character})
      ],
      maxToken: 200,
      model: ChatModel.gptTurbo0301,
    );

    // Storing the response obtained from the HTTP request
    final response = await _openAI.onChatCompletion(request: request);

    // Storing the OpenAI response to the ChatMessage class
    ChatMessage message = ChatMessage(
      text: response!.choices.first.message!.content.trim().replaceAll('"', ''),
      isSentByMe: false,
      timestamp: DateTime.now(),
    );

    setState(() {
      _messages.insert(0, message);
      _isLoading = false;
    });
  }

  /// Method for submitting user input prompt to the OpenAI API
  /// Parameter: String text which is user input text
  Future<void> _submitMessage(String text) async {
    setState(() {
      _isLoading = true;
    });

    _messageController.clear();

    // Storing user input message to the ChatMessage class
    ChatMessage prompt = ChatMessage(
      isSentByMe: true,
      text: text,
      timestamp: DateTime.now(),
    );

    // get out of the method if the user input empty string
    if (text.trim().isEmpty) {
      _isLoading = false;
      return;
    }

    setState(() {
      _messages.insert(0, prompt);
    });

    // Handle ChatGPT request and response
    final request = ChatCompleteText(
      // Append instead of creating new list?
      messages: [
        Map.of({"role": "user", "content": text})
      ],
      maxToken: 200,
      model: ChatModel.gptTurbo0301,
    );
    final response = await _openAI.onChatCompletion(request: request);

    // Add the user received message to the thread
    ChatMessage message = ChatMessage(
      text: response!.choices.first.message!.content.trim(),
      isSentByMe: false,
      timestamp: DateTime.now(),
    );

    setState(() {
      _messages.insert(0, message);
      _isLoading = false;
    });
  }

  // Method for building ListView of messages
  Widget _buildChatList() {
    return Flexible(
      child: ListView.builder(
        padding: const EdgeInsets.only(
          bottom: 40,
          left: 13,
          right: 13,
        ),
        reverse: true,
        itemCount: _messages.length,
        itemBuilder: (_, int index) {
          ChatMessage chatMessage = _messages[index];
          return MessageBubble.next( // Put the message to the MessageBubble class for styling 
            message: chatMessage,
            isMe: chatMessage.isSentByMe,
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 1, bottom: 14),
      child: Column(
        children: [
          // Display circularProgressIndicator while waiting
          if (_isLoading)
            Center(
              child: Container(
                margin: const EdgeInsets.all(20),
                child: const CircularProgressIndicator(),
              ),
            ),
          _buildChatList(), // Call LisView.builder
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _messageController,
                  textCapitalization: TextCapitalization.sentences,
                  autocorrect: true,
                  enableSuggestions: true,
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    hintText: 'Send a message...',
                    enabled: !_isLoading,
                  ),
                ),
              ),
              IconButton(
                color: Theme.of(context).colorScheme.primary,
                icon: const Icon(
                  Icons.send,
                ),
                onPressed: _isLoading
                    ? null
                    : () => _submitMessage(
                          _messageController.text,
                        ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
